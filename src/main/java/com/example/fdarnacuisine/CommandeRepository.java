package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.Commande;
import com.example.fdarnacuisine.Model.Repas;
import com.example.fdarnacuisine.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommandeRepository extends JpaRepository<Commande, Long> {

    List<Commande> findByUserAndStatus(User user, Commande.Status status);

    Commande findByUserAndRepasAndStatus(User user, Repas repas, Commande.Status status);
}

