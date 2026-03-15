package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.Categorie;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategorieRepository extends JpaRepository<Categorie, Long> {

    List<Categorie> findAllByOrderByNameAsc();
}
