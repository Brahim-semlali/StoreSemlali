<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Store Semlali - Vêtements</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-modern">
    <div class="container">
        <a class="navbar-brand" href="/home">
            <img src="<c:url value='/image/logo.jpeg'/>" loading="lazy" onerror="this.style.display='none'">
            <span>Store Semlali</span>
        </a>
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav mx-auto align-items-lg-center text-center text-lg-start">
                <li class="nav-item"><a class="nav-link active" href="/home">Accueil</a></li>
                <li class="nav-item"><a class="nav-link" href="#nouveautes">NOUVEAUTÉ</a></li>
                <li class="nav-item"><a class="nav-link" href="#categories">PAR PIÈCE</a></li>
            </ul>
            <!-- Bloc recherche / panier pour mobile -->
            <div class="d-lg-none w-100 mt-3">
                <form class="navbar-search-mobile d-flex align-items-center mb-2" action="/recherche" method="get">
                    <input type="search" class="form-control" name="q" placeholder="Rechercher un produit..." aria-label="Rechercher un produit">
                    <button class="btn" type="submit" aria-label="Recherche">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
                <div class="navbar-icons-mobile d-flex justify-content-between align-items-center">
                    <a href="/commandes" class="icon-btn" aria-label="Mon panier">
                        <i class="bi bi-bag fs-5"></i>
                    </a>
                    <c:if test="${not empty user}">
                        <a class="icon-btn position-relative ms-3" href="/notifications" title="Notifications">
                            <i class="bi bi-bell fs-5"></i>
                            <c:if test="${notificationCount != null && notificationCount > 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size:0.65rem;">${notificationCount > 99 ? '99+' : notificationCount}</span>
                            </c:if>
                        </a>
                    </c:if>
                </div>
            </div>

            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item d-none d-lg-block">
                    <div class="navbar-icons me-2">
                        <form class="navbar-search d-flex align-items-center" action="/recherche" method="get">
                            <input type="search" class="form-control" name="q" placeholder="Rechercher un produit..." aria-label="Rechercher un produit">
                            <button class="btn" type="submit" aria-label="Recherche">
                                <i class="bi bi-search"></i>
                            </button>
                        </form>
                        <a href="/commandes" class="icon-btn" aria-label="Mon panier">
                            <i class="bi bi-bag"></i>
                        </a>
                    </div>
                </li>
                <c:choose>
                    <c:when test="${not empty user}">
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="/notifications" title="Notifications">
                                <i class="bi bi-bell fs-5"></i>
                                <c:if test="${notificationCount != null && notificationCount > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size:0.65rem;">${notificationCount > 99 ? '99+' : notificationCount}</span>
                                </c:if>
                            </a>
                        </li>
                        <li class="nav-item ms-lg-3"><span class="nav-link disabled text-white-50">${user.fullname}</span></li>
                        <li class="nav-item ms-lg-2"><a class="btn btn-sm btn-outline-warning" href="/logout">Se déconnecter</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item ms-lg-3"><a class="btn btn-sm btn-outline-light" href="/login">Se connecter</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <section class="hero-modern animate-fade-in is-visible" style="background-image:
                    linear-gradient(135deg, rgba(15,23,42,0.88) 0%, rgba(14,165,233,0.35) 100%),
                    url('https://images.unsplash.com/photo-1649433911119-7cf48b3e8f50?auto=format&fit=crop&w=1600&q=80');">
                <div class="container py-5">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="hero-content" style="max-width:560px;">
                                <div class="hero-badge"><i class="bi bi-shop"></i> <span>Boutique de vêtements</span></div>
                                <h1>Mode et style à votre portée</h1>
                                <p class="hero-desc">Choisissez une catégorie pour découvrir nos articles. Qualité et prix doux.</p>
                                <div class="mt-4 d-flex flex-wrap gap-3">
                                    <a href="#categories" class="btn btn-modern text-white">Voir les catégories</a>
                                    <a href="/commandes" class="btn btn-outline-light">Mon panier</a>
                                </div>
                                <div class="hero-meta-modern">
                                    <span><i class="bi bi-truck me-1"></i>Livraison disponible</span>
                                    <span><i class="bi bi-credit-card me-1"></i>Paiement sécurisé</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="carousel-item">
            <section class="hero-modern animate-fade-in" style="background-image:
                    linear-gradient(135deg, rgba(15,23,42,0.88) 0%, rgba(14,165,233,0.35) 100%),
                    url('https://images.unsplash.com/photo-1590874103328-eac38a683ce7?auto=format&fit=crop&w=1600&q=80');">
                <div class="container py-5">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="hero-content" style="max-width:560px;">
                                <div class="hero-badge"><i class="bi bi-shop"></i> <span>Nouvelles collections</span></div>
                                <h1>Inspirez votre style</h1>
                                <p class="hero-desc">Découvrez nos dernières pièces tendance pour toutes les occasions.</p>
                                <div class="mt-4 d-flex flex-wrap gap-3">
                                    <a href="#nouveautes" class="btn btn-modern text-white">Voir les nouveautés</a>
                                    <a href="#categories" class="btn btn-outline-light">Choisir une catégorie</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="carousel-item">
            <section class="hero-modern animate-fade-in" style="background-image:
                    linear-gradient(135deg, rgba(15,23,42,0.88) 0%, rgba(14,165,233,0.35) 100%),
                    url('https://images.unsplash.com/photo-1445205170230-053b83016050?auto=format&fit=crop&w=1600&q=80');">
                <div class="container py-5">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="hero-content" style="max-width:560px;">
                                <div class="hero-badge"><i class="bi bi-shop"></i> <span>Accessoires & détails</span></div>
                                <h1>Complétez votre look</h1>
                                <p class="hero-desc">Montres, ceintures, sacs et plus encore pour sublimer vos tenues.</p>
                                <div class="mt-4 d-flex flex-wrap gap-3">
                                    <a href="#categories" class="btn btn-modern text-white">Voir les catégories</a>
                                    <a href="/commandes" class="btn btn-outline-light">Mon panier</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="carousel-item">
            <section class="hero-modern animate-fade-in" style="background-image:
                    linear-gradient(135deg, rgba(15,23,42,0.88) 0%, rgba(14,165,233,0.35) 100%),
                    url('https://images.unsplash.com/photo-1528701800489-20be3c30c1d5?auto=format&fit=crop&w=1600&q=80');">
                <div class="container py-5">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="hero-content" style="max-width:560px;">
                                <div class="hero-badge"><i class="bi bi-shop"></i> <span>Magasin de vêtements</span></div>
                                <h1>Ambiance boutique réelle</h1>
                                <p class="hero-desc">Un aperçu de votre univers, avec nos pièces soigneusement sélectionnées.</p>
                                <div class="mt-4 d-flex flex-wrap gap-3">
                                    <a href="#nouveautes" class="btn btn-modern text-white">Découvrir</a>
                                    <a href="/commandes" class="btn btn-outline-light">Mon panier</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<section class="container py-5 section-with-bg animate-fade-up" id="nouveautes">
    <h2 class="text-center mb-5 section-title-modern">Nouveautés</h2>
    <c:if test="${not empty latestProduits}">
        <div class="row g-4">
            <c:forEach var="p" items="${latestProduits}">
                <div class="col-6 col-md-4 col-lg-2 animate-fade-up anim-delay-1">
                    <a href="<c:url value='/produit?id=${p.id}'/>" class="text-decoration-none d-block h-100">
                        <div class="card shadow-sm border-0 h-100 product-card-modern animate-scale-hover">
                            <div class="ratio ratio-4x3 bg-light rounded-top overflow-hidden">
                                <c:if test="${not empty p.urlImage}">
                                    <img src="${p.urlImage}" alt="${p.name}" class="w-100 h-100 object-fit-cover" loading="lazy" onerror="this.style.display='none';">
                                </c:if>
                            </div>
                            <div class="card-body p-2 text-center">
                                <div class="small fw-semibold text-dark text-truncate" title="${p.name}">${p.name}</div>
                                <div class="small text-muted mt-1">
                                    <c:if test="${p.price != null}">
                                        ${p.price} MAD
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${empty latestProduits}">
        <p class="text-center text-muted py-4">Aucun nouveau produit pour le moment.</p>
    </c:if>
