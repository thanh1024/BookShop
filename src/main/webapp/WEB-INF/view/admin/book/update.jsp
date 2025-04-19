<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Update Book</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            $("#avatarFile").change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL).show();
            });
        });
    </script>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Update Book</h1>
                <%--@elvariable id="bookUpdate" type="com.example.bookshop.domain.Book"--%>
                <form:form method="post" action="/admin/book/update" modelAttribute="bookUpdate"
                           class="row" enctype="multipart/form-data">

                    <!-- ID (hidden or disabled) -->
                    <form:hidden path="id" />

                    <!-- Name -->
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Name:</label>
                        <form:input path="name" class="form-control" />
                        <form:errors path="name" cssClass="invalid-feedback d-block" />
                    </div>

                    <!-- Author -->
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Author:</label>
                        <form:input path="author" class="form-control" />
                        <form:errors path="author" cssClass="invalid-feedback d-block" />
                    </div>

                    <!-- Price -->
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Price:</label>
                        <form:input path="price" class="form-control" type="number" step="0.01" />
                        <form:errors path="price" cssClass="invalid-feedback d-block" />
                    </div>

                    <!-- Quantity -->
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Quantity:</label>
                        <form:input path="quantity" class="form-control" type="number" />
                        <form:errors path="quantity" cssClass="invalid-feedback d-block" />
                    </div>

                    <!-- Publisher -->
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Publisher:</label>
                        <form:input path="publisher" class="form-control" />
                        <form:errors path="publisher" cssClass="invalid-feedback d-block" />
                    </div>

                    <!-- Short Description -->
                    <div class="mb-3 col-12">
                        <label class="form-label">Short Description:</label>
                        <form:textarea path="shortDesc" class="form-control" rows="2" />
                        <form:errors path="shortDesc" cssClass="invalid-feedback d-block" />
                    </div>

                    <!-- Detail Description -->
                    <div class="mb-3 col-12">
                        <label class="form-label">Detail Description:</label>
                        <form:textarea path="detailDesc" class="form-control" rows="4" />
                        <form:errors path="detailDesc" cssClass="invalid-feedback d-block" />
                    </div>

                    <!-- Avatar -->
                    <div class="mb-3 col-md-6">
                        <label for="avatarFile" class="form-label">Image:</label>
                        <input class="form-control" type="file" id="avatarFile"
                               accept=".png, .jpg, .jpeg" name="File" />
                        <c:if test="${not empty bookUpdate.image}">
                            <img src="${bookUpdate.image}" id="avatarPreview"
                                 style="max-height: 250px;" class="mt-2" />
                        </c:if>
                    </div>

                    <!-- Categories -->
                    <div class="mb-3 col-12">
                        <label class="form-label">Categories:</label>
                        <form:checkboxes path="categories" items="${categories}" itemValue="id" itemLabel="name"
                                         cssClass="form-check-input me-1" />
                        <form:errors path="categories" cssClass="invalid-feedback d-block" />
                    </div>

                    <div class="col-12 mt-3">
                        <button type="submit" class="btn btn-warning">Update</button>
                    </div>
                </form:form>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
</body>
</html>
