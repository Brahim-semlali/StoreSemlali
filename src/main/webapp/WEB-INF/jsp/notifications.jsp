<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Notifications</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>.notif-unread { border-left: 4px solid var(--store-primary); }</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-modern">
    <div class="container">
        <a class="navbar-brand" href="/home">Store Semlali</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/home">Accueil</a>
            <a class="nav-link active" href="/notifications">Notifications</a>
            <a class="nav-link" href="/commandes">Mon panier</a>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="mb-0 fw-bold"><i class="bi bi-bell me-2"></i>Notifications</h2>
        <a href="/home" class="btn btn-modern-outline">← Retour à l&apos;accueil</a>
    </div>

    <c:if test="${not empty notifications}">
        <form method="post" action="/notifications/read-all" class="mb-3">
            <button type="submit" class="btn btn-sm btn-outline-primary">Tout marquer comme lu</button>
        </form>
    </c:if>

    <div class="list-group">
        <c:forEach items="${notifications}" var="n">
            <div class="list-group-item list-group-item-action ${not n.read ? 'notif-unread' : ''} admin-card-modern mb-2">
                <div class="d-flex w-100 justify-content-between">
                    <h6 class="mb-1">
                        <c:choose>
                            <c:when test="${n.type == 'ACCEPTEE'}">
                                <span class="badge bg-success me-2">Acceptée</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger me-2">Refusée</span>
                            </c:otherwise>
                        </c:choose>
                        Commande #${n.reservation.id}
                    </h6>
                    <small>${n.createdAt}</small>
                </div>
                <p class="mb-2">${n.message}</p>
                <c:if test="${not n.read}">
                    <form method="post" action="/notifications/read" class="d-inline">
                        <input type="hidden" name="id" value="${n.id}">
                        <button type="submit" class="btn btn-sm btn-outline-secondary">Marquer comme lu</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty notifications}">
        <div class="text-center text-muted py-5">
            <i class="bi bi-bell" style="font-size:3rem;"></i>
            <p class="mt-2">Aucune notification.</p>
            <p class="small">Vous verrez ici les réponses du responsable à vos demandes de réservation.</p>
        </div>
    </c:if>
</div>

</body>
</html>
