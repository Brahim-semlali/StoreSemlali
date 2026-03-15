<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Réservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>
        .reservation-title-modern { position: relative; display: inline-block; }
        .reservation-title-modern::after { content: ""; position: absolute; left: 50%; transform: translateX(-50%); bottom: -8px; width: 48px; height: 4px; border-radius: 2px; background: var(--store-primary); }
        .official-info { border-radius: var(--radius-sm); background: var(--store-bg); }
        @media (max-width: 767.98px) { .reservation-title-modern::after { width: 40%; } }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-modern">
    <div class="container">
        <a class="navbar-brand" href="/home">Store Semlali</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/home">Accueil</a>
            <a class="nav-link" href="/commandes">Mon panier</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-end align-items-center gap-2 mb-3">
        <a href="/notifications" class="btn btn-outline-secondary btn-sm position-relative" title="Notifications">
            <i class="bi bi-bell"></i>
            <c:if test="${notificationCount != null && notificationCount > 0}">
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size:0.6rem;">${notificationCount > 99 ? '99+' : notificationCount}</span>
            </c:if>
        </a>
        <a href="/commandes" class="btn btn-sm btn-modern-outline">← Retour aux commandes</a>
    </div>

    <h2 class="text-center mb-4 reservation-title-modern">Validation de la commande</h2>

    <div class="admin-card-modern p-4">

        <form action="/reservation" method="post">

            <div class="alert alert-info mb-4">
                Indiquez votre adresse de livraison. Pour toute question, contactez-nous sur WhatsApp au
                <a href="https://wa.me/212634801200" target="_blank" class="link-dark">+212 6 34 80 12 00</a>.
            </div>

            <div class="mb-3">
                <label class="form-label">Nom complet</label>
                <input type="text" name="nomComplet" class="form-control" placeholder="Votre nom complet" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Adresse de livraison</label>
                <input type="text" name="adresse" class="form-control" placeholder="Quartier, rue, immeuble, ville" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Téléphone</label>
                <input type="text" name="telephone" class="form-control" placeholder="+212 6 XX XX XX XX" required>
            </div>

            <div class="form-check mb-4">
                <input class="form-check-input" type="checkbox" id="confirmAddress" required>
                <label class="form-check-label" for="confirmAddress">
                    Je confirme que mon adresse de livraison est correcte.
                </label>
            </div>

            <div class="mb-3 official-info p-3">
                <h5 class="mb-2">Récapitulatif de votre commande</h5>
                <ul class="list-unstyled mb-0">
                    <c:forEach var="commande" items="${commandes}">
                        <li>${commande.quantity} × ${commande.produitName} &mdash; ${commande.total} DH</li>
                    </c:forEach>
                </ul>
                <hr>
                <h4 class="mb-0">Total : ${total} DH</h4>
            </div>

            <div class="d-flex justify-content-end align-items-center mt-4">
                <button type="submit" class="btn btn-modern btn-lg">
                    Confirmer la commande
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>
