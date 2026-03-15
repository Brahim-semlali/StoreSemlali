<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier le produit | Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>.img-prev { max-width:120px; height:90px; object-fit:cover; border-radius:8px; }</style>
</head>
<body>
<nav class="navbar navbar-dark admin-navbar-modern">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="/home">Store Semlali <span class="badge bg-warning text-dark ms-2">Admin</span></a>
        <a href="/admin/catalogue" class="btn btn-sm btn-outline-light">Retour au catalogue</a>
    </div>
</nav>
<div class="admin-layout">
    <div class="admin-sidebar-modern py-3">
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="/admin/clients"><i class="bi bi-people me-2"></i>Clients</a></li>
            <li class="nav-item"><a class="nav-link" href="/admin/commandes"><i class="bi bi-bag-check me-2"></i>Commandes</a></li>
            <li class="nav-item"><a class="nav-link active" href="/admin/catalogue"><i class="bi bi-grid me-2"></i>Catalogue</a></li>
            <li class="nav-item"><a class="nav-link" href="/admin/categories"><i class="bi bi-folder2 me-2"></i>Catégories</a></li>
        </ul>
    </div>
    <div class="admin-content-modern flex-grow-1">
        <h2 class="mb-4 fw-bold">Modifier le produit</h2>
        <c:if test="${param.error == 'price'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">Prix invalide. Utilisez un nombre (ex: 99.99). <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <c:if test="${param.error == 'update'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">Erreur lors de l'enregistrement (vérifiez le prix et la taille des images). En cas d'erreur 413, privilégiez les <strong>URL</strong> d'images au lieu du téléchargement de fichiers. <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <p class="text-muted small">Pour modifier les images sans erreur 413 : utilisez les champs <strong>URL</strong> (laisser les fichiers vides).</p>
        <div class="admin-card-modern">
            <div class="card-body">
                <form action="/admin/produit/update" method="post" enctype="multipart/form-data" class="row g-3">
                    <input type="hidden" name="id" value="${produit.id}">

                    <div class="col-md-4">
                        <label class="form-label">Nom</label>
                        <input type="text" name="name" class="form-control" value="${produit.name}" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Prix (DH)</label>
                        <input type="number" step="0.01" name="price" class="form-control" value="${produit.price}" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Catégorie</label>
                        <select name="categorieId" class="form-select">
                            <option value="">— Aucune —</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}" ${produit.categorie != null && produit.categorie.id == c.id ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tailles disponibles (ex: S,M,L,XL)</label>
                        <input type="text" name="taillesDisponibles" class="form-control" value="${produit.taillesDisponibles}" placeholder="S,M,L,XL">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Description</label>
                        <input type="text" name="description" class="form-control" value="${produit.description}">
                    </div>

                    <div class="col-12"><hr class="my-2"><label class="form-label">Images (min 1, max 4)</label></div>
                    <div class="col-md-6">
                        <label class="form-label small">Image 1 (principale)</label>
                        <input type="text" name="urlImage" class="form-control form-control-sm" value="${produit.urlImage}" placeholder="URL">
                        <input type="file" name="imageFile" class="form-control form-control-sm mt-1" accept="image/*">
                        <c:if test="${not empty produit.urlImage}"><img src="${produit.urlImage}" class="img-prev mt-2" alt=""></c:if>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small">Image 2</label>
                        <input type="text" name="urlImage2" class="form-control form-control-sm" value="${produit.urlImage2}" placeholder="URL">
                        <input type="file" name="imageFile2" class="form-control form-control-sm mt-1" accept="image/*">
                        <c:if test="${not empty produit.urlImage2}"><img src="${produit.urlImage2}" class="img-prev mt-2" alt=""></c:if>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small">Image 3</label>
                        <input type="text" name="urlImage3" class="form-control form-control-sm" value="${produit.urlImage3}" placeholder="URL">
                        <input type="file" name="imageFile3" class="form-control form-control-sm mt-1" accept="image/*">
                        <c:if test="${not empty produit.urlImage3}"><img src="${produit.urlImage3}" class="img-prev mt-2" alt=""></c:if>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small">Image 4</label>
                        <input type="text" name="urlImage4" class="form-control form-control-sm" value="${produit.urlImage4}" placeholder="URL">
                        <input type="file" name="imageFile4" class="form-control form-control-sm mt-1" accept="image/*">
                        <c:if test="${not empty produit.urlImage4}"><img src="${produit.urlImage4}" class="img-prev mt-2" alt=""></c:if>
                    </div>

                    <div class="col-12 d-flex justify-content-between mt-3">
                        <a href="/admin/catalogue" class="btn btn-outline-secondary">Annuler</a>
                        <button type="submit" class="btn btn-modern"><i class="bi bi-check2 me-1"></i>Enregistrer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
