<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>${book.name}</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

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

<div class="container py-5 mt-5">

    <!-- Thông tin sách -->
    <div class="row mb-5">
        <div class="col-md-5">
            <div class="card shadow border-0">
                <img src="/images/books/${book.image}" class="card-img-top rounded" alt="${book.name}">
            </div>
        </div>
        <div class="col-md-7">
            <h2 class="fw-bold mb-3">${book.name}</h2>
            <p class="text-muted mb-1"><strong>Tác giả:</strong> ${book.author}</p>
            <p class="text-muted mb-1"><strong>Nhà xuất bản:</strong> ${book.publisher}</p>
            <h4 class="text-danger fw-bold mt-3">${book.price} VNĐ</h4>

            <div class="mt-3">
                <span class="text-muted"><strong>Đã bán:</strong> ${book.sold} cuốn</span><br>
                <span class="text-muted"><strong>Số lượng còn:</strong> ${book.quantity}</span>
            </div>

            <div class="mt-3">
                <strong>Thể loại:</strong>
                <c:forEach items="${book.categories}" var="cat">
                    <span class="badge bg-success me-1">${cat.name}</span>
                </c:forEach>
            </div>

            <p class="mt-4">${book.detailDesc}</p>
            <div class="input-group quantity mb-5" style="width: 100px;">
                <div class="input-group-btn">
                    <button class="btn btn-sm btn-minus rounded-circle bg-light border">
                        <i class="fa fa-minus"></i>
                    </button>
                </div>
                <input type="text"
                       class="form-control form-control-sm text-center border-0" value="1"
                       data-cart-detail-index="0">
                <div class="input-group-btn">
                    <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                        <i class="fa fa-plus"></i>
                    </button>
                </div>
            </div>
            <form action="/add-product-from-view-detail" method="post" modelAttribute="product">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input class="form-control d-none" type="text" value="${book.id}"
                   name="id" />

            <input class="form-control d-none" type="text" name="quantity"
                   id="cartDetails0.quantity" value="1" />
            <button data-product-id="${book.id}"
                    class="btnAddToCartDetail btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i
                    class="fa fa-shopping-bag me-2 text-primary"></i>
                Add to cart
            </button>

            </form>
        </div>
    </div>

    <hr class="my-5"/>

    <!-- Form đánh giá -->
    <div class="row">
        <div class="col-md-8">
            <h4>Viết đánh giá của bạn</h4>
            <form action="/book/${book.id}/review" method="post" class="mt-3">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <!-- Rating -->
                <div class="mb-3">
                    <label class="form-label">Chọn số sao:</label><br>
                    <c:forEach begin="1" end="5" var="star">
                        <input type="radio" class="btn-check" name="rating" id="star${star}" value="${star}" required>
                        <label class="btn btn-outline-warning" for="star${star}">${star} <i class="fas fa-star"></i></label>
                    </c:forEach>
                </div>

                <!-- Comment -->
                <div class="mb-3">
                    <label class="form-label">Bình luận:</label>
                    <textarea class="form-control" name="comment" rows="3" required></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
            </form>
        </div>
    </div>

    <!-- Danh sách đánh giá -->
    <div class="row mt-5">
        <div class="col-md-8">
            <h4>Đánh giá từ người dùng</h4>
            <c:choose>
            <c:when test="${empty reviews}">
                <p class="text-muted">Chưa có đánh giá nào cho sách này.</p>
            </c:when>
            <c:otherwise>
            <c:forEach items="${reviews}" var="r">
            <div class="border rounded p-3 mb-3 bg-light shadow-sm">
                <div class="d-flex justify-content-between">
                    <strong>${r.user.fullName}</strong>
                    <span>
        <c:forEach begin="1" end="5" var="i">
            <i class="fas fa-star
                <c:if test="${i <= r.rating}">text-warning</c:if>">
            </i>
        </c:forEach>
    </span>
                </div>
                <p class="mt-2 mb-0">${r.comment}</p>
                </div>
                </c:forEach>
                </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
<!-- Footer Start -->
<jsp:include page="../layout/footer.jsp" />
<!-- Footer End -->


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
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

</body>

</html>