</section>

<section class="container py-5 section-with-bg-light animate-fade-up" id="categories">
    <h2 class="text-center mb-5 section-title-modern">Choisissez une catégorie</h2>
    <div class="row g-4" id="categoryList">
        <c:forEach var="cat" items="${categories}">
            <div class="col-12 col-md-4 col-lg-4 animate-fade-up anim-delay-2">
                <a href="<c:url value='/categorie?id=${cat.id}'/>" class="cat-card-modern animate-scale-hover">
                    <div class="cat-card-img">
                        <c:if test="${not empty cat.imageUrl}">
                            <img src="${cat.imageUrl}" alt="${cat.name}" loading="lazy" onerror="this.style.display='none';">
                        </c:if>
                        <i class="bi bi-grid-3x3-gap display-4 text-white opacity-75 position-relative"></i>
                    </div>
                    <div class="cat-card-body">
                        <h5 class="mb-0">${cat.name}</h5>
                        <small>Voir les articles</small>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
    <c:if test="${empty categories}">
        <p class="text-center text-muted py-5">Aucune catégorie pour le moment.</p>
    </c:if>
</section>

<section class="container mt-5 py-4 animate-fade-up" id="how-to-order">
    <h2 class="text-center mb-5 section-title-modern">Comment commander ?</h2>
    <div class="row text-center g-4">
        <div class="col-md-4 animate-fade-up anim-delay-1">
            <div class="step-num" style="font-size:2.5rem;font-weight:800;color:var(--store-primary);opacity:0.3;line-height:1;">1</div>
            <p class="mt-2 fw-600">Choisissez une catégorie puis vos articles</p>
        </div>
        <div class="col-md-4 animate-fade-up anim-delay-2">
            <div class="step-num" style="font-size:2.5rem;font-weight:800;color:var(--store-primary);opacity:0.3;line-height:1;">2</div>
            <p class="mt-2 fw-600">Ajoutez au panier et indiquez les quantités</p>
        </div>
        <div class="col-md-4 animate-fade-up anim-delay-3">
            <div class="step-num" style="font-size:2.5rem;font-weight:800;color:var(--store-primary);opacity:0.3;line-height:1;">3</div>
            <p class="mt-2 fw-600">Validez votre commande et adresse de livraison</p>
        </div>
    </div>
