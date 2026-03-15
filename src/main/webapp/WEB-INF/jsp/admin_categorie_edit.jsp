<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier la catégorie | Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>.img-prev { max-width:160px; height:120px; object-fit:cover; border-radius:10px; }</style>
</head>
<body>
<nav class="navbar navbar-dark admin-navbar-modern">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="/home">Store Semlali <span class="badge bg-warning text-dark ms-2">Admin</span></a>
        <a href="/admin/categories" class="btn btn-sm btn-outline-light">Retour aux catégories</a>
    </div>
</nav>
<div class="admin-layout">
    <div class="admin-sidebar-modern py-3">
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="/admin/clients"><i class="bi bi-people me-2"></i>Clients</a></li>
            <li class="nav-item"><a class="nav-link" href="/admin/commandes"><i class="bi bi-bag-check me-2"></i>Commandes</a></li>
            <li class="nav-item"><a class="nav-link" href="/admin/catalogue"><i class="bi bi-grid me-2"></i>Catalogue</a></li>
            <li class="nav-item"><a class="nav-link active" href="/admin/categories"><i class="bi bi-folder2 me-2"></i>Catégories</a></li>
        </ul>
    </div>
    <div class="admin-content-modern flex-grow-1">
        <h2 class="mb-4 fw-bold">Modifier la catégorie</h2>
        <div class="admin-card-modern">
            <div class="card-body">
                <form action="/admin/categorie/update" method="post" enctype="multipart/form-data" class="row g-3">
                    <input type="hidden" name="id" value="${categorie.id}">
                    <div class="col-md-6">
                        <label class="form-label">Nom</label>
                        <input type="text" name="name" class="form-control" value="${categorie.name}" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Image (URL ou fichier)</label>
                        <div class="row g-2">
                            <div class="col-md-6">
                                <input type="text" name="imageUrl" class="form-control" value="${categorie.imageUrl}" placeholder="URL ou /uploads/...">
                            </div>
                            <div class="col-md-4">
                                <input type="file" name="imageFile" class="form-control" accept="image/*">
                            </div>
                        </div>
                        <c:if test="${not empty categorie.imageUrl}">
                            <p class="small text-muted mt-2 mb-0">Image actuelle :</p>
                            <img src="${categorie.imageUrl}" alt="" class="img-prev mt-1" onerror="this.style.display='none';">
                        </c:if>
                    </div>
                    <div class="col-12 d-flex gap-2">
                        <button type="submit" class="btn btn-modern"><i class="bi bi-check2 me-1"></i>Enregistrer</button>
                        <a href="/admin/categories" class="btn btn-outline-secondary">Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
