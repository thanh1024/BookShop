<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - BookShop</title>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
          rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}" />
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
          rel="stylesheet">

    <link rel="stylesheet" href="/css/search.css">

</head>

<body>

<jsp:include page="../layout/header.jsp" />

<jsp:include page="../layout/banner.jsp" />

<div class="container mt-5">
    <div class="row g-4">
        <div class="col-lg-4 text-start">
            <h1>SÁCH NỔI BẬT</h1>
        </div>
        <div class="col-lg-8 text-end">
            <ul class="nav nav-pills d-inline-flex text-center mb-5">
                <li class="nav-item">
                    <a class="d-flex m-2 py-2 bg-light rounded-pill active"
                       href="/books">
                        <span class="text-dark" style="width: 130px;">TẤT CẢ TRUYỆN</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="row">
        <c:forEach var="book" items="${books}">
            <div class="col-md-3 mb-4">
                <div class="card h-100">
                    <a href="/book/${book.id}">
                        <img src="/images/books/${book.image}" class="card-img-top book-img-fixed" alt="${book.name}">
                    </a>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">
                            <a href="/book/${book.id}" class="text-decoration-none text-dark">
                                    ${book.name}
                            </a>
                        </h5>
                        <p class="card-text" style="font-size: 14px;">${book.shortDesc}</p>
                        <p class="fw-bold mt-auto">
                            <fmt:formatNumber value="${book.price}" type="number" /> VND
                        </p>
                        <form action="/add-product-to-cart/${book.id}" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button data-product-id="${book.id}"
                                    class="btnAddToCartHomepage mx-auto border border-secondary rounded-pill px-3 text-primary"><i
                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                Add to cart
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../layout/feature.jsp" />

<jsp:include page="../layout/footer.jsp" />


<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
        class="fa fa-arrow-up"></i></a>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="/client/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
</body>

</html>
