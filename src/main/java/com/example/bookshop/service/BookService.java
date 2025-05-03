package com.example.bookshop.service;

import com.example.bookshop.domain.*;
import com.example.bookshop.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookService {
    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Book getBookById(long id) {
        Optional<Book> book = bookRepository.findById(id);
        return book.orElse(null);
    }

    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }
    public void deleteBook(long id) {
        bookRepository.deleteById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {

        User user = this.userService.getUSerByEmail(email);
        // Check has user had cart? Not yet -> create new one
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);

                cart = this.cartRepository.save(newCart);
            }

            // find product
            Optional<Book> productOptional = this.bookRepository.findById(productId);
            if (productOptional.isPresent()) {
                Book realProduct = productOptional.get();
                // Check has product existed in cart?
                CartDetail oldDetail = this.cartDetailRepository.findByCartAndBook(cart, realProduct);

                if (oldDetail == null) {
                    // Save cart detail
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setBook(realProduct);
                    cartDetail.setPrice(realProduct.getPrice());
                    cartDetail.setQuantity(quantity);
                    this.cartDetailRepository.save(cartDetail);

                    int sumCart = cart.getSum() + 1;
                    cart.setSum(sumCart);

                    this.cartRepository.save(cart);
                    session.setAttribute("sum", sumCart);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(oldDetail);
                }

            }

        }

    }
    public Cart getCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void deleteACartDetail(long id, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(id);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart cart = cartDetail.getCart();
            // delete cartDetail
            this.cartDetailRepository.deleteById(id);

            int cartSum = cart.getSum();
            if (cartSum > 1) {
                cart.setSum(cartSum - 1);
                session.setAttribute("sum", cart.getSum());
                this.cartRepository.save(cart);
            } else {
                this.cartRepository.deleteById(cart.getId());
                session.setAttribute("sum", 0);

            }

        }
    }

    // Hàm xử lý cập nhật lại trường Quantity của product trong cartDetail
    // Vì số lượng sản phẩm trong cartDetail có thể đã thay đổi từ view của người
    // dùng
    // Cụ thể là thay đổi Quantity khi nhấn nút Tăng hoặc Giảm từ file
    // client/cart/show.jsp
    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentDetail = cdOptional.get();
                currentDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentDetail);
            }
        }
    }

    public void handlePlaceOrder(User user, HttpSession session,
                                 String receiverName,
                                 String receiverAddress,
                                 String receiverPhone) {

        // Create Order detail
        // Step 1
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null) {

                // Create Order
                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setStatus("PENDING");

                double sum = 0;
                for (CartDetail cd : cartDetails) {
                    sum += cd.getPrice();
                }
                order.setTotalPrice(sum);
                order = this.orderRepository.save(order);

                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setBook(cd.getBook());
                    orderDetail.setQuantity(cd.getQuantity());
                    orderDetail.setPrice(cd.getPrice());
                    this.orderDetailRepository.save(orderDetail);
                }
            }
            // Step 2 delete cartDetail and cart
            for (CartDetail cd : cartDetails) {
                this.cartDetailRepository.deleteById(cd.getId());
            }
//            this.cartRepository.deleteById(cart.getId());

            // Step 3 Update session
            // Thanh toan het cart nen set cart.sum = 0
            session.setAttribute("sum", 0);
        }
    }

}
