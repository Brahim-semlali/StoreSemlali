package com.example.store.Controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.store.CommandeRepository;
import com.example.store.ReservationRepository;
import com.example.store.UserRepository;
import com.example.store.Model.Commande;
import com.example.store.Model.Reservation;
import com.example.store.Model.User;
import com.example.store.service.ReservationEmailService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@Controller
public class ReservationController {

    private static final Logger log = LoggerFactory.getLogger(ReservationController.class);

    @Autowired
    private CommandeRepository commandeRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private ReservationEmailService reservationEmailService;

    @Autowired
    private UserRepository userRepository;

    private User getManagedUser(HttpSession session) {
        Object u = session.getAttribute("user");
        if (!(u instanceof User)) return null;
        return userRepository.findById(((User) u).getId()).orElse(null);
    }

    @GetMapping("/reservation")
    public String afficherReservation(HttpSession session, ModelMap model) {
        User user = getManagedUser(session);
        if (user == null) {
            log.warn("GET /reservation - utilisateur non connecte");
            return "redirect:/login";
        }

        List<Commande> commandes = commandeRepository
                .findByUserAndStatusAndReservationIsNull(user, Commande.Status.EN_PREPARATION);

        double total = commandes.stream()
                .mapToDouble(c -> c.getTotal() != null ? c.getTotal() : 0.0)
                .sum();

        model.addAttribute("total", total);
        model.addAttribute("commandes", commandes);
        log.info("GET /reservation - userId={} nbArticles={} total={}", user.getId(), commandes.size(), total);
        return "Reservation";
    }

    @PostMapping("/reservation")
    public String envoyerDemande(@RequestParam("nomComplet") String nomComplet,
                                 @RequestParam("adresse") String adresse,
                                 @RequestParam("telephone") String telephone,
                                 HttpSession session) {
        User user = getManagedUser(session);
        if (user == null) {
            log.warn("POST /reservation - utilisateur non connecte");
            return "redirect:/login";
        }

        List<Commande> commandes = commandeRepository
                .findByUserAndStatusAndReservationIsNull(user, Commande.Status.EN_PREPARATION);

        if (commandes.isEmpty()) {
            log.warn("POST /reservation - panier vide userId={}", user.getId());
            return "redirect:/commandes";
        }

        double total = commandes.stream()
                .mapToDouble(c -> c.getTotal() != null ? c.getTotal() : 0.0)
                .sum();

        Reservation reservation = new Reservation();
        reservation.setUser(user);
        reservation.setNomComplet(nomComplet != null ? nomComplet.trim() : user.getFullname());
        reservation.setAdresse(adresse != null ? adresse.trim() : "");
        reservation.setTelephone(telephone != null ? telephone.trim() : "");
        reservation.setTotal(total);
        reservation.setStatus(Reservation.Status.EN_ATTENTE);
        reservation = reservationRepository.save(reservation);

        for (Commande commande : commandes) {
            commande.setReservation(reservation);
            commandeRepository.save(commande);
        }

        reservationEmailService.envoyerNotificationAdmin(reservation, commandes);

        log.info("POST /reservation - reservation creee id={} userId={} total={} nbArticles={}",
                reservation.getId(), user.getId(), total, commandes.size());
        return "redirect:/home?reservation=ok";
    }
}
