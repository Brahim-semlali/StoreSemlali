<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:out value="${categorie.name}" default="Catégorie"/> - Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
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

<div class="container py-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-modern">
            <li class="breadcrumb-item"><a href="/home">Accueil</a></li>
            <li class="breadcrumb-item active"><c:out value="${categorie.name}" default="Catégorie"/></li>
        </ol>
    </nav>
    <h1 class="mb-4 fw-bold"><c:out value="${categorie.name}" default="Catégorie"/></h1>

    <div class="row g-4" id="productList">
        <c:forEach var="p" items="${empty produits ? [] : produits}">
            <div class="col-6 col-md-4 col-lg-3">
                <div class="card-modern card h-100">
                    <a href="<c:url value='/produit?id=${p.id}'/>" class="text-decoration-none text-dark d-block h-100">
                        <div class="product-card-img-wrapper ${not empty p.urlImage2 ? 'has-second' : 'single'}">
                            <img src="${p.urlImage}" class="product-img-main" alt="${p.name}" loading="lazy" onerror="this.src='https://placehold.co/300x400/e2e8f0/64748b?text=Image+non+disponible'; this.onerror=null;">
                            <c:if test="${not empty p.urlImage2}">
                                <img src="${p.urlImage2}" class="product-img-alt" alt="${p.name}" loading="lazy">
                            </c:if>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title">${p.name}</h6>
                            <p class="mb-2 small text-muted">
                                <c:if test="${not empty p.taillesDisponibles}"><span class="badge bg-light text-dark">${p.taillesDisponibles}</span></c:if>
                            </p>
                            <p class="mb-3 fw-bold text-store-primary">${p.price} DH</p>
                            <span class="mt-auto btn btn-modern-outline btn-sm">Voir le détail</span>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${empty produits}">
        <p class="text-muted text-center py-5">Aucun produit dans cette catégorie.</p>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
