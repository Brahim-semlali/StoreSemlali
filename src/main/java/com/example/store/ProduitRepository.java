package com.example.store;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.store.Model.Categorie;
import com.example.store.Model.Produit;

import java.util.List;
import java.util.Optional;

public interface ProduitRepository extends JpaRepository<Produit, Long> {

    @Query("SELECT p FROM Produit p LEFT JOIN FETCH p.categorie WHERE p.id = :id")
    Optional<Produit> findByIdWithCategorie(@Param("id") Long id);

    @Query("SELECT p FROM Produit p LEFT JOIN FETCH p.categorie WHERE p.visible IS NULL OR p.visible = true ORDER BY p.name")
    List<Produit> findVisibleProduits();

    List<Produit> findByCategorieOrderByNameAsc(Categorie categorie);

    List<Produit> findByCategorieIdOrderByNameAsc(Long categorieId);

    @Query("SELECT p FROM Produit p LEFT JOIN FETCH p.categorie WHERE p.categorie.id = :categorieId AND (p.visible IS NULL OR p.visible = true) ORDER BY p.name")
    List<Produit> findVisibleByCategorieIdOrderByNameAsc(Long categorieId);

    @Query("SELECT p FROM Produit p WHERE p.visible IS NULL OR p.visible = true ORDER BY p.id DESC")
    List<Produit> findLatestVisibleProduits(Pageable pageable);

    @Query("SELECT p FROM Produit p LEFT JOIN FETCH p.categorie WHERE (p.visible IS NULL OR p.visible = true) AND LOWER(p.name) LIKE LOWER(CONCAT('%', :query, '%')) ORDER BY p.name")
    List<Produit> searchVisibleByNameContaining(@Param("query") String query);
}
