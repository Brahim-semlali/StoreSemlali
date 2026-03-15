package com.example.store;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.store.Model.Commande;
import com.example.store.Model.Produit;
import com.example.store.Model.Reservation;
import com.example.store.Model.User;

import java.util.List;

public interface CommandeRepository extends JpaRepository<Commande, Long> {

    List<Commande> findByUserAndStatus(User user, Commande.Status status);

    List<Commande> findByUserAndStatusAndReservationIsNull(User user, Commande.Status status);

    Commande findByUserAndProduitAndStatus(User user, Produit produit, Commande.Status status);

    Commande findByUserAndProduitAndStatusAndReservationIsNull(User user, Produit produit, Commande.Status status);

    List<Commande> findByReservation(Reservation reservation);

    boolean existsByProduit(Produit produit);

    List<Commande> findByProduit(Produit produit);
}
