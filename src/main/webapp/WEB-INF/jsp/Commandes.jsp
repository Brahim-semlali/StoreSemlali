<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Commandes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>
        .orders-title-modern { position: relative; display: inline-block; }
        .orders-title-modern::after { content: ""; position: absolute; left: 50%; transform: translateX(-50%); bottom: -8px; width: 48px; height: 4px; border-radius: 2px; background: var(--store-primary); }
        @media (max-width: 767.98px) { .orders-title-modern::after { width: 40%; } .d-flex.justify-content-between.align-items-center.mt-4 { flex-direction: column; align-items: flex-start !important; gap: 0.75rem; } }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-modern">
    <div class="container">
        <a class="navbar-brand" href="/home">Store Semlali</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/home">Accueil</a>
            <a class="nav-link active" href="/commandes">Mon panier</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <h2 class="text-center mb-0 orders-title-modern">Mes Commandes</h2>
        <div class="d-flex align-items-center gap-2">
            <a href="/notifications" class="btn btn-outline-secondary btn-sm position-relative" title="Notifications">
                <i class="bi bi-bell"></i>
                <c:if test="${notificationCount != null && notificationCount > 0}">
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size:0.6rem;">${notificationCount > 99 ? '99+' : notificationCount}</span>
                </c:if>
            </a>
            <a href="/home" class="btn btn-sm btn-outline-secondary">← Retour au catalogue</a>
        </div>
    </div>

    <div class="admin-card-modern p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h5 class="mb-1">Votre panier</h5>
                <small class="text-muted">Modifiez les quantités avant de valider la commande.</small>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table align-middle mb-0 admin-table-modern">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Article</th>
                    <th>Quantité</th>
                    <th>Prix unitaire</th>
                    <th>Total ligne</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="commande" items="${commandes}">
                    <tr>
                        <td>${commande.id}</td>
                        <td>${commande.produitName}</td>
                        <td style="max-width: 120px;">
                            <form method="post" action="/commandes/update" class="d-flex">
                                <input type="hidden" name="id" value="${commande.id}">
                                <input type="number" name="quantite" min="1" class="form-control form-control-sm me-2"
                                       value="${commande.quantity}">
                                <button class="btn btn-sm btn-outline-primary">OK</button>
                            </form>
                        </td>
                        <td>${commande.produitPrice} DH</td>
                        <td>${commande.total} DH</td>
                        <td>
                            <form method="post" action="/commandes/delete">
                                <input type="hidden" name="id" value="${commande.id}">
                                <button class="btn btn-outline-danger btn-sm">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty commandes}">
                    <tr>
                        <td colspan="6" class="text-center text-muted">
                            Panier vide. Ajoutez des articles depuis le catalogue.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="d-flex justify-content-between align-items-center mt-4">
            <h4 class="mb-0">Total : ${total} DH</h4>
            <a href="/reservation" class="btn btn-modern">Valider la commande</a>
        </div>
    </div>
</div>

</body>
</html>