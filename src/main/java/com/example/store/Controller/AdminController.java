package com.example.store.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.store.*;
import com.example.store.Model.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Controller
public class AdminController {

    @Autowired
    private ProduitRepository produitRepository;
    @Autowired
    private CategorieRepository categorieRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CommandeRepository commandeRepository;
    @Autowired
    private VisitRepository visitRepository;
    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private NotificationRepository notificationRepository;
    @Autowired
    private AvisRepository avisRepository;

    @Value("${store.upload-dir:uploads}")
    private String uploadDir;

    private static final Logger log = LoggerFactory.getLogger(AdminController.class);

    @GetMapping("/admin")
    public String adminIndex() {
        return "redirect:/admin/clients";
    }

    // ---------- CLIENTS ----------
    @GetMapping("/admin/clients")
    public String clients(ModelMap model) {
        List<User> clients = userRepository.findByRoleOrderByFullnameAsc("USER");
        Map<Long, java.time.LocalDateTime> lastVisitByUser = new HashMap<>();
        for (User u : clients) {
            visitRepository.findTopByUserOrderByVisitedAtDesc(u)
                    .ifPresent(v -> lastVisitByUser.put(u.getId(), v.getVisitedAt()));
        }
        model.addAttribute("clients", clients);
        model.addAttribute("lastVisitByUser", lastVisitByUser);
        return "admin_clients";
    }

    // ---------- COMMANDES ----------
    @GetMapping("/admin/commandes")
    public String commandes(@RequestParam(value = "all", required = false) Boolean all, ModelMap model) {
        boolean showAll = Boolean.TRUE.equals(all);
        List<Reservation> reservations;
        if (showAll) {
            reservations = reservationRepository.findAllWithCommandesAndUserByOrderByDateCreationDesc();
        } else {
            reservations = reservationRepository.findRecentWithCommandesAndUser(java.time.LocalDateTime.now().minusDays(7));
        }
        model.addAttribute("reservations", reservations != null ? reservations : List.of());
        model.addAttribute("showAll", showAll);
        return "admin_commandes";
    }

    @PostMapping("/admin/reservation/accept")
    public String accepterReservation(@RequestParam("reservationId") Long reservationId,
                                      @RequestParam(value = "message", required = false) String message) {
        Reservation reservation = reservationRepository.findById(reservationId).orElse(null);
        if (reservation != null && reservation.getUser() != null) {
            reservation.setStatus(Reservation.Status.CONFIRMEE);
            reservationRepository.save(reservation);
            Notification notif = new Notification();
            notif.setUser(reservation.getUser());
            notif.setReservation(reservation);
            notif.setType(Notification.Type.ACCEPTEE);
            notif.setMessage(message != null ? message.trim() : "Votre commande a été acceptée.");
            notificationRepository.save(notif);
        }
        return "redirect:/admin/commandes";
    }

    @PostMapping("/admin/reservation/refuse")
    public String refuserReservation(@RequestParam("reservationId") Long reservationId,
                                     @RequestParam(value = "message", required = false) String message) {
        Reservation reservation = reservationRepository.findById(reservationId).orElse(null);
        if (reservation != null && reservation.getUser() != null) {
            reservation.setStatus(Reservation.Status.ANNULEE);
            reservationRepository.save(reservation);
            Notification notif = new Notification();
            notif.setUser(reservation.getUser());
            notif.setReservation(reservation);
            notif.setType(Notification.Type.REFUSEE);
            notif.setMessage(message != null ? message.trim() : "Votre commande a été refusée.");
            notificationRepository.save(notif);
        }
        return "redirect:/admin/commandes";
    }

    // ---------- CATALOGUE (catégories + produits) ----------
    @GetMapping("/admin/catalogue")
    public String catalogue(ModelMap model) {
        List<Categorie> categories = categorieRepository.findAllByOrderByNameAsc();
        List<Produit> produits = produitRepository.findAllWithCategorie();
        model.addAttribute("categories", categories);
        model.addAttribute("produitList", produits);
        log.info("GET /admin/catalogue — {} catégories, {} produits", categories.size(), produits.size());
        return "admin_catalogue";
    }

