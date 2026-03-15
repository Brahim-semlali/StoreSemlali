<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recherche - Store Semlali</title>
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
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav mx-auto align-items-lg-center">
                <li class="nav-item"><a class="nav-link" href="/home">Accueil</a></li>
            </ul>
            <form class="d-flex ms-auto" action="/recherche" method="get">
                <div class="input-group input-group-sm">
                    <input type="search" class="form-control" name="q" value="${query}" placeholder="Rechercher un produit..." aria-label="Rechercher un produit">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
</nav>

<div class="container py-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-modern">
            <li class="breadcrumb-item"><a href="/home">Accueil</a></li>
            <li class="breadcrumb-item active">Recherche</li>
        </ol>
    </nav>

    <h1 class="mb-3 fw-bold">Résultats pour "<c:out value="${query}"/>"</h1>
    <p class="text-muted mb-4">
        <c:choose>
            <c:when test="${not empty resultats}">
                ${fn:length(resultats)} produit(s) trouvé(s).
            </c:when>
            <c:otherwise>
                Aucun produit ne correspond à votre recherche. Essayez un autre mot-clé (ex: robe, veste...).
            </c:otherwise>
        </c:choose>
    </p>

    <div class="row g-4">
        <c:forEach var="p" items="${empty resultats ? [] : resultats}">
            <div class="col-6 col-md-4 col-lg-3">
                <div class="card-modern card h-100 product-card-modern">
                    <a href="<c:url value='/produit?id=${p.id}'/>" class="text-decoration-none text-dark d-block h-100">
                        <div class="product-card-img-wrapper ${not empty p.urlImage2 ? 'has-second' : 'single'}">
                            <img src="${p.urlImage}" class="product-img-main" alt="${p.name}" loading="lazy" onerror="this.src='https://placehold.co/300x400/e2e8f0/64748b?text=Image+non+disponible'; this.onerror=null;">
                            <c:if test="${not empty p.urlImage2}">
                                <img src="${p.urlImage2}" class="product-img-alt" alt="${p.name}" loading="lazy">
                            </c:if>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title text-truncate">${p.name}</h6>
                            <p class="mb-2 small text-muted">
                                <c:if test="${not empty p.taillesDisponibles}">
                                    <span class="badge bg-light text-dark">${p.taillesDisponibles}</span>
                                </c:if>
                            </p>
                            <p class="mb-3 fw-bold text-store-primary">${p.price} DH</p>
                            <span class="mt-auto btn btn-modern-outline btn-sm">Voir le détail</span>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

