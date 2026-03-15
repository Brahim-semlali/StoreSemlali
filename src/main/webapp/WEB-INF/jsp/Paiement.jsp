<!DOCTYPE html>
<html>
<head>
    <title>Paiement</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
    <style>
        .payment-title-modern { position: relative; display: inline-block; }
        .payment-title-modern::after { content: ""; position: absolute; left: 50%; transform: translateX(-50%); bottom: -8px; width: 48px; height: 4px; border-radius: 2px; background: var(--store-primary); }
        .official-payment { border-radius: var(--radius-sm); background: var(--store-primary-light); }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4 payment-title-modern fw-bold">Paiement</h2>
    <div class="admin-card-modern card p-4">

        <form action="/paiement/cmi" method="post">

            <div class="alert alert-warning mb-4">
                Livraison disponible <strong>uniquement à Marrakech</strong>. Pour fixer la date et l&apos;heure de livraison,
                merci de nous contacter sur WhatsApp au
                <a href="https://wa.me/212634801200" target="_blank" class="link-dark">
                    +212 6 34 80 12 00
                </a>.
            </div>

            <div class="mb-3">
                <label>Nom complet</label>
                <input type="text" class="form-control">
            </div>

            <div class="mb-3">
                <label>Adresse de livraison (Marrakech)</label>
                <input type="text" class="form-control" placeholder="Quartier, rue, immeuble &mdash; Marrakech uniquement">
            </div>

            <div class="mb-3">
                <label>Téléphone</label>
                <input type="text" class="form-control" placeholder="+212 6 XX XX XX XX">
            </div>

            <div class="form-check mb-4">
                <input class="form-check-input" type="checkbox" id="onlyMarrakech" required>
                <label class="form-check-label" for="onlyMarrakech">
                    Je confirme que l&apos;adresse de livraison se trouve à <strong>Marrakech</strong>.
                </label>
            </div>

            <div class="mb-3">
                <label>Méthode de paiement</label>
                <select class="form-control">
                    <option>Cash à la livraison</option>
                    <option>Carte bancaire (site sécurisé)</option>
                    <option>PayPal</option>
                </select>
            </div>

            <h4>Total : ${total} DH</h4>

            <div class="alert alert-info mt-3 official-payment">
                <strong>Paiement sécurisé par carte</strong><br>
                Pour régler votre commande par carte bancaire sur un site officiel sécurisé (CMI / banque), cliquez sur le bouton ci‑dessous.&nbsp;
                Le montant total de votre commande sera transmis à la plateforme de paiement.
                <br>
                <button type="submit" class="btn btn-modern w-100 mt-3">
                    Continuer vers le paiement par carte (${total} DH)
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>