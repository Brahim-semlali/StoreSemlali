package com.example.store.Controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.store.CommandeRepository;
import com.example.store.Model.Commande;
import com.example.store.Model.User;

import java.util.List;

@Controller
public class PaiementController {

    @Autowired
    private CommandeRepository commandeRepository;

    @GetMapping("/paiement")
    public String afficherPaiement(HttpSession session, ModelMap model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<Commande> commandes = commandeRepository
                .findByUserAndStatus(user, Commande.Status.EN_PREPARATION);

        double total = commandes.stream()
                .mapToDouble(c -> c.getTotal() != null ? c.getTotal() : 0.0)
                .sum();

        model.addAttribute("total", total);
        return "Paiement";
    }

    @PostMapping("/paiement/cmi")
    public String initierPaiementCmi(HttpSession session, ModelMap model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<Commande> commandes = commandeRepository
                .findByUserAndStatus(user, Commande.Status.EN_PREPARATION);

        double total = commandes.stream()
                .mapToDouble(c -> c.getTotal() != null ? c.getTotal() : 0.0)
                .sum();

        String orderId = "ORD-" + System.currentTimeMillis();
        String merchantId = "YOUR_MERCHANT_ID"; // à remplacer
        String currency = "504"; // MAD
        String redirectUrl = "https://votre-domaine.com/paiement/retour"; // à adapter

        String hash = "SIGNATURE_A_CALCULER"; // à calculer selon la doc CMI

        model.addAttribute("amount", total);
        model.addAttribute("orderId", orderId);
        model.addAttribute("merchantId", merchantId);
        model.addAttribute("currency", currency);
        model.addAttribute("redirectUrl", redirectUrl);
        model.addAttribute("hash", hash);

        return "PaiementCmiRedirect";
    }

    @PostMapping("/paiement/confirm")
    public String confirmerPaiement(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<Commande> commandes = commandeRepository
                .findByUserAndStatus(user, Commande.Status.EN_PREPARATION);

        for (Commande commande : commandes) {
            commande.setStatus(Commande.Status.LIVRE);
            commandeRepository.save(commande);
        }

        return "redirect:/home";
    }
}

