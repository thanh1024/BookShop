$(document).ready(function() {
    const searchBox = $('#searchBox');
    const searchResults = $('#searchResults');
    let typingTimer;
    const doneTypingInterval = 10; // wait 500ms after user stops typing

    // Hide search results initially
    searchResults.hide();

    // Handle keyup event on search box
    searchBox.on('keyup', function() {
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

        // AJAX call to fetch search results
        $.ajax({
            url: '/api/books/search',
            method: 'GET',
            data: { name: query },
            success: function(data) {
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