<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    <style>
        .page-link.disabled {
            color: var(--bs-pagination-disabled-color);
            pointer-events: none;
            background-color: var(--bs-pagination-disabled-bg);
        }
    </style>
    <link rel="stylesheet" href="/css/search.css">

</head>

<body>

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp" />










<!-- Fruits Shop Start-->
<div class="container-fluid fruite py-5 mt-5">
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Danh Sách Sản Phẩm</li>
                    </ol>
                </nav>
            </div>
            <div class="row g-4">
                <div class="col-12 col-md-4">
                    <div class="row g-4">
                        <div class="col-12" id="categoryFilter">
                            <div class="mb-2"><b>Danh mục sản phẩm</b></div>
                            <c:forEach var="category" items="${categories}">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox"
                                           name="category"
                                           id="category-${category.id}"
                                           value="${category.id}">
                                    <label class="form-check-label" for="category-${category.id}">
                                            ${category.name}
                                    </label>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="col-12">
                            <button
                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4"
                                    id="btnFilter">
                                Lọc Sách
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-8 text-center">
                    <div class="row g-4">
                        <c:if test="${totalPages == 0}">
                            <div>Không tìm thấy sản phẩm</div>
                        </c:if>
                        <c:forEach var="book" items="${books}">
                            <div class="col-md-6 col-lg-4">
                                <div class="rounded position-relative fruite-item">
                                    <div class="fruite-img">
                                        <img src="/images/books/${book.image}"
                                             class="img-fluid w-100 rounded-top  book-img-fixed" alt="">
                                    </div>
                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                         style="top: 10px; left: 10px;">Book</div>
                                    <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                        <a href="/book/${book.id}">
                                            <h4 style="font-size: 15px;">${book.name}</h4>
                                        </a>
                                        <p style="font-size: 13px;">${book.shortDesc}</p>
                                        <div class="d-flex flex-lg-wrap justify-content-center">
                                            <p style="font-size: 15px; text-align: center; width: 100%;"
                                               class="text-dark fw-bold mb-3">
                                                <fmt:formatNumber type="number"
                                                                  value="${book.price}" />
                                                vnd
                                            </p>
                                            <form method="post"
                                                  action="/add-product-to-cart/${book.id}">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                       value="${_csrf.token}" />
                                                <button
                                                        class="mx-auto border border-secondary rounded-pill px-3 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i>
                                                    Add to cart
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${totalPages > 0}">
                            <div class="pagination d-flex justify-content-center mt-5">
                                <li class="page-item">
                                    <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                       href="/books?page=${currentPage - 1}${queryString}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                    <li class="page-item">
                                        <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                           href="/books?page=${loop.index + 1}${queryString}">
                                                ${loop.index + 1}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li class="page-item">
                                    <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                       href="/books?page=${currentPage + 1}${queryString}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Fruits Shop End-->

<jsp:include page="../layout/feature.jsp" />

<jsp:include page="../layout/footer.jsp" />


<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
        class="fa fa-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="/client/js/main.js"></script>
</body>

</html>