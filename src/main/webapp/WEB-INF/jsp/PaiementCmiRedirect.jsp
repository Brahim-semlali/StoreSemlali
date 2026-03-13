<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Redirection vers le paiement</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="mb-3">Redirection vers la page de paiement sécurisée</h5>
                    <p class="text-muted small">
                        Vous allez être redirigé vers la plateforme de paiement sécurisée pour régler un montant de
                        <strong>${amount} DH</strong>.
                    </p>

                    <!-- Formulaire d'exemple vers CMI : à remplacer par l'URL et les champs exacts fournis par CMI -->
                    <form id="cmiForm" method="post" action="https://cmi-gateway-url-sandbox">
                        <input type="hidden" name="amount" value="${amount}">
                        <input type="hidden" name="currency" value="${currency}">
                        <input type="hidden" name="oid" value="${orderId}">
                        <input type="hidden" name="clientid" value="${merchantId}">
                        <input type="hidden" name="okUrl" value="${redirectUrl}">
                        <input type="hidden" name="failUrl" value="${redirectUrl}">
                        <input type="hidden" name="hash" value="${hash}">

                        <button type="submit" class="btn btn-primary mt-3">
                            Continuer vers le paiement sécurisé
                        </button>
                    </form>

                    <script>
                        // Soumission automatique après un court délai
                        setTimeout(function () {
                            document.getElementById('cmiForm').submit();
                        }, 1500);
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

