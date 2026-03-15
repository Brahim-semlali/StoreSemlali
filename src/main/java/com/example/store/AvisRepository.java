package com.example.store;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.store.Model.Avis;
import com.example.store.Model.Produit;

import java.util.List;

public interface AvisRepository extends JpaRepository<Avis, Long> {

    @Query("SELECT a FROM Avis a LEFT JOIN FETCH a.user WHERE a.produit = :produit ORDER BY a.createdAt DESC")
    List<Avis> findByProduitOrderByCreatedAtDesc(@Param("produit") Produit produit);

    List<Avis> findByProduitId(Long produitId);
}
