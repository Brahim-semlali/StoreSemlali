<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion - Store Semlali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/modern.css" rel="stylesheet">
</head>
<body class="auth-page">

<nav class="auth-nav-modern">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <a href="/home"><i class="bi bi-arrow-left me-2"></i>Store Semlali</a>
        <a href="/home">Accueil</a>
    </div>
</nav>

<div class="auth-wrapper-modern">
    <div class="auth-card-modern">
        <div class="auth-logo-modern">
            <img src="<c:url value='/image/logo.jpeg'/>" alt="Store Semlali" onerror="this.style.display='none'">
            <div class="auth-logo-text">
                <div>Store Semlali</div>
                <small>Boutique de vêtements</small>
            </div>
        </div>
        <h3>Connexion</h3>
        <p class="text-muted small mb-4">Accédez à votre compte pour commander et suivre vos achats.</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2">${error}</div>
        </c:if>

        <form method="post" action="/login">
            <div class="mb-3">
                <label class="form-label">Email</label>
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-envelope"></i></span>
                    <input type="email" class="form-control border-start-0" name="email" placeholder="votre@email.com" required>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Mot de passe</label>
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control border-start-0" name="password" placeholder="Mot de passe" required>
                </div>
                <div class="form-text small text-muted">Ne partagez jamais votre mot de passe.</div>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember" name="remember">
                <label class="form-check-label" for="remember">Se souvenir de moi</label>
            </div>
            <button type="submit" class="btn btn-primary w-100">Se connecter</button>
        </form>

        <p class="auth-footer-text mb-0 mt-4">
            Pas encore de compte ? <a href="/signup">Créer un compte</a>
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
