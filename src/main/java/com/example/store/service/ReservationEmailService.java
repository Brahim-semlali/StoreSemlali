package com.example.store.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.store.Model.Commande;
import com.example.store.Model.Reservation;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReservationEmailService {

    private final JavaMailSender mailSender;

    @Value("${fdarna.admin-email:}")
    private String adminEmail;

    public ReservationEmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    /**
     * Envoie un email à l'admin avec les informations de la réservation.
     * Ne lance pas d'exception si l'email n'est pas configuré ou en cas d'erreur d'envoi.
     */
    public void envoyerNotificationAdmin(Reservation reservation, List<Commande> commandes) {
        if (adminEmail == null || adminEmail.isBlank()) {
            return;
        }

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(adminEmail);
            message.setSubject("[Store Semlali] Nouvelle commande / réservation #" + reservation.getId());

            StringBuilder body = new StringBuilder();
            body.append("Une nouvelle demande de commande a été envoyée.\n\n");
            body.append("--- Informations client ---\n");
            body.append("Nom : ").append(reservation.getNomComplet()).append("\n");
            body.append("Email : ").append(reservation.getUser() != null ? reservation.getUser().getEmail() : "-").append("\n");
            body.append("Téléphone : ").append(reservation.getTelephone()).append("\n");
            body.append("Adresse : ").append(reservation.getAdresse()).append("\n\n");
            body.append("--- Détail de la commande ---\n");
            if (commandes != null && !commandes.isEmpty()) {
                body.append(commandes.stream()
                        .map(c -> String.format("%d × %s — %s DH", c.getQuantity(), c.getProduitName(), c.getTotal()))
                        .collect(Collectors.joining("\n")));
            }
            body.append("\n\n--- Total : ").append(reservation.getTotal()).append(" DH ---\n");
            body.append("\nConsultez le tableau de bord admin pour confirmer ou gérer cette réservation.");

            message.setText(body.toString());
            mailSender.send(message);
        } catch (Exception e) {
            // Ne pas faire échouer la réservation si l'email échoue (ex. SMTP non configuré)
            System.err.println("Envoi email admin réservation échoué: " + e.getMessage());
        }
    }
}
