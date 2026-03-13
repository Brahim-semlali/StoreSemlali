package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String email);

    long countByRole(String role);

}