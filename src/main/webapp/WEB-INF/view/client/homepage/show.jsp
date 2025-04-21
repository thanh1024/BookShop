<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Laptopshop</title>

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


</head>
<body>

<jsp:include page="../layout/header.jsp" />

<jsp:include page="../layout/banner.jsp" />

<div class="container mt-5">
    <h2 class="text-center mb-4">Sách nổi bật</h2>
    <div class="row">
        <c:forEach var="book" items="${books}">
            <div class="col-md-3 mb-4">
                <div class="card h-100">
                    <a href="/book/${book.id}">
                        <img src="/images/books/${book.image}" class="card-img-top" alt="${book.name}">
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
                        <button
                                class="btn btn-outline-primary w-100 mt-2 btnAddToCart"
                                data-book-id="${book.id}">
                            <i class="fa fa-shopping-cart me-1"></i> Thêm vào giỏ hàng
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />

<!-- JS nếu muốn xử lý thêm vào giỏ hàng -->
<script>
    $(document).ready(function () {
        $(".btnAddToCart").click(function () {
            const bookId = $(this).data("book-id");
            // Gọi AJAX hoặc submit form để thêm sách vào giỏ hàng
            console.log("Thêm vào giỏ:", bookId);
        });
    });
</script>

</body>
</html>
