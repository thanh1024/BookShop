<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Update Category</title>
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Update Category</h1>
                <%--@elvariable id="categoryUpdate" type="com.example.bookshop.domain.Category"--%>
                <form:form method="post" action="/admin/book/updateCategory" modelAttribute="categoryUpdate"
                           class="row">
                    <form:hidden path="id" />
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Name:</label>
                        <form:input path="name" class="form-control" />
                        <form:errors path="name" cssClass="invalid-feedback d-block" />
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
