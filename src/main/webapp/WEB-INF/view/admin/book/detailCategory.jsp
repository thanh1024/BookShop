<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Category Detail</title>
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
                <h1 class="mt-4">Manage Category</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Category</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <h3>Category Detail - ID: ${category.id}</h3>
                            <hr />
                            <div class="card" style="width: 50%;">
                                <div class="card-header">Category Information</div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item"><strong>Name:</strong> ${category.name}</li>
                                    <li class="list-group-item"><strong>Description:</strong> ${category.description}</li>
                                    <li class="list-group-item"><strong>Number of books:</strong> ${category.books.size()}</li>
                                </ul>
                            </div>
                            <br>
                            <a href="/admin/category" class="btn btn-success">Back</a>
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
