package com.example.store.Model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "avis")
public class Avis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "produit_id", nullable = false)
    private Produit produit;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    /** Note de 1 à 5 étoiles */
    @Column(nullable = false)
    private Integer note;

    @Column(length = 2000)
    private String commentaire;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    /** Nom affiché si pas connecté */
    @Column(name = "auteur_nom", length = 100)
    private String auteurNom;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getNote() {
        return note;
    }

    public void setNote(Integer note) {
        this.note = note;
    }

    public String getCommentaire() {
        return commentaire;
    }

    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getAuteurNom() {
        return auteurNom;
    }

    public void setAuteurNom(String auteurNom) {
        this.auteurNom = auteurNom;
    }

    /** Nom affiché : utilisateur connecté ou auteurNom ou "Anonyme" */
    public String getDisplayName() {
        if (user != null && user.getFullname() != null && !user.getFullname().isBlank()) {
            return user.getFullname();
        }
        if (auteurNom != null && !auteurNom.isBlank()) {
            return auteurNom;
        }
        return "Anonyme";
    }
}
