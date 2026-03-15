package com.example.store.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "commandes")
public class Commande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "produit_id")
    private Produit produit;

    @Column(name = "produit_name")
    private String produitName;

    @Column(name = "produit_price")
    private Double produitPrice;

    @ManyToOne
    @JoinColumn(name = "reservation_id")
    private Reservation reservation;

    private Integer quantity;

    @Enumerated(EnumType.STRING)
    private Status status;

    private Double total;

    public enum Status {
        EN_PREPARATION,
        LIVRE
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public String getProduitName() {
        return produit != null ? produit.getName() : produitName;
    }

    public Double getProduitPrice() {
        return produit != null ? produit.getPrice() : produitPrice;
    }

    public void setProduitName(String produitName) {
        this.produitName = produitName;
    }

    public void setProduitPrice(Double produitPrice) {
        this.produitPrice = produitPrice;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }
}
