package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.Avis;
import com.example.fdarnacuisine.Model.Produit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AvisRepository extends JpaRepository<Avis, Long> {

    @Query("SELECT a FROM Avis a LEFT JOIN FETCH a.user WHERE a.produit = :produit ORDER BY a.createdAt DESC")
    List<Avis> findByProduitOrderByCreatedAtDesc(@Param("produit") Produit produit);

    List<Avis> findByProduitId(Long produitId);
}
