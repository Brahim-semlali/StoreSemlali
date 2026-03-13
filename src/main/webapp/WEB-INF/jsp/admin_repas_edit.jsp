<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un repas - Fdarna Cuisine</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/admin/catalogue">
            <i class="bi bi-arrow-left-circle me-2"></i>Retour au catalogue
        </a>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h4 class="card-title mb-3">Modifier le repas</h4>
                    <form action="/admin/repas/update" method="post" class="row g-3">
                        <input type="hidden" name="id" value="${repas.id}">

                        <div class="col-12">
                            <label class="form-label small text-muted">Nom</label>
                            <input type="text" name="name" class="form-control" value="${repas.name}" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label small text-muted">Prix (DH)</label>
                            <input type="number" step="0.01" name="price" class="form-control" value="${repas.price}" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label small text-muted">Description (colonne image)</label>
                            <input type="text" name="description" class="form-control" value="${repas.image}">
                        </div>

                        <div class="col-12">
                            <label class="form-label small text-muted">URL de l'image (colonne url_image)</label>
                            <input type="text" name="urlImage" class="form-control" value="${repas.urlImage}" required>
                            <small class="text-muted">Aperçu actuel :</small>
                            <div class="mt-2">
                                <img src="${repas.urlImage}" alt="${repas.name}" style="max-width: 180px; height: 110px; object-fit: cover; border-radius:10px;">
                            </div>
                        </div>

                        <div class="col-12 d-flex justify-content-between mt-3">
                            <a href="/admin/catalogue" class="btn btn-outline-secondary">
                                Annuler
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check2 me-1"></i>Enregistrer les modifications
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

