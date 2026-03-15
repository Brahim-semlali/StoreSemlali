<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Catalogue | Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>.table img { width:60px; height:45px; object-fit:cover; border-radius:8px; }</style>
</head>
<body>
<nav class="navbar navbar-dark admin-navbar-modern">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="/home">Store Semlali <span class="badge bg-warning text-dark ms-2">Admin</span></a>
        <a href="/home" class="btn btn-sm btn-outline-light">Retour au site</a>
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
        <h2 class="mb-4">Catalogue</h2>
        <c:if test="${param.error == 'min1image'}">
            <div class="alert alert-warning">Au moins 1 image est requise pour un produit.</div>
        </c:if>

        <p class="mb-3"><a href="/admin/categories" class="btn btn-outline-success"><i class="bi bi-folder2 me-1"></i>Gérer les catégories</a> (ajouter, modifier, supprimer, image)</p>

        <!-- Un seul formulaire : images par URL ou par fichier -->
        <div class="admin-card-modern mb-4">
            <div class="card-body">
                <h5 class="card-title mb-3"><i class="bi bi-plus-circle me-2 text-primary"></i>Ajouter un produit</h5>
                <p class="small text-muted mb-3">Pour chaque image : indiquez une <strong>URL</strong> (ex. https://...) <strong>ou</strong> choisissez un <strong>fichier</strong>. Au moins l'image 1 est obligatoire.</p>
                <form id="formAddProduit" action="/admin/produit/add-by-url" method="post" class="row g-3">
                    <div class="col-md-2"><label class="form-label small">Nom</label><input type="text" name="name" class="form-control" required></div>
                    <div class="col-md-2"><label class="form-label small">Prix (DH)</label><input type="number" name="price" step="0.01" class="form-control" required></div>
                    <div class="col-md-2"><label class="form-label small">Catégorie</label>
                        <select name="categorieId" class="form-select">
                            <option value="">— Aucune —</option>
                            <c:forEach items="${categories}" var="c"><option value="${c.id}">${c.name}</option></c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2"><label class="form-label small">Tailles</label><input type="text" name="taillesDisponibles" class="form-control" placeholder="S,M,L,XL"></div>
                    <div class="col-md-4"><label class="form-label small">Description</label><input type="text" name="description" class="form-control"></div>
                    <div class="col-12">
                        <label class="form-label small">Images (1 à 4) — URL ou fichier</label>
                        <div class="row g-3">
                            <div class="col-md-6 col-lg-3">
                                <label class="form-label small text-muted">Image 1 *</label>
                                <input type="text" name="urlImage" class="form-control form-control-sm" placeholder="URL (https://... ou /uploads/...)">
                                <input type="file" id="file1" class="form-control form-control-sm mt-1" accept="image/*">
                            </div>
                            <div class="col-md-6 col-lg-3">
                                <label class="form-label small text-muted">Image 2</label>
                                <input type="text" name="urlImage2" class="form-control form-control-sm" placeholder="URL">
                                <input type="file" id="file2" class="form-control form-control-sm mt-1" accept="image/*">
                            </div>
                            <div class="col-md-6 col-lg-3">
                                <label class="form-label small text-muted">Image 3</label>
                                <input type="text" name="urlImage3" class="form-control form-control-sm" placeholder="URL">
                                <input type="file" id="file3" class="form-control form-control-sm mt-1" accept="image/*">
                            </div>
                            <div class="col-md-6 col-lg-3">
                                <label class="form-label small text-muted">Image 4</label>
                                <input type="text" name="urlImage4" class="form-control form-control-sm" placeholder="URL">
                                <input type="file" id="file4" class="form-control form-control-sm mt-1" accept="image/*">
                            </div>
                        </div>
                        <small class="text-muted d-block mt-1" id="uploadStatus"></small>
                    </div>
                    <div class="col-12"><button type="submit" class="btn btn-modern" id="btnAddWithFile">Ajouter le produit</button></div>
                </form>
            </div>
        </div>

        <!-- Liste de tous les produits -->
        <div class="admin-card-modern">
            <div class="card-body">
                <h5 class="card-title mb-3"><i class="bi bi-list-ul me-2"></i>Tous les produits</h5>
                <div class="table-responsive">
                    <table class="table align-middle mb-0 admin-table-modern">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Nom</th>
                            <th>Prix</th>
                            <th>Catégorie</th>
                            <th>Tailles</th>
                            <th>Visible</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${produitList}" var="p">
                            <tr class="${p.visible ? '' : 'table-secondary'}">
                                <td>${p.id}</td>
                                <td><img src="${p.urlImage}" alt="${p.name}" style="width:60px;height:45px;object-fit:cover;" onerror="this.src='https://placehold.co/60x45/e2e8f0/64748b?text=+'; this.onerror=null;"></td>
                                <td>${p.name}</td>
                                <td>${p.price} DH</td>
                                <td>${p.category}</td>
                                <td>${p.taillesDisponibles}</td>
                                <td>
                                    <form action="/admin/produit/toggle-visibility" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <c:choose>
                                            <c:when test="${p.visible}">
                                                <span class="badge bg-success">Visible</span>
                                                <button type="submit" class="btn btn-sm btn-outline-warning">Masquer</button>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Masqué</span>
                                                <button type="submit" class="btn btn-sm btn-outline-success">Afficher</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </td>
                                <td>
                                    <a href="/admin/produit/edit?id=${p.id}" class="btn btn-sm btn-outline-primary me-1">Modifier</a>
                                    <form action="/admin/produit/delete" method="post" class="d-inline" onsubmit="return confirm('Supprimer ce produit ?');">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">Supprimer</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty produitList}">
                            <tr><td colspan="8" class="text-center text-muted py-4">Aucun produit.</td></tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
(function(){
    var form = document.getElementById('formAddProduit');
    if (!form) return;
    form.addEventListener('submit', function(e){
        var file1 = document.getElementById('file1');
        var file2 = document.getElementById('file2');
        var file3 = document.getElementById('file3');
        var file4 = document.getElementById('file4');
        var url1 = form.querySelector('input[name="urlImage"]');
        var url2 = form.querySelector('input[name="urlImage2"]');
        var url3 = form.querySelector('input[name="urlImage3"]');
        var url4 = form.querySelector('input[name="urlImage4"]');
        var hasUrl1 = url1 && url1.value.trim();
        var hasFile = (file1 && file1.files.length) || (file2 && file2.files.length) || (file3 && file3.files.length) || (file4 && file4.files.length);
        if (!hasUrl1 && !hasFile) { e.preventDefault(); alert('Renseignez au moins une URL ou un fichier pour l\'image 1.'); return; }
        if (!hasFile) return;
        e.preventDefault();
        var status = document.getElementById('uploadStatus');
        var btn = document.getElementById('btnAddWithFile');
        btn.disabled = true;
        status.textContent = 'Upload des images...';
        var uploads = [];
        function doUpload(fileInput, urlInput, next){
            if (!fileInput || !fileInput.files || !fileInput.files[0]) { next(); return; }
            var fd = new FormData();
            fd.append('file', fileInput.files[0]);
            fetch('/admin/upload-image', { method: 'POST', body: fd })
                .then(function(r){ return r.text(); })
                .then(function(url){ if (url && urlInput) urlInput.value = url; next(); })
                .catch(function(){ status.textContent = 'Erreur upload.'; btn.disabled = false; });
        }
        doUpload(file1, url1, function(){
            doUpload(file2, url2, function(){
                doUpload(file3, url3, function(){
                    doUpload(file4, url4, function(){
                        if (!form.querySelector('input[name="urlImage"]').value.trim()) { status.textContent = 'Image 1 obligatoire.'; btn.disabled = false; return; }
                        status.textContent = ''; form.submit();
                    });
                });
            });
        });
    });
})();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