</section>

<section class="container mt-5 py-4 animate-fade-up" id="suivez-nous">
    <h2 class="text-center mb-4 section-title-modern">Retrouvez-nous</h2>
    <div class="row g-4 justify-content-center">
        <div class="col-sm-6 col-md-4 animate-fade-up anim-delay-1">
            <a href="https://www.instagram.com/storesemlali" target="_blank" rel="noopener" class="social-card text-decoration-none d-flex align-items-center gap-3 p-4 rounded-3 bg-white border-0 shadow-sm w-100" style="transition: transform 0.2s, box-shadow 0.2s;">
                <div class="rounded-3 d-flex align-items-center justify-content-center flex-shrink-0" style="width:56px; height:56px; background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);">
                    <i class="bi bi-instagram text-white fs-4"></i>
                </div>
                <div class="text-start">
                    <span class="fw-bold text-dark d-block">Instagram</span>
                    <span class="small text-muted">@storesemlali</span>
                </div>
                <i class="bi bi-arrow-up-right ms-auto text-secondary"></i>
            </a>
        </div>
        <div class="col-sm-6 col-md-4 animate-fade-up anim-delay-2">
            <a href="https://www.tiktok.com/@storesemlali" target="_blank" rel="noopener" class="social-card text-decoration-none d-flex align-items-center gap-3 p-4 rounded-3 bg-white border-0 shadow-sm w-100" style="transition: transform 0.2s, box-shadow 0.2s;">
                <div class="rounded-3 d-flex align-items-center justify-content-center flex-shrink-0 bg-dark" style="width:56px; height:56px;">
                    <i class="bi bi-tiktok text-white fs-4"></i>
                </div>
                <div class="text-start">
                    <span class="fw-bold text-dark d-block">TikTok</span>
                    <span class="small text-muted">@storesemlali</span>
                </div>
                <i class="bi bi-arrow-up-right ms-auto text-secondary"></i>
            </a>
        </div>
        <div class="col-sm-6 col-md-4 animate-fade-up anim-delay-3">
            <a href="https://www.google.com/maps/search/?api=1&query=Store+Semlali+Maroc" target="_blank" rel="noopener" class="social-card text-decoration-none d-flex align-items-center gap-3 p-4 rounded-3 bg-white border-0 shadow-sm w-100" style="transition: transform 0.2s, box-shadow 0.2s;">
                <div class="rounded-3 d-flex align-items-center justify-content-center flex-shrink-0" style="width:56px; height:56px; background: var(--store-primary);">
                    <i class="bi bi-geo-alt-fill text-white fs-4"></i>
                </div>
                <div class="text-start">
                    <span class="fw-bold text-dark d-block">Localisation</span>
                    <span class="small text-muted">Voir sur la carte</span>
                </div>
                <i class="bi bi-arrow-up-right ms-auto text-secondary"></i>
            </a>
        </div>
    </div>
</section>

