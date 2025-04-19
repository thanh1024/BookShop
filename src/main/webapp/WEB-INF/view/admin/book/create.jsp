<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
    <meta name="author" content="Hỏi Dân IT" />
    <title>Create product</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#productImgFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#productImgPreview").attr("src", imgURL);
                $("#productImgPreview").css({ "display": "block" });
            });
        });
    </script>

</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Manage Book</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Book</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Create a Book</h3>
                            <hr />
                            <%--@elvariable id="newBook" type="com.example.bookshop.domain.Book"--%>
                            <form:form method="post" action="/admin/book/create"
                                       modelAttribute="newBook" class="row" enctype="multipart/form-data">
                                <!-- name -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="nameError">
                                        <form:errors path="name" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label" cssClass="invalid-feedBack">Name:</label>
                                    <form:input type="text" class="form-control ${not empty nameError ? 'is-invalid':''}" path="name" />
                                        ${nameError}
                                </div>
                                <!-- price -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="priceError">
                                        <form:errors path="price" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label" cssClass="invalid-feedBack">Price:</label>
                                    <form:input type="number" class="form-control ${not empty priceError ? 'is-invalid':''}" path="price" />
                                        ${priceError}
                                </div>
                                <!-- detailDesc -->
                                <div class="mb-3 col-12">
                                    <c:set var="detailDescError">
                                        <form:errors path="detailDesc" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label" cssClass="invalid-feedBack">Detail description:</label>
                                    <form:input type="text" class="form-control ${not empty detailDescError ? 'is-invalid':''}" path="detailDesc" />
                                        ${detailDescError}
                                </div>
                                <!-- shortDesc -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="shortDescError">
                                        <form:errors path="shortDesc" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label" cssClass="invalid-feedBack">Short description:</label>
                                    <form:input type="text" class="form-control ${not empty shortDescError ? 'is-invalid':''}" path="shortDesc" />
                                        ${shortDescError}
                                </div>
                                <!-- quantity -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="quantityError">
                                        <form:errors path="quantity" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label" cssClass="invalid-feedBack">Quantity:</label>
                                    <form:input type="number" class="form-control ${not empty quantityError ? 'is-invalid':''}" path="quantity" />
                                        ${quantityError}
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label">Categories:</label>
                                    <c:set var="categoriesError">
                                        <form:errors path="categories" />
                                    </c:set>
                                    <div>
                                        <form:checkboxes path="categories" items="${categories}" itemValue="id" itemLabel="name"
                                                         cssClass="form-check-input me-1" />
                                    </div>
                                    <form:errors path="categories" cssClass="invalid-feedback d-block" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="pulisherError">
                                        <form:errors path="publisher" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label" cssClass="invalid-feedBack">Publisher:</label>
                                    <form:input type="text" class="form-control ${not empty pulisherError ? 'is-invalid':''}" path="publisher" />
                                        ${pulisherError}
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="authorError">
                                        <form:errors path="publisher" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label" cssClass="invalid-feedBack">Author:</label>
                                    <form:input type="text" class="form-control ${not empty authorError ? 'is-invalid':''}" path="author" />
                                        ${authorError}
                                </div>


                                <!-- Image -->
                                <div class="mb-3 col-12 col-md-6">
                                    <%--@declare id="avaterfile"--%><label for="avaterFile" class="form-label">Image:</label>
                                    <input class="form-control" type="file" id="productImgFile"
                                           accept=".png, .jpg, .jpeg" name="File" />
                                </div>
                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="product image preview"
                                         id="productImgPreview" />
                                </div>
                                <button type="submit" class="btn btn-primary">Create</button>
                            </form:form>
                        </div>

                    </div>

                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
        crossorigin="anonymous"></script>
<script src="js/chart-area-demo.js"></script>
<script src="js/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
<script src="js/datatables-simple-demo.js"></script>
</body>

</html>