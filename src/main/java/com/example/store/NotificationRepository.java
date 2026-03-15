package com.example.store;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.store.Model.Notification;
import com.example.store.Model.User;

import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification, Long> {

    @Query("SELECT COUNT(n) FROM Notification n WHERE n.user = :user AND n.markedAsRead = false")
    long countByUserAndReadFalse(@Param("user") User user);

    List<Notification> findByUserOrderByCreatedAtDesc(User user);
}
