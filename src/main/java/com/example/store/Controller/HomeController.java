package com.example.store.Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.PageRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.store.*;
import com.example.store.Model.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController {

    @Autowired
    private ProduitRepository produitRepository;
    @Autowired
    private CategorieRepository categorieRepository;
    @Autowired
    private AvisRepository avisRepository;
    @Autowired
    private VisitRepository visitRepository;
    @Autowired
    private UserRepository userRepository;

    private static final Logger log = LoggerFactory.getLogger(HomeController.class);

    @GetMapping("/")
    public String root(ModelMap model) {
        return "redirect:/home";
    }

    private void recordVisit(HttpServletRequest request, HttpSession session) {
        try {
            Visit visit = new Visit();
            visit.setVisitedAt(java.time.LocalDateTime.now());
            visit.setIp(request.getRemoteAddr() != null ? request.getRemoteAddr() : "");
            visit.setUserAgent(request.getHeader("User-Agent") != null ? request.getHeader("User-Agent") : "");
            Object userObj = session.getAttribute("user");
            if (userObj instanceof User) {
                User sessionUser = (User) userObj;
                userRepository.findById(sessionUser.getId()).ifPresent(visit::setUser);
            }
            visitRepository.save(visit);
        } catch (Exception e) {
            log.debug("Enregistrement visite échoué: {}", e.getMessage());
        }
    }

    /** Accueil : affiche les catégories. L'utilisateur choisit une catégorie pour voir les produits. */
    @GetMapping("/home")
    public String home(ModelMap model, HttpServletRequest request, HttpSession session) {
        try {
            recordVisit(request, session);
            List<Categorie> categories = categorieRepository.findAllByOrderByNameAsc();
            model.addAttribute("categories", categories != null ? categories : List.of());
            List<Produit> latestProduits = produitRepository.findLatestVisibleProduits(PageRequest.of(0, 6));
            model.addAttribute("latestProduits", latestProduits != null ? latestProduits : List.of());
            log.info("GET /home — {} catégories", categories != null ? categories.size() : 0);
            return "home";
        } catch (Exception e) {
            log.warn("GET /home erreur: {}", e.getMessage());
            model.addAttribute("categories", List.<Categorie>of());
            model.addAttribute("latestProduits", List.<Produit>of());
            return "home";
        }
    }

    /** Produits d'une catégorie. */
    @GetMapping("/categorie")
    public String categorie(@RequestParam(value = "id", required = false) Long id, ModelMap model, HttpServletRequest request, HttpSession session) {
        try {
            recordVisit(request, session);
            if (id == null) {
                return "redirect:/home";
            }
            Categorie cat = categorieRepository.findById(id).orElse(null);
            if (cat == null) {
                return "redirect:/home";
            }
            List<Produit> produits = produitRepository.findVisibleByCategorieIdOrderByNameAsc(id);
            model.addAttribute("categorie", cat);
            model.addAttribute("produits", produits != null ? produits : List.of());
            log.info("GET /categorie id={} — {} produits", id, produits != null ? produits.size() : 0);
            return "categorie";
        } catch (Exception e) {
            log.warn("GET /categorie id={} erreur: {}", id, e.getMessage());
            return "redirect:/home";
        }
    }

    /** Détail d'un produit : infos, galerie, avis (étoiles + commentaires), formulaire pour laisser un avis. */
    @GetMapping("/produit")
    public String produit(@RequestParam(value = "id", required = false) Long id, ModelMap model, HttpServletRequest request, HttpSession session) {
        log.info("[PRODUIT] GET /produit id={}", id);
        try {
            log.debug("[PRODUIT] etape 1: recordVisit");
            recordVisit(request, session);
            if (id == null) {
                log.warn("[PRODUIT] id null -> redirect /home");
                return "redirect:/home";
            }
            log.debug("[PRODUIT] etape 2: findByIdWithCategorie id={}", id);
            Produit produit = produitRepository.findByIdWithCategorie(id).orElse(null);
            if (produit == null || !produit.isVisible()) {
                log.warn("[PRODUIT] produit null ou invisible id={} -> redirect /home", id);
                return "redirect:/home";
            }
            log.debug("[PRODUIT] etape 3: build produitView");
            Map<String, Object> produitView = new LinkedHashMap<>();
            produitView.put("id", produit.getId());
            produitView.put("name", produit.getName());
            produitView.put("price", produit.getPrice());
            produitView.put("description", produit.getDescription());
            produitView.put("urlImage", produit.getUrlImage() != null ? produit.getUrlImage() : "");
            produitView.put("urlImage2", produit.getUrlImage2());
            produitView.put("urlImage3", produit.getUrlImage3());
            produitView.put("urlImage4", produit.getUrlImage4());
            produitView.put("taillesDisponibles", produit.getTaillesDisponibles());
            produitView.put("categorieId", produit.getCategorie() != null ? produit.getCategorie().getId() : null);
            produitView.put("categorieName", produit.getCategorie() != null ? produit.getCategorie().getName() : null);

            log.debug("[PRODUIT] etape 4: findByProduitOrderByCreatedAtDesc");
            List<Avis> avisList = avisRepository.findByProduitOrderByCreatedAtDesc(produit);
            if (avisList == null) {
                avisList = List.of();
            }
            log.debug("[PRODUIT] etape 5: noteMoyenne, nb avis={}", avisList.size());
            double noteMoyenne = avisList.stream()
                    .filter(a -> a.getNote() != null)
                    .mapToInt(Avis::getNote)
                    .average()
                    .orElse(0);
            if (Double.isNaN(noteMoyenne)) {
                noteMoyenne = 0;
            }
            int noteMoyenneArrondie = (int) Math.round(noteMoyenne);

            log.debug("[PRODUIT] etape 6: build avisForView");
            List<Map<String, Object>> avisForView = new ArrayList<>();
            for (Avis a : avisList) {
                Map<String, Object> row = new LinkedHashMap<>();
                try {
                    row.put("displayName", a.getDisplayName());
                } catch (Exception ex) {
                    log.debug("[PRODUIT] getDisplayName failed avis id={}: {}", a.getId(), ex.getMessage());
                    row.put("displayName", a.getAuteurNom() != null && !a.getAuteurNom().isBlank() ? a.getAuteurNom() : "Anonyme");
                }
                row.put("note", a.getNote());
                row.put("commentaire", a.getCommentaire());
                java.time.LocalDateTime ldt = a.getCreatedAt() != null ? a.getCreatedAt() : java.time.LocalDateTime.now();
                row.put("createdAt", Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant()));
                avisForView.add(row);
            }

            log.debug("[PRODUIT] etape 7: recommandations");
            List<Produit> recommandations = new ArrayList<>();
            if (produit.getCategorie() != null && produit.getCategorie().getId() != null) {
                List<Produit> mêmeCategorie = produitRepository.findVisibleByCategorieIdOrderByNameAsc(produit.getCategorie().getId());
                if (mêmeCategorie != null) {
                    for (Produit p : mêmeCategorie) {
                        if (!p.getId().equals(produit.getId())) {
                            recommandations.add(p);
                        }
                        if (recommandations.size() >= 6) {
                            break;
                        }
                    }
                }
            }

            log.debug("[PRODUIT] etape 8: addAttribute modele");
            model.addAttribute("produit", produitView);
            model.addAttribute("avisList", avisForView);
            model.addAttribute("noteMoyenne", noteMoyenne);
            model.addAttribute("noteMoyenneArrondie", noteMoyenneArrondie);
            model.addAttribute("recoProduits", recommandations);
            model.addAttribute("user", session.getAttribute("user"));
            log.info("[PRODUIT] GET /produit id={} OK -> vue produit ({} avis)", id, avisList.size());
            return "produit";
        } catch (Exception e) {
            log.error("[PRODUIT] GET /produit id={} ERREUR: {} - {}", id, e.getClass().getSimpleName(), e.getMessage(), e);
            return "redirect:/home";
        }
    }

    /** Recherche produit par nom (barre de recherche navbar). */
    @GetMapping("/recherche")
    public String recherche(@RequestParam(value = "q", required = false) String query,
                            ModelMap model,
                            HttpServletRequest request,
                            HttpSession session) {
        recordVisit(request, session);
        String trimmed = query != null ? query.trim() : "";
        if (trimmed.isEmpty()) {
            return "redirect:/home";
        }
        List<Produit> results = produitRepository.searchVisibleByNameContaining(trimmed);
        model.addAttribute("query", trimmed);
        model.addAttribute("resultats", results != null ? results : List.of());
        return "recherche";
    }

    /** Poster un avis (note 1–5 + commentaire). */
    @PostMapping("/avis/add")
    public String ajouterAvis(@RequestParam Long produitId,
                              @RequestParam(value = "note", required = false) Integer note,
                              @RequestParam(value = "commentaire", required = false) String commentaire,
                              @RequestParam(value = "auteurNom", required = false) String auteurNom,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        if (produitId == null) {
            return "redirect:/home";
        }
        if (note == null || note < 1 || note > 5) {
            log.warn("POST /avis/add produitId={} — note invalide: {}", produitId, note);
            redirectAttributes.addAttribute("error", "note");
            return "redirect:/produit?id=" + produitId + "&error=note#avis";
        }
        if (!produitRepository.existsById(produitId)) {
            log.warn("POST /avis/add produitId={} — produit inexistant", produitId);
            return "redirect:/home";
        }
        Avis avis = new Avis();
        avis.setProduit(produitRepository.getReferenceById(produitId));
        avis.setNote(note);
        avis.setCommentaire(commentaire != null ? commentaire.trim() : null);
        Object userObj = session.getAttribute("user");
        if (userObj instanceof User) {
            User sessionUser = (User) userObj;
            userRepository.findById(sessionUser.getId()).ifPresent(avis::setUser);
        } else {
            avis.setAuteurNom(auteurNom != null ? auteurNom.trim() : null);
        }
        avisRepository.save(avis);
        redirectAttributes.addFlashAttribute("avisAjoute", true);
        log.info("POST /avis/add — avis enregistré produitId={} note={}", produitId, note);
        return "redirect:/produit?id=" + produitId + "#avis";
    }
}