<section class="container mt-5 animate-fade-up" id="contact">
    <h2 class="text-center mb-4 section-title-modern">Contact</h2>
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="contact-card">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Écrivez-nous</h5>
                    <span class="contact-chip"><i class="bi bi-envelope"></i>Réponse rapide</span>
                </div>
                <form>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label small text-muted mb-1">Nom</label>
                            <input type="text" class="form-control mb-3" placeholder="Votre nom">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small text-muted mb-1">Email</label>
                            <input type="email" class="form-control mb-3" placeholder="vous@example.com">
                        </div>
                    </div>
                    <label class="form-label small text-muted mb-1">Message</label>
                    <textarea class="form-control mb-3" rows="4" placeholder="Parlez-nous de votre demande..."></textarea>
                    <button class="btn btn-modern text-white w-100">Envoyer le message</button>
                </form>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="contact-card h-100 d-flex flex-column justify-content-between">
                <div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0">Store Semlali</h5>
                        <span class="contact-chip"><i class="bi bi-clock"></i>7j/7 en ligne</span>
                    </div>
                    <p class="mb-3 text-muted">Pour toute question sur nos articles, tailles ou votre commande, contactez-nous directement.</p>
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-whatsapp fs-3 me-3 text-success"></i>
                        <div>
                            <div class="fw-semibold mb-1">WhatsApp</div>
                            <a class="social-link small d-block" target="_blank" href="https://wa.me/212634801200">+212 6 34 80 12 00</a>
                            <span class="small text-muted">Cliquez pour ouvrir la conversation</span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-geo-alt me-3 text-danger"></i>
                        <div>
                            <div class="fw-semibold">Adresse</div>
                            <a class="social-link small d-block" target="_blank" href="https://www.google.com/maps/search/?api=1&query=Store+Semlali+Maroc">Maroc</a>
                            <span class="small text-muted">Voir notre boutique sur la carte</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="footer-modern text-white mt-5 py-5 animate-fade-up">
    <div class="container">
        <div class="row g-4">
            <!-- Branding -->
            <div class="col-12 col-md-4 col-lg-3">
                <div class="d-flex align-items-center mb-3">
                    <div class="me-2 fs-3">🛍️</div>
                    <span class="fw-bold fs-5">Store Semlali</span>
                </div>
                <p class="text-white-50 small mb-0">
                    Mode et style à votre portée. Qualité et prix doux.
                </p>
            </div>

            <!-- Navigation -->
            <div class="col-6 col-md-4 col-lg-3">
                <h6 class="fw-semibold mb-3">Navigation</h6>
                <ul class="list-unstyled small text-white-50">
                    <li class="mb-2"><a href="/home" class="text-decoration-none text-white-50 hover-footer-link">Accueil</a></li>
                    <li class="mb-2"><a href="#nouveautes" class="text-decoration-none text-white-50 hover-footer-link">Nouveautés</a></li>
                    <li class="mb-2"><a href="#categories" class="text-decoration-none text-white-50 hover-footer-link">Catégories</a></li>
                    <li class="mb-2"><a href="/commandes" class="text-decoration-none text-white-50 hover-footer-link">Mon panier</a></li>
                </ul>
            </div>

            <!-- Service client -->
            <div class="col-6 col-md-4 col-lg-3">
                <h6 class="fw-semibold mb-3">Service client</h6>
                <ul class="list-unstyled small text-white-50">
                    <li class="mb-2"><a href="#contact" class="text-decoration-none text-white-50 hover-footer-link">Contact</a></li>
                    <li class="mb-2"><span class="d-block">Livraison disponible</span></li>
                    <li class="mb-2"><span class="d-block">Retours sur demande</span></li>
                    <li class="mb-2"><span class="d-block">FAQ bientôt disponible</span></li>
                </ul>
            </div>

            <!-- Social -->
            <div class="col-12 col-md-12 col-lg-3">
                <h6 class="fw-semibold mb-3">Suivez-nous</h6>
                <div class="d-flex gap-3">
                    <a href="https://www.instagram.com/storesemlali" target="_blank" rel="noopener"
                       class="text-white-50 fs-5 hover-footer-icon">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="https://www.tiktok.com/@storesemlali" target="_blank" rel="noopener"
                       class="text-white-50 fs-5 hover-footer-icon">
                        <i class="bi bi-tiktok"></i>
                    </a>
                    <a href="https://www.google.com/maps/search/?api=1&query=Store+Semlali+Maroc" target="_blank" rel="noopener"
                       class="text-white-50 fs-5 hover-footer-icon">
                        <i class="bi bi-geo-alt"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="border-top border-white-10 mt-4 pt-3 text-center text-white-50 small">
            &copy; 2026 Store Semlali. Tous droits réservés.
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
