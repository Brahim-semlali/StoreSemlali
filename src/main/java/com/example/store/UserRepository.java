package com.example.store;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.store.Model.User;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String email);

    long countByRole(String role);

    List<User> findByRoleOrderByFullnameAsc(String role);
}