<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Catégories | Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>.cat-img { width:80px; height:80px; object-fit:cover; border-radius:10px; background:#e2e8f0; }</style>
</head>
<body>
<nav class="navbar navbar-dark admin-navbar-modern">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="/home">Store Semlali <span class="badge bg-warning text-dark ms-2">Admin</span></a>
        <a href="/admin/catalogue" class="btn btn-sm btn-outline-light">Catalogue</a>
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
        <h2 class="mb-4 fw-bold">Gestion des catégories</h2>

        <!-- Ajouter une catégorie -->
        <div class="admin-card-modern mb-4">
            <div class="card-body">
                <h5 class="card-title mb-3"><i class="bi bi-folder-plus me-2 text-success"></i>Ajouter une catégorie</h5>
                <form action="/admin/categorie/add" method="post" enctype="multipart/form-data" class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label small mb-0">Nom</label>
                        <input type="text" name="name" class="form-control" placeholder="ex: Pantalon, T-shirt" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small mb-0">Image (URL)</label>
                        <input type="text" name="imageUrl" class="form-control" placeholder="https://... ou /uploads/...">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small mb-0">Ou fichier image</label>
                        <input type="file" name="imageFile" class="form-control form-control-sm" accept="image/*">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-modern w-100">Ajouter</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Liste des catégories -->
        <div class="admin-card-modern">
            <div class="card-body">
                <h5 class="card-title mb-3"><i class="bi bi-folder2 me-2"></i>Catégories</h5>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 admin-table-modern">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Nom</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${categories}" var="cat">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty cat.imageUrl}">
                                                <img src="${cat.imageUrl}" alt="${cat.name}" class="cat-img" onerror="this.classList.add('d-none'); this.nextElementSibling.classList.remove('d-none');">
                                                <div class="cat-img d-none d-flex align-items-center justify-content-center text-muted"><i class="bi bi-image fs-4"></i></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="cat-img d-flex align-items-center justify-content-center text-muted"><i class="bi bi-image fs-4"></i></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><strong>${cat.name}</strong></td>
                                    <td class="text-end">
                                        <a href="/admin/categorie/edit?id=${cat.id}" class="btn btn-sm btn-outline-primary me-1">Modifier</a>
                                        <form action="/admin/categorie/delete" method="post" class="d-inline" onsubmit="return confirm('ATTENTION : Supprimer cette catégorie ?\n\nTous les produits liés à cette catégorie seront également supprimés de la table des produits (et leurs avis). Cette action est irréversible.');">
                                            <input type="hidden" name="id" value="${cat.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">Supprimer</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${empty categories}">
                    <p class="text-muted mb-0 mt-3">Aucune catégorie. Ajoutez-en une ci-dessus.</p>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
