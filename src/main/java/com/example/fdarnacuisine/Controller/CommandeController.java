package com.example.fdarnacuisine.Controller;

import com.example.fdarnacuisine.CommandeRepository;
import com.example.fdarnacuisine.Model.Commande;
import com.example.fdarnacuisine.Model.Repas;
import com.example.fdarnacuisine.Model.User;
import com.example.fdarnacuisine.RepasRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class CommandeController {

    @Autowired
    private CommandeRepository commandeRepository;

    @Autowired
    private RepasRepository repasRepository;

    @PostMapping("/commande")
    public String ajouterCommande(@RequestParam("repasId") Long repasId,
                                  @RequestParam("quantite") Integer quantite,
                                  @RequestParam(value = "btnAction", required = false) String btnAction,
                                  HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Repas repas = repasRepository.findById(repasId).orElse(null);
        if (repas == null || quantite == null || quantite <= 0) {
            return "redirect:/home";
        }

        Commande existing = commandeRepository
                .findByUserAndRepasAndStatus(user, repas, Commande.Status.EN_PREPARATION);

        if (existing != null) {
            int newQty = existing.getQuantity() + quantite;
            existing.setQuantity(newQty);
            existing.setTotal(newQty * repas.getPrice());
            commandeRepository.save(existing);
        } else {
            Commande commande = new Commande();
            commande.setUser(user);
            commande.setRepas(repas);
            commande.setQuantity(quantite);
            commande.setStatus(Commande.Status.EN_PREPARATION);
            commande.setTotal(quantite * repas.getPrice());
            commandeRepository.save(commande);
        }

        if ("commander".equals(btnAction)) {
            return "redirect:/commandes";
        }
        return "redirect:/home";
    }

    @GetMapping("/commandes")
    public String listerCommandes(HttpSession session, ModelMap model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<Commande> commandes = commandeRepository
                .findByUserAndStatus(user, Commande.Status.EN_PREPARATION);
        double total = commandes.stream()
                .mapToDouble(c -> c.getTotal() != null ? c.getTotal() : 0.0)
                .sum();

        model.addAttribute("commandes", commandes);
        model.addAttribute("total", total);
        return "Commandes";
    }

    @PostMapping("/commandes/update")
    public String mettreAJourCommande(@RequestParam("id") Long id,
                                      @RequestParam("quantite") Integer quantite,
                                      HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Commande commande = commandeRepository.findById(id).orElse(null);
        if (commande != null && commande.getUser().getId().equals(user.getId())
                && quantite != null && quantite > 0) {
            commande.setQuantity(quantite);
            if (commande.getRepas() != null && commande.getRepas().getPrice() != null) {
                commande.setTotal(quantite * commande.getRepas().getPrice());
            }
            commandeRepository.save(commande);
        }

        return "redirect:/commandes";
    }

    @PostMapping("/commandes/delete")
    public String supprimerCommande(@RequestParam("id") Long id,
                                    HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Commande commande = commandeRepository.findById(id).orElse(null);
        if (commande != null && commande.getUser().getId().equals(user.getId())) {
            commandeRepository.delete(commande);
        }

        return "redirect:/commandes";
    }
}

