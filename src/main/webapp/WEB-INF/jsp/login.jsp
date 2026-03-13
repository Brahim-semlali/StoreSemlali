<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Connexion - Fdarna Cuisine</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body{
            min-height:100vh;
            margin:0;
            display:flex;
            align-items:center;
            justify-content:center;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background:
                linear-gradient(135deg, rgba(0,0,0,0.55), rgba(0,0,0,0.7)),
                url("https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=1400&q=80") center/cover no-repeat;
        }

        .auth-wrapper{
            max-width:960px;
            width:100%;
            background:rgba(255,255,255,0.08);
            border-radius:26px;
            padding:1px;
            backdrop-filter: blur(18px);
            box-shadow:0 30px 80px rgba(0,0,0,0.65);
        }

        .auth-inner{
            display:flex;
            background:rgba(20,20,20,0.85);
            border-radius:24px;
            overflow:hidden;
        }

        .auth-hero{
            flex:1.1;
            position:relative;
            color:#fff;
            padding:40px 36px;
            display:flex;
            flex-direction:column;
            justify-content:space-between;
        }

        .auth-hero::before{
            content:"";
            position:absolute;
            inset:0;
            background:
                radial-gradient(circle at top left, rgba(230,126,34,0.6), transparent 55%),
                radial-gradient(circle at bottom right, rgba(39,174,96,0.4), transparent 55%);
            opacity:0.9;
            mix-blend-mode:screen;
        }

        .auth-hero-content{
            position:relative;
            z-index:1;
        }

        .auth-hero h2{
            font-size:2.1rem;
            margin-bottom:0.75rem;
        }

        .auth-hero p{
            opacity:0.95;
        }

        .auth-logo{
            display:flex;
            align-items:center;
            gap:0.75rem;
            margin-bottom:1.75rem;
        }

        .auth-logo img{
            width:64px;
            height:64px;
            object-fit:cover;
            border-radius:18px;
            background:#fff;
            box-shadow:0 8px 20px rgba(0,0,0,0.3);
        }

        .auth-logo-text{
            line-height:1.2;
        }

        .auth-logo-text small{
            opacity:0.9;
            font-size:0.8rem;
        }

        .auth-badge{
            display:inline-flex;
            align-items:center;
            gap:0.45rem;
            padding:0.25rem 0.75rem;
            border-radius:999px;
            background:rgba(0,0,0,0.55);
            font-size:0.8rem;
        }

        .auth-dishes{
            margin-top:1.25rem;
            display:flex;
            gap:0.5rem;
            font-size:0.8rem;
            opacity:0.9;
        }

        .auth-dishes span{
            padding:0.15rem 0.6rem;
            border-radius:999px;
            border:1px solid rgba(255,255,255,0.25);
        }

        .auth-footer-text{
            position:relative;
            z-index:1;
            font-size:0.75rem;
            opacity:0.85;
        }

        .auth-form{
            flex:1;
            padding:40px 40px;
            background:#ffffff;
        }

        .auth-form h3{
            font-weight:600;
        }

        .auth-form .form-control{
            border-radius:12px;
            border-color:#e2e2e2;
        }

        .auth-form .form-control:focus{
            border-color:#e67e22;
            box-shadow:0 0 0 0.2rem rgba(230,126,34,0.25);
        }

        .auth-form button[type="submit"]{
            border-radius:999px;
            background:#e67e22;
            border-color:#e67e22;
        }

        .auth-form button[type="submit"]:hover{
            background:#cf6a14;
            border-color:#cf6a14;
        }

        @media (max-width: 768px){
            body{
                align-items:flex-start;
                padding:20px 10px;
            }
            .auth-inner{
                flex-direction:column;
            }
            .auth-hero{
                display:none;
            }
        }
    </style>

</head>

<body>

<div class="auth-wrapper">
    <div class="auth-inner">
        <div class="auth-hero">
            <div class="auth-hero-content">
                <div class="auth-logo">
                    <img src="<c:url value='/image/logo1.png'/>" alt="Fdarna Cuisine">
                    <div class="auth-logo-text">
                        <div class="fw-bold">Fdarna Cuisine</div>
                        <small>Saveurs maison de Marrakech</small>
                    </div>
                </div>
                <div class="auth-badge mb-3">
                    <i class="bi bi-egg-fried"></i>
                    <span>Cuisine marocaine fait maison</span>
                </div>
                <h2>Retrouvez vos plats préférés</h2>
                <p>Connectez-vous pour accéder à votre panier, suivre vos commandes et découvrir les plats du jour.</p>
                <div class="auth-dishes">
                    <span>Tajine</span>
                    <span>Couscous</span>
                    <span>Pastilla</span>
                </div>
            </div>
            <div class="auth-footer-text mt-3">
                Plats faits maison, livraison à Marrakech uniquement.
            </div>
        </div>

        <div class="auth-form">
        <h3 class="mb-3">Connexion</h3>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                    ${error}
            </div>
        </c:if>

            <form method="post" action="/login" class="mt-3">

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" placeholder="Entrez votre email" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mot de passe</label>
                    <input type="password" class="form-control" name="password" placeholder="Entrez votre mot de passe" required>
                </div>

                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="remember">
                    <label class="form-check-label" for="remember">Se souvenir de moi</label>
                </div>

                <button type="submit" class="btn btn-primary w-100">Se connecter</button>

                <div class="text-center mt-3">
                    <small>Vous n'avez pas encore de compte ? <a href="/signup">Créer un compte</a></small>
                </div>

            </form>
        </div>
    </div>
</div>

</body>
</html>