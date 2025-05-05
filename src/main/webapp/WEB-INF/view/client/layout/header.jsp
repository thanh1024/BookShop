<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid fixed-top">
    <div class="container px-0">
        <nav class="navbar navbar-light bg-white navbar-expand-xl">
            <a href="/" class="navbar-brand">
                <h1 class="text-primary display-6">BookShop</h1>
            </a>
            <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                <div class="navbar-nav">
                    <a href="/" class="nav-item nav-link active">Trang chủ</a>
                    <a href="/books" class="nav-item nav-link">Lọc Sách</a>

                </div>
                <div class="d-flex m-3 me-0">
                    <div>
                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>
                    </div>
                    <div class="position-relative me-4 my-auto">
                        <input type="text" id="searchBox" placeholder="Tìm tên sách..." class="form-control"/>
                        <div id="searchResults" class="position-absolute w-100" style="display: none;"></div>
                    </div>

                    <c:if test="${not empty pageContext.request.userPrincipal}">

                        <a href="/cart" class="position-relative me-4 my-auto">
                            <i class="fa fa-shopping-bag fa-2x"></i>
                            <span
                                    class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                    style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                    ${sessionScope.sum}
                            </span>
                        </a>
                        <div class="dropdown my-auto">
                            <a href="#" class="nav-link dropdown-toggle" role="button" id="dropdownMenuLink"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user fa-2x"></i>
                            </a>

                            <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                    <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                         src="/images/avatar/${sessionScope.avatar}" />
                                    <div class="text-center my-3">
                                        <c:out value="${sessionScope.fullName}" />
                                    </div>
                                </li>

                                <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>

                                <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li>
                                    <form method="post" action="/logout">
                                        <input type="hidden" name="${_csrf.parameterName}"
                                               value="${_csrf.token}" />
                                        <button class="dropdown-item">Đăng xuất</button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${empty pageContext.request.userPrincipal}">
                        <a href="/login" class="a-login position-relative me-4 my-auto">
                            Đăng nhập
                        </a>
                    </c:if>
                </div>
            </div>
        </nav>
    </div>
</div>

<!-- Include jQuery first -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Include search CSS -->
<style>
    /* Search box styling */
    #searchBox {
        padding: 8px 15px;
        border: 1px solid #ddd;
        border-radius: 20px;
        width: 250px;
        outline: none;
        transition: border-color 0.3s;
    }

    #searchBox:focus {
        border-color: #fd7e14;
    }

    /* Search results container */
    #searchResults {
        top: 100%;
        left: 0;
        width: 400px;
        max-height: 500px;
        overflow-y: auto;
        background-color: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        z-index: 1000;
    }

    /* No results message */
    .no-results {
        padding: 15px;
        text-align: center;
        color: #666;
    }

    /* Search results container */
    .search-results-container {
        padding: 10px 0;
    }

    /* Individual search result item */
    .search-result-item {
        padding: 10px 15px;
        border-bottom: 1px solid #eee;
        transition: background-color 0.2s;
    }

    .search-result-item:last-child {
        border-bottom: none;
    }

    .search-result-item:hover {
        background-color: #f9f9f9;
    }

    /* Book result link */
    .book-result {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: inherit;
    }

    /* Book image container */
    .book-image {
        width: 60px;
        height: 80px;
        margin-right: 15px;
        overflow: hidden;
    }

    .book-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* Book information */
    .book-info {
        flex: 1;
    }

    .book-title {
        font-weight: 500;
        color: #333;
        margin-bottom: 5px;
    }

    .book-chapter {
        font-size: 0.85rem;
        color: #666;
    }
</style>

<!-- Include search JavaScript -->
<script>
    // Make sure this script is included AFTER jQuery in your JSP
    // Check if jQuery is loaded
    if (typeof jQuery === 'undefined') {
        console.error('jQuery is not loaded! Search functionality requires jQuery.');
    } else {
        console.log('jQuery is loaded. Search functionality initializing...');
    }

    $(document).ready(function() {
        const searchBox = $('#searchBox');
        const searchResults = $('#searchResults');
        let typingTimer;
        const doneTypingInterval = 500; // wait 500ms after user stops typing

        console.log('Search elements found:', {
            searchBox: searchBox.length > 0,
            searchResults: searchResults.length > 0
        });

        // Hide search results initially
        searchResults.hide();

        // Handle keyup event on search box
        searchBox.on('keyup', function() {
            console.log('Search input detected:', searchBox.val());
            clearTimeout(typingTimer);
            if (searchBox.val()) {
                typingTimer = setTimeout(performSearch, doneTypingInterval);
            } else {
                searchResults.hide();
            }
        });

        // Handle click outside to close results
        $(document).on('click', function(event) {
            if (!$(event.target).closest('#searchBox, #searchResults').length) {
                searchResults.hide();
            }
        });

        // Handle search functionality
        function performSearch() {
            const query = searchBox.val().trim();
            if (query.length < 2) {
                searchResults.hide();
                return;
            }

            console.log('Performing search for:', query);

            // Get CSRF token for secure requests
            const token = $("input[name='${_csrf.parameterName}']").val();

            // AJAX call to fetch search results
            $.ajax({
                url: '/api/books/search',
                method: 'GET',
                data: { name: query },
                headers: {
                    '${_csrf.headerName}': token
                },
                success: function(data) {
                    console.log('Search results received:', data);
                    displayResults(data);
                },
                error: function(xhr) {
                    console.error('Search failed:', xhr);
                }
            });
        }

        // Display search results
        function displayResults(books) {
            if (books.length === 0) {
                searchResults.html('<div class="no-results">Không tìm thấy sách</div>');
            } else {
                let resultsHtml = '<div class="search-results-container">';

                books.forEach(book => {
                    resultsHtml += `
                    <div class="search-result-item">
                        <a href="/books/${book.id}" class="book-result">
                            <div class="book-image">
                                <img src="/images/books/${book.image || 'default.jpg'}" alt="${book.name}">
                            </div>
                            <div class="book-info">
                                <div class="book-title">${book.name}</div>
                            </div>
                        </a>
                    </div>
                `;
                });

                resultsHtml += '</div>';
                searchResults.html(resultsHtml);
            }

            searchResults.show();
        }
    });
</script>