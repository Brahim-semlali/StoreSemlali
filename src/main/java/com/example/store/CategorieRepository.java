package com.example.store;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.store.Model.Categorie;

import java.util.List;

public interface CategorieRepository extends JpaRepository<Categorie, Long> {

    List<Categorie> findAllByOrderByNameAsc();
}
