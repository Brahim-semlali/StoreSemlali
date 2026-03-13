<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fdarna Cuisine</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root{
            --fdarna-primary:#e67e22;
            --fdarna-dark:#2c3e50;
            --fdarna-light:#fff7ec;
        }

        body{
            background:radial-gradient(circle at top left,#fff3e0,#ffe0c2,#ffe8d2);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .navbar{
            background:rgba(44,62,80,0.95) !important;
            backdrop-filter: blur(6px);
            position:sticky;
            top:0;
            z-index:1030;
            box-shadow:0 4px 12px rgba(0,0,0,0.25);
        }

        .navbar-brand{
            font-weight:700;
            letter-spacing:1px;
            display:flex;
            align-items:center;
            gap:0.5rem;
        }

        .navbar-brand img{
            height:40px;
            width:auto;
        }

        .nav-link.active,
        .nav-link:hover{
            color:var(--fdarna-primary) !important;
        }

        .hero{
            position:relative;
            min-height:520px;
            color:white;
            display:flex;
            align-items:center;
            text-align:left;
            overflow:hidden;
        }

        .hero::before{
            content:"";
            position:absolute;
            inset:0;
            background:
                linear-gradient(120deg, rgba(34,34,34,0.9), rgba(34,34,34,0.6)),
                url("https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=1600&q=80") center/cover no-repeat;
            z-index:-1;
        }

        .hero-content{
            max-width:520px;
        }

        .hero-badge{
            display:inline-flex;
            align-items:center;
            gap:0.4rem;
            padding:0.25rem 0.7rem;
            border-radius:999px;
            background:rgba(0,0,0,0.55);
            font-size:0.8rem;
            margin-bottom:1rem;
        }

        .hero h1{
            font-size:2.6rem;
            text-transform:none;
            letter-spacing:1px;
            margin-bottom:0.5rem;
        }

        .hero p{
            margin-top:0.5rem;
            font-size:1.05rem;
            max-width:460px;
            opacity:0.95;
        }

        .hero-meta{
            margin-top:1.5rem;
            display:flex;
            flex-wrap:wrap;
            gap:1.25rem;
            font-size:0.9rem;
            opacity:0.9;
        }

        .btn-cta{
            background:var(--fdarna-primary);
            border:none;
            padding:0.8rem 2.2rem;
            font-weight:600;
            text-transform:uppercase;
            letter-spacing:1px;
            border-radius:999px;
        }

        .card img{
            height:200px;
            object-fit:cover;
        }

        .card{
            border:none;
            border-radius:16px;
            overflow:hidden;
            box-shadow:0 10px 25px rgba(0,0,0,0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover{
            transform:translateY(-6px);
            box-shadow:0 16px 35px rgba(0,0,0,0.12);
        }

        .section-title{
            position:relative;
            display:inline-block;
        }

        .section-title::after{
            content:"";
            position:absolute;
            left:50%;
            transform:translateX(-50%);
            bottom:-8px;
            width:60%;
            height:3px;
            border-radius:999px;
            background:var(--fdarna-primary);
        }

        .contact-card{
            background:white;
            border-radius:16px;
            padding:1.5rem;
            box-shadow:0 8px 20px rgba(0,0,0,0.05);
        }

        .social-link{
            text-decoration:none;
            color:inherit;
        }

        .social-link:hover{
            color:var(--fdarna-primary);
        }

        footer{
            background:var(--fdarna-dark);
        }

        /* ------ Responsive (mobile & tablettes) ------ */
        @media (max-width: 991.98px) {
            .navbar{
                padding-block:0.35rem;
            }

            .hero{
                min-height:420px;
                text-align:center;
                padding-top:3.5rem;
                padding-bottom:2.5rem;
            }

            .hero::before{
                background:
                    linear-gradient(150deg, rgba(34,34,34,0.92), rgba(34,34,34,0.7)),
                    url("https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=1200&q=80") center/cover no-repeat;
            }

            .hero-content{
                margin-inline:auto;
            }

            .hero h1{
                font-size:2.1rem;
            }

            .hero p{
                font-size:0.98rem;
            }

            .hero-meta{
                flex-direction:column;
                align-items:flex-start;
                gap:0.5rem;
            }

            .card img{
                height:170px;
            }
        }

        @media (max-width: 575.98px) {
            .navbar-brand span{
                font-size:1.05rem;
            }

            .hero{
                min-height:auto;
            }

            .hero h1{
                font-size:1.8rem;
            }

            .hero-badge{
                font-size:0.75rem;
            }

            .section-title::after{
                width:40%;
            }

            .contact-card{
                padding:1.1rem;
            }

            .card{
                border-radius:14px;
            }

            .card img{
                height:150px;
            }
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/home">
            <img src="<c:url value='/image/logo1.png'/>">
            <span>FdarnaCuisine</span>
        </a>
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item"><a class="nav-link" href="/home">Accueil</a></li>
                <li class="nav-item"><a class="nav-link" href="#catalogue">Catalogue</a></li>
                <li class="nav-item"><a class="nav-link" href="/commandes">Mes commandes</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                <c:choose>
                    <c:when test="${not empty user}">
                        <li class="nav-item ms-lg-3">
                            <span class="nav-link disabled text-white-50">
                                ${user.fullname}
                            </span>
                        </li>
                        <li class="nav-item ms-lg-2">
                            <a class="btn btn-sm btn-outline-warning" href="/logout">Se déconnecter</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item ms-lg-3">
                            <a class="btn btn-sm btn-outline-light" href="/login">Se connecter</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="container py-5">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <div class="hero-content">
                    <div class="hero-badge">
                        <i class="bi bi-egg-fried"></i>
                        <span>Cuisine marocaine fait maison</span>
                    </div>
                    <h1>Saveurs maison livrées à Marrakech</h1>
                    <p>Des plats préparés comme à la maison, avec des recettes familiales et des produits frais, livrés directement à votre porte.</p>
                    <div class="mt-4 d-flex flex-wrap gap-3">
                        <a href="#catalogue" class="btn btn-cta text-white">
                            Voir le catalogue
                        </a>
                        <a href="/commandes" class="btn btn-outline-light">
                            Voir mon panier
                        </a>
                    </div>
                    <div class="hero-meta mt-4">
                        <span><i class="bi bi-geo-alt me-1"></i>Livraison à Marrakech uniquement</span>
                        <span><i class="bi bi-clock-history me-1"></i>Commandes à l&apos;avance pour vos événements</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CATALOGUE -->
<section class="container mt-5" id="catalogue">
    <h2 class="text-center mb-3 section-title">Catalogue des repas</h2>

    <!-- Barre de recherche -->
    <div class="row mb-4">
        <div class="col-md-6 mx-auto">
            <div class="input-group shadow-sm">
                <span class="input-group-text bg-white border-end-0">
                    <i class="bi bi-search text-muted"></i>
                </span>
                <input type="text"
                       id="searchCatalogue"
                       class="form-control border-start-0"
                       placeholder="Rechercher un plat (ex : tajine, couscous, dessert)...">
            </div>
        </div>
    </div>

    <div class="row" id="catalogueList">
        <c:forEach var="repas" items="${repasList}">
            <div class="col-6 col-md-4 mb-4 catalogue-item" data-name="${repas.name}">
                <div class="card h-100">
                    <img src="${repas.urlImage}" class="card-img-top" alt="${repas.name}">
                    <div class="card-body d-flex flex-column">
                        <div class="mb-2">
                            <h6 class="mb-1">${repas.name}</h6>
                            <p class="mb-0 small text-muted">Prix : <strong>${repas.price} DH</strong></p>
                        </div>
                        <form method="post" action="/commande" class="mt-auto">
                            <input type="hidden" name="repasId" value="${repas.id}" />
                            <input type="number" name="quantite" class="form-control form-control-sm mb-2" placeholder="Quantité" min="1" value="1">
                            <div class="d-flex gap-2">
                                <button type="submit" name="btnAction" value="panier" class="btn btn-outline-success btn-sm w-50">
                                    Ajouter
                                </button>
                                <button type="submit" name="btnAction" value="commander" class="btn btn-success btn-sm w-50">
                                    Commander
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<!-- COMMENT COMMANDER -->
<section class="container mt-5">
    <h2 class="text-center mb-4 section-title">Comment commander ?</h2>
    <div class="row text-center">
        <div class="col-md-4">
            <h4>1</h4>
            <p>Choisissez votre repas dans le catalogue</p>
        </div>
        <div class="col-md-4">
            <h4>2</h4>
            <p>Indiquez la quantité</p>
        </div>
        <div class="col-md-4">
            <h4>3</h4>
            <p>Nous préparons et livrons à Marrakech</p>
        </div>
    </div>
</section>

<!-- CONTACT -->
<section class="container mt-5" id="contact">
    <h2 class="text-center mb-4 section-title">Contact</h2>
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="contact-card">
                <h5 class="mb-3">Écrivez-nous</h5>
                <form>
                    <div class="row">
                        <div class="col-md-6">
                            <input type="text" class="form-control mb-3" placeholder="Nom">
                        </div>
                        <div class="col-md-6">
                            <input type="email" class="form-control mb-3" placeholder="Email">
                        </div>
                    </div>
                    <textarea class="form-control mb-3" rows="4" placeholder="Votre message"></textarea>
                    <button class="btn btn-cta text-white">Envoyer</button>
                </form>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="contact-card h-100 d-flex flex-column justify-content-between">
                <div>
                    <h5 class="mb-3">Retrouvez Fdarna Cuisine</h5>
                    <p class="mb-3 text-muted">Suivez nos nouveautés, menus du jour et coulisses de la cuisine sur nos réseaux sociaux.</p>
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-instagram fs-3 me-3 text-danger"></i>
                        <div>
                            <div class="fw-semibold">Instagram</div>
                            <a class="social-link small" target="_blank"
                               href="https://www.instagram.com/f_darna_cuisine?utm_source=ig_web_button_share_sheet&amp;igsh=ZDNlZDc0MzIxNw==">
                                @f_darna_cuisine
                            </a>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-tiktok fs-3 me-3"></i>
                        <div>
                            <div class="fw-semibold">TikTok</div>
                            <a class="social-link small" target="_blank"
                               href="https://www.tiktok.com/@fdarna_cuisine?_r=1&_t=ZS-94eIL2jid4G">
                                @f_darna_cuisine
                            </a>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-1">
                        <i class="bi bi-whatsapp fs-3 me-3 text-success"></i>
                        <div>
                            <div class="fw-semibold">WhatsApp</div>
                            <a class="social-link small" target="_blank"
                               href="https://wa.me/212634801200">
                                +212 6 34 80 12 00
                            </a>
                        </div>
                    </div>
                </div>
                <small class="text-muted mt-3">Disponible pour vos commandes et questions à propos de nos plats maison.</small>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer class="text-white text-center mt-5 p-4">
    <p class="mb-1">FdarnaCuisine &mdash; Repas faits maison livrés à Marrakech</p>
    <small class="text-white-50">Suivez-nous sur Instagram et TikTok, ou écrivez-nous sur WhatsApp pour passer commande.</small>
</footer>

<script>
    // Filtrage simple du catalogue côté client
    document.addEventListener('DOMContentLoaded', function () {
        var input = document.getElementById('searchCatalogue');
        if (!input) return;
        var items = document.querySelectorAll('#catalogueList .catalogue-item');

        input.addEventListener('input', function () {
            var query = this.value.toLowerCase().trim();
            items.forEach(function (el) {
                var name = (el.getAttribute('data-name') || '').toLowerCase();
                el.style.display = (query === '' || name.indexOf(query) !== -1) ? '' : 'none';
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>