package com.example.fdarnacuisine.Controller;

import com.example.fdarnacuisine.CommandeRepository;
import com.example.fdarnacuisine.Model.Commande;
import com.example.fdarnacuisine.Model.Produit;
import com.example.fdarnacuisine.Model.User;
import com.example.fdarnacuisine.ProduitRepository;
import com.example.fdarnacuisine.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@Controller
public class CommandeController {

    private static final Logger log = LoggerFactory.getLogger(CommandeController.class);

    @Autowired
    private CommandeRepository commandeRepository;

    @Autowired
    private ProduitRepository produitRepository;

    @Autowired
    private UserRepository userRepository;

    private User getManagedUser(HttpSession session) {
        Object u = session.getAttribute("user");
        if (!(u instanceof User)) return null;
        return userRepository.findById(((User) u).getId()).orElse(null);
    }

    @PostMapping("/commande")
    public String ajouterCommande(@RequestParam("produitId") Long produitId,
                                  @RequestParam("quantite") Integer quantite,
                                  @RequestParam(value = "btnAction", required = false) String btnAction,
                                  HttpSession session) {

        User user = getManagedUser(session);
        if (user == null) {
            log.warn("POST /commande — utilisateur non connecté");
            return "redirect:/login";
        }

        Produit produit = produitRepository.findById(produitId).orElse(null);
        if (produit == null || quantite == null || quantite <= 0) {
            log.warn("POST /commande — produitId={} ou quantite invalide", produitId);
            return "redirect:/home";
        }

        Commande existing = commandeRepository
                .findByUserAndProduitAndStatusAndReservationIsNull(user, produit, Commande.Status.EN_PREPARATION);

        if (existing != null) {
            int newQty = existing.getQuantity() + quantite;
            existing.setQuantity(newQty);
            existing.setTotal(newQty * produit.getPrice());
            commandeRepository.save(existing);
        } else {
            Commande commande = new Commande();
            commande.setUser(user);
            commande.setProduit(produit);
            commande.setQuantity(quantite);
            commande.setStatus(Commande.Status.EN_PREPARATION);
            commande.setTotal(quantite * produit.getPrice());
            commandeRepository.save(commande);
        }

        log.info("POST /commande — userId={} produitId={} quantite={}", user.getId(), produitId, quantite);
        if ("commander".equals(btnAction)) {
            return "redirect:/commandes";
        }
        return "redirect:/home";
    }

    @GetMapping("/commandes")
    public String listerCommandes(HttpSession session, ModelMap model) {
        User user = getManagedUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        List<Commande> commandes = commandeRepository
                .findByUserAndStatusAndReservationIsNull(user, Commande.Status.EN_PREPARATION);
        double total = commandes.stream()
                .mapToDouble(c -> c.getTotal() != null ? c.getTotal() : 0.0)
                .sum();

        model.addAttribute("commandes", commandes);
        model.addAttribute("total", total);
        log.info("GET /commandes — userId={} {} article(s)", user.getId(), commandes.size());
        return "Commandes";
    }

    @PostMapping("/commandes/update")
    public String mettreAJourCommande(@RequestParam("id") Long id,
                                     @RequestParam("quantite") Integer quantite,
                                     HttpSession session) {
        User user = getManagedUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        Commande commande = commandeRepository.findById(id).orElse(null);
        if (commande != null && commande.getUser() != null && commande.getUser().getId().equals(user.getId())
                && quantite != null && quantite > 0) {
            commande.setQuantity(quantite);
            if (commande.getProduit() != null && commande.getProduit().getPrice() != null) {
                commande.setTotal(quantite * commande.getProduit().getPrice());
            }
            commandeRepository.save(commande);
        }

        return "redirect:/commandes";
    }

    @PostMapping("/commandes/delete")
    public String supprimerCommande(@RequestParam("id") Long id,
                                   HttpSession session) {
        User user = getManagedUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        Commande commande = commandeRepository.findById(id).orElse(null);
        if (commande != null && commande.getUser() != null && commande.getUser().getId().equals(user.getId())) {
            commandeRepository.delete(commande);
        }

        return "redirect:/commandes";
    }
}
