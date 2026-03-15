<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Commandes | Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
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
            <li class="nav-item"><a class="nav-link active" href="/admin/commandes"><i class="bi bi-bag-check me-2"></i>Commandes</a></li>
            <li class="nav-item"><a class="nav-link" href="/admin/catalogue"><i class="bi bi-grid me-2"></i>Catalogue</a></li>
            <li class="nav-item"><a class="nav-link" href="/admin/categories"><i class="bi bi-folder2 me-2"></i>Catégories</a></li>
        </ul>
    </div>
    <div class="admin-content-modern flex-grow-1">
        <h2 class="mb-4 fw-bold">Commandes</h2>
        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
            <p class="text-muted mb-0">Gérer les commandes et accepter / refuser les demandes.</p>
            <c:choose>
                <c:when test="${showAll}">
                    <a href="/admin/commandes" class="btn btn-sm btn-modern-outline">7 derniers jours</a>
                </c:when>
                <c:otherwise>
                    <a href="/admin/commandes?all=true" class="btn btn-sm btn-modern-outline">Tout l'historique</a>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="admin-card-modern">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 admin-table-modern">
                        <thead>
                        <tr>
                            <th>Date</th>
                            <th>Client</th>
                            <th>Email</th>
                            <th>Tél</th>
                            <th>Adresse</th>
                            <th>Détail</th>
                            <th>Total</th>
                            <th>Statut</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${reservations}" var="r">
                            <tr>
                                <td><small>${r.dateCreation}</small></td>
                                <td>${r.nomComplet}</td>
                                <td>${r.user != null ? r.user.email : '-'}</td>
                                <td>${r.telephone}</td>
                                <td><small>${r.adresse}</small></td>
                                <td>
                                    <ul class="list-unstyled small mb-0">
                                        <c:forEach items="${r.commandes}" var="cmd">
                                            <li>${cmd.quantity} × ${cmd.produitName} — ${cmd.total} DH</li>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <td><strong>${r.total} DH</strong></td>
                                <td>
                                    <span class="badge ${r.status == 'EN_ATTENTE' ? 'bg-warning text-dark' : r.status == 'CONFIRMEE' ? 'bg-success' : 'bg-secondary'}">${r.status}</span>
                                </td>
                                <td>
                                    <c:if test="${r.status == 'EN_ATTENTE'}">
                                        <button type="button" class="btn btn-sm btn-success me-1" data-bs-toggle="modal" data-bs-target="#modalReponse" data-id="${r.id}" data-action="accept">Accepter</button>
                                        <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#modalReponse" data-id="${r.id}" data-action="refuse">Refuser</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty reservations}">
                            <tr><td colspan="9" class="text-center text-muted py-4">Aucune commande.</td></tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modalReponse" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="formReponse" method="post" action="">
                <input type="hidden" name="reservationId" id="reservationId" value="">
                <div class="modal-header">
                    <h5 class="modal-title">Réponse au client</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label">Message (optionnel)</label>
                    <textarea name="message" class="form-control" rows="3"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Envoyer</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById('modalReponse').addEventListener('show.bs.modal', function(e) {
    var btn = e.relatedTarget;
    if (!btn) return;
    document.getElementById('reservationId').value = btn.getAttribute('data-id') || '';
    document.getElementById('formReponse').action = btn.getAttribute('data-action') === 'accept' ? '/admin/reservation/accept' : '/admin/reservation/refuse';
});
</script>
</body>
</html>
