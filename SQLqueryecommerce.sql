USE ECommerceDBMS;
SELECT p.product_name, c.category_name, p.price
FROM Products p
JOIN Categories c ON p.category_id = c.category_id;

SELECT u.full_name, p.product_name, ci.quantity
FROM CartItems ci
JOIN Carts c ON ci.cart_id = c.cart_id
JOIN Users u ON c.user_id = u.user_id
JOIN Products p ON ci.product_id = p.product_id
WHERE u.user_id = 1;

SELECT o.order_id, u.full_name, o.total_amount, o.status
FROM Orders o
JOIN Users u ON o.user_id = u.user_id;

SELECT o.order_id, p.payment_method, p.payment_status
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id;

SELECT p.product_name, i.quantity
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id;

SELECT p.product_name, r.rating, r.comment
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id;

SELECT u.full_name, COUNT(o.order_id) AS total_orders
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.full_name;

SELECT SUM(total_amount) AS total_revenue
FROM Orders
WHERE status = 'Paid';

SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;

SELECT p.product_name, i.quantity
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id
WHERE i.quantity < 10;



