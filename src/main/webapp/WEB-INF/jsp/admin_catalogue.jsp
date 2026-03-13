<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Catalogue</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body{
            background:radial-gradient(circle at top left,#fff3e0,#ffe0c2,#ffe8d2);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .admin-navbar{
            background:#2c3e50;
            color:#fff;
        }

        .admin-navbar .navbar-brand{
            font-weight:600;
        }

        .badge-env{
            font-size:0.75rem;
        }

        .admin-wrapper{
            padding-top:2rem;
        }

        .card{
            border:none;
            border-radius:18px;
            box-shadow:0 12px 30px rgba(0,0,0,0.08);
        }

        .table thead th{
            border-bottom:0;
        }

        .table tbody tr:hover{
            background:#fff8ef;
        }

        /* -------- Responsive admin -------- */
        @media (max-width: 991.98px) {
            .admin-wrapper{
                padding-top:1.5rem;
            }

            .card{
                border-radius:14px;
                box-shadow:0 8px 22px rgba(0,0,0,0.06);
            }

            .admin-navbar .navbar-brand{
                font-size:1.05rem;
            }
        }

        @media (max-width: 767.98px) {
            .admin-wrapper{
                padding-top:1.25rem;
            }

            .card-title{
                font-size:1rem;
            }

            form.row.g-3 > .col-md-3,
            form.row.g-3 > .col-md-2,
            form.row.g-3 > .col-md-1{
                flex:0 0 100%;
                max-width:100%;
            }

            .table-responsive{
                font-size:0.85rem;
            }

            .table img{
                width:80px !important;
                height:55px !important;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg admin-navbar">
    <div class="container">
        <a class="navbar-brand" href="/home">
            Fdarna Cuisine <span class="badge bg-warning text-dark badge-env ms-2">Admin</span>
        </a>
        <div class="ms-auto">
            <a href="/home" class="btn btn-sm btn-outline-light">Retour au site</a>
        </div>
    </div>
</nav>

<div class="container admin-wrapper pb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-1">Gestion du catalogue</h2>
            <small class="text-muted">Ajouter, modifier ou supprimer les repas affichés sur la page d&apos;accueil.</small>
        </div>
        <span class="text-muted small d-none d-md-inline">
            Total repas : <strong>${fn:length(repasList)}</strong>
        </span>
    </div>

    <!-- Statistiques du site -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="card h-100">
                <div class="card-body py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-muted small">Clients inscrits</div>
                            <div class="fw-bold fs-5">${totalClientsInscrits}</div>
                        </div>
                        <span class="badge bg-success-subtle text-success border border-success-subtle">
                            <i class="bi bi-people-fill"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card h-100">
                <div class="card-body py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-muted small">Clients ayant commandé</div>
                            <div class="fw-bold fs-5">${clientsAyantCommande}</div>
                        </div>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle">
                            <i class="bi bi-bag-check"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card h-100">
                <div class="card-body py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-muted small">Inscrits sans commande</div>
                            <div class="fw-bold fs-5">${clientsInscritsSansCommande}</div>
                        </div>
                        <span class="badge bg-warning-subtle text-warning border border-warning-subtle">
                            <i class="bi bi-eye"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card h-100">
                <div class="card-body py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-muted small">Commandes totales</div>
                            <div class="fw-bold fs-5">${totalCommandes}</div>
                        </div>
                        <span class="badge bg-dark text-white">
                            <i class="bi bi-receipt-cutoff"></i>
                        </span>
                    </div>
                    <div class="text-muted small mt-1 d-md-none">
                        Total repas : <strong>${fn:length(repasList)}</strong>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6">
            <div class="card h-100">
                <div class="card-body py-3">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div>
                            <div class="text-muted small">Visites du site (toutes)</div>
                            <div class="fw-bold fs-5">${totalVisites}</div>
                        </div>
                        <span class="badge bg-info-subtle text-info border border-info-subtle">
                            <i class="bi bi-graph-up-arrow"></i>
                        </span>
                    </div>
                    <div class="small text-muted">
                        <span class="me-3">
                            Anonymes : <strong>${visitesAnonymes}</strong>
                        </span>
                        <span>
                            Connectés : <strong>${visitesConnectees}</strong>
                        </span>
                    </div>
                    <hr class="my-2">
                    <div class="small text-muted">
                        <div>Aujourd&apos;hui : <strong>${visitesAujourdHui}</strong></div>
                        <div>Cette semaine : <strong>${visitesCetteSemaine}</strong></div>
                        <div>Ce mois-ci : <strong>${visitesCeMois}</strong></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="bi bi-plus-circle me-2 text-success"></i>Ajouter un repas
            </h5>
            <form action="/admin/repas/add" method="post" class="row g-3">
                <div class="col-md-3">
                    <label class="form-label small text-muted">Nom</label>
                    <input type="text" name="name" class="form-control" placeholder="Ex: Tajine poulet citron" required>
                </div>
                <div class="col-md-2">
                    <label class="form-label small text-muted">Prix (DH)</label>
                    <input type="number" name="price" step="0.01" class="form-control" placeholder="Ex: 75" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label small text-muted">Description (colonne image)</label>
                    <input type="text" name="description" class="form-control" placeholder="Ex: Tajine fondant aux citrons">
                </div>
                <div class="col-md-3">
                    <label class="form-label small text-muted">URL de l&apos;image (colonne url_image)</label>
                    <input type="text" name="urlImage" class="form-control" placeholder="https://..." required>
                </div>
                <div class="col-md-1 d-grid align-self-end">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check2"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="bi bi-list-ul me-2"></i>Liste des repas (BD)
            </h5>
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Prix (DH)</th>
                        <th>Description</th>
                        <th>Image</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${repasList}" var="repas">
                        <tr>
                            <td>${repas.id}</td>
                            <td>${repas.name}</td>
                            <td>${repas.price}</td>
                            <td>${repas.image}</td>
                            <td>
                                <img src="${repas.urlImage}" alt="${repas.name}" style="width: 100px; height: 70px; object-fit: cover; border-radius:10px;">
                            </td>
                            <td>
                                <form action="/admin/repas/edit" method="get" class="d-inline">
                                    <input type="hidden" name="id" value="${repas.id}">
                                    <button class="btn btn-sm btn-outline-primary me-1" title="Modifier">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                </form>
                                <form action="/admin/repas/delete" method="post" class="d-inline">
                                    <input type="hidden" name="id" value="${repas.id}">
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty repasList}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">Aucun repas pour le moment. Ajoutez votre premier plat ci-dessus.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>