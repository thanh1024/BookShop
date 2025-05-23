<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
    <meta name="author" content="Hỏi Dân IT" />
    <title>Book</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Manage book</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Book</li>
                </ol>

                <div class="row mt-5">
                    <!-- Cột Category -->
                    <div class="col-md-3">
                        <h5>Management</h5>
                        <div class="d-grid gap-2">
                            <a href="/admin/book/category" class="btn btn-outline-primary">Manage Category</a>
                        </div>
                    </div>

                    <!-- Cột Table sách -->
                    <div class="col-md-9">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>Book List</h3>
                            <a href="/admin/book/create" class="btn btn-primary">Add New Book</a>
                        </div>
                        <hr />
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Sold</th>
                                <th>Publisher</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${totalPages == 0}">
                                <div>Không tìm thấy sách</div>
                            </c:if>
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td>${book.id}</td>
                                    <td>${book.name}</td>
                                    <td><fmt:formatNumber value="${book.price}" type="number"/> VND</td>
                                    <td>${book.quantity}</td>
                                    <td>${book.sold}</td>
                                    <td>${book.publisher}</td>
                                    <td>
                                        <a href="/admin/book/${book.id}" class="btn btn-success btn-sm">View</a>
                                        <a href="/admin/book/update/${book.id}" class="btn btn-secondary btn-sm">Update</a>
                                        <a href="/admin/book/delete/${book.id}" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item">
                                    <a class="${1 eq currentPage ? 'disabled page-link':'page-link'}"
                                       href="/admin/book?page=${currentPage - 1}"
                                       aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                    <a class="${(loop.index + 1) eq currentPage ? 'active page-link':'page-link'}"
                                       href="/admin/book?page=${loop.index + 1}">
                                            ${loop.index + 1}
                                    </a>

                                </c:forEach>
                                <li class="page-item">
                                    <a class="${totalPages eq currentPage ? 'disabled page-link':'page-link'}"
                                       href="/admin/book?page=${currentPage + 1}"
                                       aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>

            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
        crossorigin="anonymous"></script>
<script src="/js/chart-area-demo.js"></script>
<script src="/js/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
<script src="/js/datatables-simple-demo.js"></script>
</body>
</html>
