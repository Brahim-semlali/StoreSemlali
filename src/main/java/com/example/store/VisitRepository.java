package com.example.store;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.store.Model.User;
import com.example.store.Model.Visit;

import java.time.LocalDateTime;
import java.util.Optional;

public interface VisitRepository extends JpaRepository<Visit, Long> {

    long countByUserIsNull();

    long countByUserIsNotNull();

    long countByUser(User user);

    long countByVisitedAtAfter(LocalDateTime since);

    Optional<Visit> findTopByUserOrderByVisitedAtDesc(User user);
}

