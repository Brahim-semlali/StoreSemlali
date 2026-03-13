package com.example.fdarnacuisine.Controller;

import com.example.fdarnacuisine.Model.Repas;
import com.example.fdarnacuisine.Model.Commande;
import com.example.fdarnacuisine.RepasRepository;
import com.example.fdarnacuisine.CommandeRepository;
import com.example.fdarnacuisine.UserRepository;
import com.example.fdarnacuisine.VisitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private RepasRepository repasRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CommandeRepository commandeRepository;

    @Autowired
    private VisitRepository visitRepository;

    @GetMapping("/admin/catalogue")
    public String afficherCatalogue(ModelMap model) {
        List<Repas> repasList = repasRepository.findAll();
        model.addAttribute("repasList", repasList);
        // Statistiques simples pour le tableau de bord admin
        long totalClientsInscrits = userRepository.countByRole("USER");
        long totalAdmins = userRepository.countByRole("ADMIN");
        long totalCommandes = commandeRepository.count();
        long clientsAyantCommande = commandeRepository.findAll()
                .stream()
                .map(Commande::getUser)
                .filter(u -> u != null)
                .map(u -> u.getId())
                .distinct()
                .count();
        long clientsInscritsSansCommande = Math.max(0, totalClientsInscrits - clientsAyantCommande);

        model.addAttribute("totalClientsInscrits", totalClientsInscrits);
        model.addAttribute("totalAdmins", totalAdmins);
        model.addAttribute("totalCommandes", totalCommandes);
        model.addAttribute("clientsAyantCommande", clientsAyantCommande);
        model.addAttribute("clientsInscritsSansCommande", clientsInscritsSansCommande);
        long totalVisites = visitRepository.count();
        long visitesAnonymes = visitRepository.countByUserIsNull();
        long visitesConnectees = visitRepository.countByUserIsNotNull();
        model.addAttribute("totalVisites", totalVisites);
        model.addAttribute("visitesAnonymes", visitesAnonymes);
        model.addAttribute("visitesConnectees", visitesConnectees);
        // Statistiques visites par période
        LocalDate aujourdHui = LocalDate.now();
        LocalDateTime debutJour = aujourdHui.atStartOfDay();
        LocalDateTime debutSemaine = aujourdHui.with(DayOfWeek.MONDAY).atStartOfDay();
        LocalDateTime debutMois = aujourdHui.withDayOfMonth(1).atStartOfDay();

        long visitesAujourdHui = visitRepository.countByVisitedAtAfter(debutJour);
        long visitesCetteSemaine = visitRepository.countByVisitedAtAfter(debutSemaine);
        long visitesCeMois = visitRepository.countByVisitedAtAfter(debutMois);

        model.addAttribute("visitesAujourdHui", visitesAujourdHui);
        model.addAttribute("visitesCetteSemaine", visitesCetteSemaine);
        model.addAttribute("visitesCeMois", visitesCeMois);
        return "admin_catalogue";
    }

    @PostMapping("/admin/repas/add")
    public String ajouterRepas(@RequestParam String name,
                               @RequestParam Double price,
                               @RequestParam("description") String description,
                               @RequestParam("urlImage") String imageUrl) {

        Repas repas = new Repas();
        repas.setName(name);
        repas.setPrice(price);
        repas.setImage(description);
        repas.setUrlImage(imageUrl);
        repasRepository.save(repas);

        return "redirect:/admin/catalogue";
    }

    @GetMapping("/admin/repas/edit")
    public String editerRepas(@RequestParam Long id, ModelMap model) {
        Repas repas = repasRepository.findById(id).orElse(null);
        if (repas == null) {
            return "redirect:/admin/catalogue";
        }
        model.addAttribute("repas", repas);
        return "admin_repas_edit";
    }

    @PostMapping("/admin/repas/update")
    public String mettreAJourRepas(@RequestParam Long id,
                                   @RequestParam String name,
                                   @RequestParam Double price,
                                   @RequestParam("description") String description,
                                   @RequestParam("urlImage") String imageUrl) {
        Repas repas = repasRepository.findById(id).orElse(null);
        if (repas != null) {
            repas.setName(name);
            repas.setPrice(price);
            repas.setImage(description);
            repas.setUrlImage(imageUrl);
            repasRepository.save(repas);
        }
        return "redirect:/admin/catalogue";
    }

    @PostMapping("/admin/repas/delete")
    public String supprimerRepas(@RequestParam Long id) {
        repasRepository.deleteById(id);
        return "redirect:/admin/catalogue";
    }
}

