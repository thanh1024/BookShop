<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Detail</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Manage Book</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Book</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <h3>Book Detail - ID: ${book.id}</h3>
                            <hr />
                            <div class="card" style="width: 60%;">
                                <div class="card-header">Book Information</div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item"><strong>Name:</strong> ${book.name}</li>
                                    <li class="list-group-item"><strong>Author:</strong> ${book.author}</li>
                                    <li class="list-group-item"><strong>Price:</strong> $${book.price}</li>
                                    <li class="list-group-item"><strong>Publisher:</strong> ${book.publisher}</li>
                                    <li class="list-group-item"><strong>Quantity:</strong> ${book.quantity}</li>
                                    <li class="list-group-item"><strong>Sold:</strong> ${book.sold}</li>
                                    <li class="list-group-item"><strong>Short Description:</strong> ${book.shortDesc}</li>
                                    <li class="list-group-item"><strong>Detail Description:</strong> ${book.detailDesc}</li>
                                    <li class="list-group-item"><strong>Categories:</strong>
                                        <c:forEach var="cat" items="${book.categories}">
                                            <span class="badge bg-primary">${cat.name}</span>
                                        </c:forEach>
                                    </li>
                                    <li class="list-group-item">
                                        <strong>Image:</strong><br>
                                        <img src="/images/books/${book.image}" width="120" alt="${book.name}" />
                                    </li>
                                </ul>
                            </div>
                            <br>
                            <a href="/admin/book" class="btn btn-success">Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>
</body>
</html>
