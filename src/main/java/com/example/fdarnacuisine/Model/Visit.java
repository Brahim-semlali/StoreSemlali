package com.example.fdarnacuisine.Model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "visits")
public class Visit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime visitedAt;

    private String ip;

    private String userAgent;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Visit() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getVisitedAt() {
        return visitedAt;
    }

    public void setVisitedAt(LocalDateTime visitedAt) {
        this.visitedAt = visitedAt;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}

