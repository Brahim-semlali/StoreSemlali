package com.example.fdarnacuisine.Model;

import jakarta.persistence.*;

@Entity
@Table(name="repas")
public class Repas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Double price;

    // colonne "image" = description ou texte
    @Column(name = "image")
    private String image;

    // colonne "url_image" = URL de la photo
    @Column(name = "url_image")
    private String urlImage;

    public Repas() {}

    public Repas(String name, Double price, String description, String urlImage) {
        this.name = name;
        this.price = price;
        this.image = description;
        this.urlImage = urlImage;
    }


    // GETTERS ET SETTERS

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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    // utilisé dans les JSP : ${repas.urlImage}
    public String getUrlImage() {
        return urlImage;
    }

    public void setUrlImage(String urlImage) {
        this.urlImage = urlImage;
    }
}