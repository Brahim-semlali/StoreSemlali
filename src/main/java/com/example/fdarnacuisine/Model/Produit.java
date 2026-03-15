package com.example.fdarnacuisine.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "produits")
public class Produit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Double price;

    @Column(name = "description")
    private String description;

    /** Image principale (obligatoire, min 1) */
    @Column(name = "url_image")
    private String urlImage;

    @Column(name = "url_image_2")
    private String urlImage2;

    @Column(name = "url_image_3")
    private String urlImage3;

    @Column(name = "url_image_4")
    private String urlImage4;

    /** Tailles disponibles, ex: "S,M,L,XL" */
    @Column(name = "tailles_disponibles")
    private String taillesDisponibles;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "categorie_id")
    private Categorie categorie;

    @Column(name = "visible")
    private Boolean visible = true;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrlImage() {
        return urlImage;
    }

    public void setUrlImage(String urlImage) {
        this.urlImage = urlImage;
    }

    public String getUrlImage2() {
        return urlImage2;
    }

    public void setUrlImage2(String urlImage2) {
        this.urlImage2 = urlImage2;
    }

    public String getUrlImage3() {
        return urlImage3;
    }

    public void setUrlImage3(String urlImage3) {
        this.urlImage3 = urlImage3;
    }

    public String getUrlImage4() {
        return urlImage4;
    }

    public void setUrlImage4(String urlImage4) {
        this.urlImage4 = urlImage4;
    }

    public String getTaillesDisponibles() {
        return taillesDisponibles;
    }

    public void setTaillesDisponibles(String taillesDisponibles) {
        this.taillesDisponibles = taillesDisponibles;
    }

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    /** Pour compatibilité ancienne vue (catégorie en string). */
    public String getCategory() {
        return categorie != null ? categorie.getName() : null;
    }

    public boolean isVisible() {
        return visible == null || visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }
}
