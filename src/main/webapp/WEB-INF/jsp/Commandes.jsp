<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Commandes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            background:#fff7ec;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .orders-card{
            border:none;
            border-radius:16px;
            box-shadow:0 10px 25px rgba(0,0,0,0.08);
            background:#ffffff;
        }

        .orders-title{
            position:relative;
            display:inline-block;
        }

        .orders-title::after{
            content:"";
            position:absolute;
            left:50%;
            transform:translateX(-50%);
            bottom:-8px;
            width:60%;
            height:3px;
            border-radius:999px;
            background:#e67e22;
        }

        .table thead th{
            border-bottom:0;
        }

        .table tbody tr:hover{
            background:#fff8ef;
        }

        /* -------- Responsive commandes -------- */
        @media (max-width: 767.98px) {
            .orders-card{
                padding:1.25rem;
                border-radius:14px;
            }

            .orders-card h5{
                font-size:1rem;
            }

            .table-responsive{
                font-size:0.85rem;
            }

            .orders-title::after{
                width:40%;
            }

            .d-flex.justify-content-between.align-items-center.mt-4{
                flex-direction:column;
                align-items:flex-start !important;
                gap:0.75rem;
            }
        }
    </style>

</head>

<body>

<div class="container mt-5">
    <h2 class="text-center mb-4 orders-title">Mes Commandes</h2>

    <div class="orders-card p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h5 class="mb-1">Vos plats en préparation</h5>
                <small class="text-muted">Modifiez les quantités avant de passer au paiement.</small>
            </div>
            <a href="/home" class="btn btn-sm btn-outline-secondary">← Retour au catalogue</a>
        </div>

        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Repas</th>
                    <th>Quantité</th>
                    <th>Prix unitaire</th>
                    <th>Total ligne</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="commande" items="${commandes}">
                    <tr>
                        <td>${commande.id}</td>
                        <td>${commande.repas.name}</td>
                        <td style="max-width: 120px;">
                            <form method="post" action="/commandes/update" class="d-flex">
                                <input type="hidden" name="id" value="${commande.id}">
                                <input type="number" name="quantite" min="1" class="form-control form-control-sm me-2"
                                       value="${commande.quantity}">
                                <button class="btn btn-sm btn-outline-primary">OK</button>
                            </form>
                        </td>
                        <td>${commande.repas.price} DH</td>
                        <td>${commande.total} DH</td>
                        <td>
                            <form method="post" action="/commandes/delete">
                                <input type="hidden" name="id" value="${commande.id}">
                                <button class="btn btn-outline-danger btn-sm">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty commandes}">
                    <tr>
                        <td colspan="6" class="text-center text-muted">
                            Aucune commande en préparation. Ajoutez des plats depuis le catalogue.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="d-flex justify-content-between align-items-center mt-4">
            <h4 class="mb-0">Total : ${total} DH</h4>
            <a href="/paiement" class="btn btn-success">Passer au paiement</a>
        </div>
    </div>
</div>

</body>
</html>