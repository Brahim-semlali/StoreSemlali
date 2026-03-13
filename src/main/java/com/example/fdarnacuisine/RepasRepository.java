package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.Repas;
import com.example.fdarnacuisine.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;


public interface RepasRepository extends JpaRepository<Repas, Long> {



}