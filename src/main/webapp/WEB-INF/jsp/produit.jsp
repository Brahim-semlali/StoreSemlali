<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:out value="${produit.name}" default="Produit"/> - Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>
        .main-img{ border-radius:var(--radius-lg); max-height:480px; object-fit:cover; width:100%; box-shadow:var(--shadow-md); }
        .thumb{ width:72px; height:72px; object-fit:cover; border-radius:12px; cursor:pointer; border:3px solid transparent; transition: border-color 0.2s; }
        .thumb:hover, .thumb.active{ border-color:var(--store-primary); }
        .star{ color:#f59e0b; }
        .star.empty{ color:#e2e8f0; }
        .cursor-pointer{ cursor:pointer; }
        .star-display:hover{ opacity:0.85; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-modern">
    <div class="container">
        <a class="navbar-brand" href="/home">Store Semlali</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/home">Accueil</a>
            <c:if test="${produit.categorieId != null}">
                <a class="nav-link" href="<c:url value='/categorie?id=${produit.categorieId}'/>"><c:out value="${produit.categorieName}" default="Catégorie"/></a>
            </c:if>
            <a class="nav-link" href="/commandes">Mon panier</a>
        </div>
    </div>
</nav>

<div class="container py-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-modern">
            <li class="breadcrumb-item"><a href="/home">Accueil</a></li>
            <c:if test="${produit.categorieId != null}">
                <li class="breadcrumb-item"><a href="<c:url value='/categorie?id=${produit.categorieId}'/>"><c:out value="${produit.categorieName}" default="Catégorie"/></a></li>
            </c:if>
            <li class="breadcrumb-item active"><c:out value="${produit.name}" default="Produit"/></li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <img id="mainImage" src="<c:out value='${produit.urlImage}'/>" alt="<c:out value='${produit.name}'/>" class="main-img mb-2" loading="lazy" onerror="this.src='https://placehold.co/300x400/e2e8f0/64748b?text=Image+non+disponible'; this.onerror=null;">
            <div class="d-flex gap-2 flex-wrap">
                <img src="<c:out value='${produit.urlImage}'/>" alt="" class="thumb active" data-src="<c:out value='${produit.urlImage}'/>" loading="lazy" onerror="this.src='https://placehold.co/80/e2e8f0/64748b?text=+'; this.onerror=null;">
                <c:if test="${not empty produit.urlImage2}">
                    <img src="${produit.urlImage2}" alt="" class="thumb" data-src="${produit.urlImage2}" loading="lazy">
                </c:if>
                <c:if test="${not empty produit.urlImage3}">
                    <img src="${produit.urlImage3}" alt="" class="thumb" data-src="${produit.urlImage3}" loading="lazy">
                </c:if>
                <c:if test="${not empty produit.urlImage4}">
                    <img src="${produit.urlImage4}" alt="" class="thumb" data-src="${produit.urlImage4}" loading="lazy">
                </c:if>
            </div>
        </div>
        <div class="col-lg-6">
            <h1 class="mb-2"><c:out value="${produit.name}" default="Produit"/></h1>
            <p class="text-muted mb-2">
                <c:if test="${not empty produit.categorieName}">
                    <span class="badge bg-secondary"><c:out value="${produit.categorieName}"/></span>
                </c:if>
                <c:if test="${not empty produit.taillesDisponibles}">
                    <span class="badge bg-light text-dark ms-1">Tailles : ${produit.taillesDisponibles}</span>
                </c:if>
            </p>
            <p class="display-6 text-store-primary fw-bold mb-3"><c:out value="${produit.price}" default="0"/> DH</p>
            <c:if test="${not empty produit.description}">
                <p class="text-muted mb-4">${produit.description}</p>
            </c:if>

            <%-- Note moyenne --%>
            <div class="mb-3" id="noteMoyenneBlock">
                <span class="text-warning">
                    <c:forEach begin="1" end="5" var="i">
                        <i class="bi bi-star-fill ${(noteMoyenneArrondie != null && i <= noteMoyenneArrondie) ? 'star' : 'star empty'}"></i>
                    </c:forEach>
                </span>
                <span class="ms-2 text-muted">(<fmt:formatNumber value="${noteMoyenne}" maxFractionDigits="1" groupingUsed="false"/> / 5 — ${fn:length(avisList)} avis)</span>
            </div>

            <form method="post" action="/commande" class="mb-4">
                <input type="hidden" name="produitId" value="${produit.id}">
                <div class="row g-2 align-items-end">
                    <div class="col-auto">
                        <label class="form-label small mb-0">Quantité</label>
                        <input type="number" name="quantite" class="form-control" min="1" value="1" style="width:90px;">
                    </div>
                    <div class="col-auto">
                        <button type="submit" name="btnAction" value="panier" class="btn btn-modern-outline">Ajouter au panier</button>
                        <button type="submit" name="btnAction" value="commander" class="btn btn-modern">Commander</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- Commentaires des utilisateurs (nom + commentaire associés au produit) --%>
    <hr class="my-5">
    <h2 id="avis" class="mb-4">Avis et commentaires</h2>
    <p class="text-muted mb-4">Les commentaires ci-dessous sont associés à ce produit et affichent le nom de l'utilisateur.</p>

    <c:if test="${param.error == 'note'}">
        <div class="alert alert-warning">Veuillez choisir une note entre 1 et 5 étoiles.</div>
    </c:if>
    <c:if test="${avisAjoute == true}">
        <div class="alert alert-success alert-dismissible fade show">Votre avis a bien été publié. Merci&nbsp;!</div>
    </c:if>

    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">Laisser un avis</h5>
            <form method="post" action="/avis/add" id="formAvis">
                <input type="hidden" name="produitId" value="${produit.id}">
                <div class="mb-3">
                    <label class="form-label fw-bold">Votre note <span class="text-danger">*</span></label>
                    <div class="d-flex align-items-center gap-1 flex-wrap" id="starChoice">
                        <c:forEach begin="1" end="5" var="i">
                            <label class="mb-0 me-1 cursor-pointer">
                                <input type="radio" name="note" value="${i}" required class="d-none" data-star="${i}">
                                <span class="star-display" data-value="${i}" title="${i} étoile(s)"><i class="bi bi-star fs-2"></i></span>
                            </label>
                        </c:forEach>
                        <span class="ms-2 small text-muted" id="starLabel">Cliquez pour choisir</span>
                    </div>
                    <p class="small text-muted mt-1 mb-0">La note en étoiles est obligatoire.</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">Commentaire (optionnel)</label>
                    <textarea name="commentaire" class="form-control" rows="3" placeholder="Votre avis sur ce produit..." maxlength="2000"></textarea>
                </div>
                <c:if test="${empty user}">
                    <div class="mb-3">
                        <label class="form-label">Votre nom (optionnel)</label>
                        <input type="text" name="auteurNom" class="form-control" placeholder="Nom affiché avec l'avis" maxlength="100">
                    </div>
                </c:if>
                <button type="submit" class="btn btn-primary">Publier l'avis</button>
            </form>
        </div>
    </div>

    <div class="list-unstyled">
        <c:forEach var="avis" items="${avisList}">
            <li class="avis-card-modern mb-3">
                <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                    <div class="d-flex align-items-center flex-wrap">
                        <span class="text-warning me-2" title="${avis.note != null ? avis.note : 0} / 5">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="bi bi-star-fill ${(avis.note != null && i <= avis.note) ? '' : 'text-secondary'}"></i>
                            </c:forEach>
                        </span>
                        <span class="text-muted small me-2">Par</span>
                        <strong>${avis.displayName}</strong>
                    </div>
                    <small class="text-muted"><fmt:formatDate value="${avis.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                </div>
                <c:if test="${not empty avis.commentaire}">
                    <p class="mb-0 mt-2 text-dark">${avis.commentaire}</p>
                </c:if>
                <c:if test="${empty avis.commentaire}">
                    <p class="mb-0 mt-2 text-muted fst-italic">Aucun commentaire texte.</p>
                </c:if>
            </li>
        </c:forEach>
    </div>
    <c:if test="${empty avisList}">
        <p class="text-muted">Aucun avis pour le moment. Soyez le premier à donner votre avis !</p>
    </c:if>
    <hr class="my-5">

    <c:if test="${not empty recoProduits}">
        <h2 class="mb-4">Nos clients ont aussi regardé</h2>
        <div class="row g-4">
            <c:forEach var="p" items="${recoProduits}">
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="card-modern card h-100">
                        <a href="<c:url value='/produit?id=${p.id}'/>" class="text-decoration-none text-dark d-block h-100">
                            <div class="product-card-img-wrapper ${not empty p.urlImage2 ? 'has-second' : 'single'}">
                                <img src="${p.urlImage}" class="product-img-main" alt="${p.name}" loading="lazy" onerror="this.src='https://placehold.co/300x400/e2e8f0/64748b?text=Image+non+disponible'; this.onerror=null;">
                                <c:if test="${not empty p.urlImage2}">
                                    <img src="${p.urlImage2}" class="product-img-alt" alt="${p.name}">
                                </c:if>
                            </div>
                            <div class="card-body text-center">
                                <h6 class="card-title mb-1">${p.name}</h6>
                                <p class="mb-0 small fw-bold text-store-primary">${p.price} DH</p>
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<script>
(function(){
    var main = document.getElementById('mainImage');
    document.querySelectorAll('.thumb').forEach(function(t){
        t.addEventListener('click', function(){
            document.querySelectorAll('.thumb').forEach(function(x){ x.classList.remove('active'); });
            t.classList.add('active');
            if(main) main.src = t.getAttribute('data-src');
        });
    });
    var formAvis = document.getElementById('formAvis');
    if (formAvis) {
        var stars = formAvis.querySelectorAll('.star-display');
        var radios = formAvis.querySelectorAll('input[name=note]');
        var starLabel = document.getElementById('starLabel');
        function updateStarDisplay(selected){
            stars.forEach(function(s, i){
                var v = parseInt(s.getAttribute('data-value'), 10);
                var icon = s.querySelector('i');
                if (icon) {
                    icon.className = 'bi ' + (v <= selected ? 'bi-star-fill text-warning' : 'bi-star text-secondary');
                }
            });
            if (starLabel) starLabel.textContent = selected ? selected + ' étoile(s)' : 'Cliquez pour choisir';
        }
        stars.forEach(function(s){
            s.addEventListener('click', function(){
                var v = parseInt(this.getAttribute('data-value'), 10);
                var radio = formAvis.querySelector('input[name=note][value="'+v+'"]');
                if(radio){ radio.checked = true; updateStarDisplay(v); }
            });
        });
        radios.forEach(function(r){
            r.addEventListener('change', function(){ updateStarDisplay(parseInt(this.value,10)); });
        });
    }
})();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
