package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String email);

    long countByRole(String role);

    List<User> findByRoleOrderByFullnameAsc(String role);
}