    // ---------- CATÉGORIES (page dédiée : liste, ajout, modification, suppression, image) ----------
    @GetMapping("/admin/categories")
    public String categories(ModelMap model) {
        List<Categorie> categories = categorieRepository.findAllByOrderByNameAsc();
        model.addAttribute("categories", categories);
        log.info("GET /admin/categories — {} catégories", categories.size());
        return "admin_categories";
    }

    @PostMapping("/admin/categorie/add")
    public String ajouterCategorie(@RequestParam String name,
                                   @RequestParam(value = "imageUrl", required = false) String imageUrl,
                                   @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {
        if (StringUtils.hasText(name)) {
            Categorie c = new Categorie();
            c.setName(name.trim());
            String img = resolveImageUrl(imageUrl, imageFile);
            if (StringUtils.hasText(img)) {
                c.setImageUrl(img);
            }
            categorieRepository.save(c);
            log.info("POST /admin/categorie/add — catégorie créée: {}", name.trim());
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/admin/categorie/edit")
    public String editerCategorie(@RequestParam Long id, ModelMap model) {
        Categorie cat = categorieRepository.findById(id).orElse(null);
        if (cat == null) {
            return "redirect:/admin/categories";
        }
        model.addAttribute("categorie", cat);
        return "admin_categorie_edit";
    }

    @PostMapping("/admin/categorie/update")
    public String mettreAJourCategorie(@RequestParam Long id,
                                      @RequestParam String name,
                                      @RequestParam(value = "imageUrl", required = false) String imageUrl,
                                      @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {
        Categorie cat = categorieRepository.findById(id).orElse(null);
        if (cat == null) {
            return "redirect:/admin/categories";
        }
        if (StringUtils.hasText(name)) {
            cat.setName(name.trim());
        }
        String img = resolveImageUrl(imageUrl, imageFile);
        if (StringUtils.hasText(img)) {
            cat.setImageUrl(img);
        }
        categorieRepository.save(cat);
        log.info("POST /admin/categorie/update — id={} nom={}", id, name);
        return "redirect:/admin/categories";
    }

    @PostMapping("/admin/categorie/delete")
    public String supprimerCategorie(@RequestParam Long id) {
        categorieRepository.findById(id).ifPresent(cat -> {
            String nomCat = cat.getName();
            List<Produit> produits = produitRepository.findByCategorieOrderByNameAsc(cat);
            for (Produit p : produits) {
                avisRepository.deleteAll(avisRepository.findByProduitId(p.getId()));
                for (Commande c : commandeRepository.findByProduit(p)) {
                    c.setProduitName(p.getName());
                    c.setProduitPrice(p.getPrice());
                    c.setProduit(null);
                    commandeRepository.save(c);
                }
                produitRepository.delete(p);
            }
            categorieRepository.delete(cat);
            log.info("POST /admin/categorie/delete - id={} nom={} ({} produits supprimes)", id, nomCat, produits.size());
        });
        return "redirect:/admin/categories";
    }

    @PostMapping("/admin/produit/add")
    public String ajouterProduit(@RequestParam String name,
                                 @RequestParam Double price,
                                 @RequestParam(value = "description", required = false) String description,
                                 @RequestParam(value = "categorieId", required = false) Long categorieId,
                                 @RequestParam(value = "taillesDisponibles", required = false) String taillesDisponibles,
                                 @RequestParam(value = "urlImage", required = false) String urlImage,
                                 @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                                 @RequestParam(value = "urlImage2", required = false) String urlImage2,
                                 @RequestParam(value = "imageFile2", required = false) MultipartFile imageFile2,
                                 @RequestParam(value = "urlImage3", required = false) String urlImage3,
                                 @RequestParam(value = "imageFile3", required = false) MultipartFile imageFile3,
                                 @RequestParam(value = "urlImage4", required = false) String urlImage4,
                                 @RequestParam(value = "imageFile4", required = false) MultipartFile imageFile4) {
        String img1 = resolveImageUrl(urlImage, imageFile);
        if (!StringUtils.hasText(img1)) {
            return "redirect:/admin/catalogue?error=min1image";
        }
        Produit produit = new Produit();
        produit.setName(name);
        produit.setPrice(price);
        produit.setDescription(description);
        produit.setTaillesDisponibles(taillesDisponibles);
        produit.setUrlImage(img1);
        produit.setUrlImage2(resolveImageUrl(urlImage2, imageFile2));
        produit.setUrlImage3(resolveImageUrl(urlImage3, imageFile3));
        produit.setUrlImage4(resolveImageUrl(urlImage4, imageFile4));
        produit.setVisible(true);
        if (categorieId != null) {
            categorieRepository.findById(categorieId).ifPresent(produit::setCategorie);
        }
        produitRepository.save(produit);
        log.info("POST /admin/produit/add — produit créé: {} (id={})", name, produit.getId());
        return "redirect:/admin/catalogue";
    }

    /** Ajouter un produit par URL uniquement (sans upload fichier) — contourne HTTP 413. */
    @PostMapping("/admin/produit/add-by-url")
    public String ajouterProduitByUrl(@RequestParam String name,
                                      @RequestParam Double price,
                                      @RequestParam(value = "description", required = false) String description,
                                      @RequestParam(value = "categorieId", required = false) Long categorieId,
                                      @RequestParam(value = "taillesDisponibles", required = false) String taillesDisponibles,
                                      @RequestParam(value = "urlImage", required = false) String urlImage,
                                      @RequestParam(value = "urlImage2", required = false) String urlImage2,
                                      @RequestParam(value = "urlImage3", required = false) String urlImage3,
                                      @RequestParam(value = "urlImage4", required = false) String urlImage4) {
        String img1 = StringUtils.hasText(urlImage) ? urlImage.trim() : null;
        if (img1 == null) {
            return "redirect:/admin/catalogue?error=min1image";
        }
        Produit produit = new Produit();
        produit.setName(name);
        produit.setPrice(price);
        produit.setDescription(description);
        produit.setTaillesDisponibles(taillesDisponibles);
        produit.setUrlImage(img1);
        produit.setUrlImage2(StringUtils.hasText(urlImage2) ? urlImage2.trim() : null);
        produit.setUrlImage3(StringUtils.hasText(urlImage3) ? urlImage3.trim() : null);
        produit.setUrlImage4(StringUtils.hasText(urlImage4) ? urlImage4.trim() : null);
        produit.setVisible(true);
        if (categorieId != null) {
            categorieRepository.findById(categorieId).ifPresent(produit::setCategorie);
        }
        produitRepository.save(produit);
        return "redirect:/admin/catalogue";
    }

    @GetMapping("/admin/produit/edit")
    public String editerProduit(@RequestParam Long id, ModelMap model) {
        Produit produit = produitRepository.findByIdWithCategorie(id).orElse(null);
        if (produit == null) {
            return "redirect:/admin/catalogue";
        }
        model.addAttribute("produit", produit);
        model.addAttribute("categories", categorieRepository.findAllByOrderByNameAsc());
        return "admin_produit_edit";
    }

    @PostMapping("/admin/produit/update")
    public String mettreAJourProduit(@RequestParam Long id,
                                    @RequestParam(value = "name", required = false) String name,
                                    @RequestParam(value = "price", required = false) String priceStr,
                                    @RequestParam(value = "description", required = false) String description,
                                    @RequestParam(value = "categorieId", required = false) Long categorieId,
                                    @RequestParam(value = "taillesDisponibles", required = false) String taillesDisponibles,
                                    @RequestParam(value = "urlImage", required = false) String urlImage,
                                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                                    @RequestParam(value = "urlImage2", required = false) String urlImage2,
                                    @RequestParam(value = "imageFile2", required = false) MultipartFile imageFile2,
                                    @RequestParam(value = "urlImage3", required = false) String urlImage3,
                                    @RequestParam(value = "imageFile3", required = false) MultipartFile imageFile3,
                                    @RequestParam(value = "urlImage4", required = false) String urlImage4,
                                    @RequestParam(value = "imageFile4", required = false) MultipartFile imageFile4) {
        Produit produit = produitRepository.findById(id).orElse(null);
        if (produit == null) {
            return "redirect:/admin/catalogue";
        }
        try {
            if (StringUtils.hasText(name)) {
                produit.setName(name.trim());
            }
            if (StringUtils.hasText(priceStr)) {
                String normalized = priceStr.trim().replace(',', '.');
                produit.setPrice(Double.valueOf(normalized));
            }
            produit.setDescription(description != null ? description.trim() : null);
            produit.setTaillesDisponibles(StringUtils.hasText(taillesDisponibles) ? taillesDisponibles.trim() : null);

            String img1 = resolveImageUrl(urlImage, imageFile);
            if (StringUtils.hasText(img1)) {
                produit.setUrlImage(img1);
            }
            String img2 = resolveImageUrl(urlImage2, imageFile2);
            if (StringUtils.hasText(img2)) {
                produit.setUrlImage2(img2);
            }
            String img3 = resolveImageUrl(urlImage3, imageFile3);
            if (StringUtils.hasText(img3)) {
                produit.setUrlImage3(img3);
            }
            String img4 = resolveImageUrl(urlImage4, imageFile4);
            if (StringUtils.hasText(img4)) {
                produit.setUrlImage4(img4);
            }
            if (categorieId != null) {
                categorieRepository.findById(categorieId).ifPresent(produit::setCategorie);
            } else {
                produit.setCategorie(null);
            }
            produitRepository.save(produit);
            log.info("POST /admin/produit/update — produit id={} mis à jour", id);
            return "redirect:/admin/catalogue";
        } catch (NumberFormatException e) {
            log.warn("Erreur parsing prix pour produit id={}", id, e);
            return "redirect:/admin/produit/edit?id=" + id + "&error=price";
        } catch (Exception e) {
            log.error("Erreur mise à jour produit id=" + id, e);
            return "redirect:/admin/produit/edit?id=" + id + "&error=update";
        }
    }

    /** Upload d'une seule image (appelé en AJAX) — évite 413 sur le formulaire complet. */
    @PostMapping("/admin/upload-image")
    @ResponseBody
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile file) {
        String url = resolveImageUrl(null, file);
        if (url == null) {
            return ResponseEntity.badRequest().body("");
        }
        return ResponseEntity.ok(url);
    }

    private String resolveImageUrl(String imageUrl, MultipartFile imageFile) {
        try {
            if (imageFile != null && !imageFile.isEmpty()) {
                Path basePath = Paths.get(uploadDir).toAbsolutePath();
                if (!Files.exists(basePath)) {
                    Files.createDirectories(basePath);
                }
                String originalFilename = StringUtils.cleanPath(imageFile.getOriginalFilename());
                if (originalFilename == null || originalFilename.isEmpty()) {
                    originalFilename = "image";
                }
                String filename = System.currentTimeMillis() + "_" + originalFilename;
                Path destination = basePath.resolve(filename);
                Files.copy(imageFile.getInputStream(), destination);
                return "/uploads/" + filename;
            }
        } catch (IOException e) {
            log.warn("Upload image échoué: {}", e.getMessage());
        }
        return StringUtils.hasText(imageUrl) ? imageUrl : null;
    }

    @PostMapping("/admin/produit/toggle-visibility")
    public String toggleVisibilityProduit(@RequestParam Long id) {
        produitRepository.findById(id).ifPresent(p -> {
            p.setVisible(!p.isVisible());
            produitRepository.save(p);
            log.info("POST /admin/produit/toggle-visibility — id={} visible={}", id, p.isVisible());
        });
        return "redirect:/admin/catalogue";
    }

    @PostMapping("/admin/produit/delete")
    public String supprimerProduit(@RequestParam Long id) {
        Produit produit = produitRepository.findById(id).orElse(null);
        if (produit != null) {
            try {
                avisRepository.deleteAll(avisRepository.findByProduitId(id));
                for (Commande c : commandeRepository.findByProduit(produit)) {
                    c.setProduitName(produit.getName());
                    c.setProduitPrice(produit.getPrice());
                    c.setProduit(null);
                    commandeRepository.save(c);
                }
                String nom = produit.getName();
                produitRepository.delete(produit);
                log.info("POST /admin/produit/delete - produit supprime id={} nom={}", id, nom);
            } catch (Exception e) {
                log.error("POST /admin/produit/delete - erreur id={}", id, e);
            }
        }
        return "redirect:/admin/catalogue";
    }
}
