package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {

    List<Reservation> findAllByOrderByDateCreationDesc();

    /** Charge TOUTES les réservations avec commandes et produit pour l'affichage admin (évite LazyInitializationException). */
    @Query("SELECT DISTINCT r FROM Reservation r " +
           "LEFT JOIN FETCH r.commandes c " +
           "LEFT JOIN FETCH c.produit " +
           "LEFT JOIN FETCH r.user " +
           "ORDER BY r.dateCreation DESC")
    List<Reservation> findAllWithCommandesAndUserByOrderByDateCreationDesc();

    /** Réservations récentes (à partir d'une date donnée) avec commandes et produit pour le tableau admin. */
    @Query("SELECT DISTINCT r FROM Reservation r " +
           "LEFT JOIN FETCH r.commandes c " +
           "LEFT JOIN FETCH c.produit " +
           "LEFT JOIN FETCH r.user " +
           "WHERE r.dateCreation >= :since " +
           "ORDER BY r.dateCreation DESC")
    List<Reservation> findRecentWithCommandesAndUser(@Param("since") LocalDateTime since);
}
