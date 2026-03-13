package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.User;
import com.example.fdarnacuisine.Model.Visit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;

public interface VisitRepository extends JpaRepository<Visit, Long> {

    long countByUserIsNull();

    long countByUserIsNotNull();

    long countByUser(User user);

    long countByVisitedAtAfter(LocalDateTime since);
}

