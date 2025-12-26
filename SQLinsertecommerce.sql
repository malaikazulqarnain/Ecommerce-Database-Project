USE ECommerceDBMS;
INSERT INTO Roles (role_name)
VALUES ('Admin'), ('Customer');
INSERT INTO Users (full_name, email, password_hash, phone, role_id)
VALUES
('fatima', 'fatima@gmail.com', 'hashed123', '03001234567', 2),
('malaika', 'malaika@gmail.com', 'hashed456', '03111234567', 2);
INSERT INTO Addresses (user_id, address_line, city, state, postal_code, country, address_type)
VALUES
(1, 'House 12, Street 5', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Shipping'),
(2, 'Flat 8, Block B', 'Karachi', 'Sindh', '75000', 'Pakistan', 'Shipping');
INSERT INTO Categories (category_name)
VALUES ('Electronics'), ('Clothing');
INSERT INTO Products (product_name, description, price, category_id)
VALUES
('Laptop', 'HP Core i5 Laptop', 120000, 1),
('T-Shirt', 'Cotton Round Neck', 2500, 2);
INSERT INTO ProductImages (product_id, image_url)
VALUES
(1, 'laptop.jpg'),
(2, 'tshirt.jpg');
INSERT INTO Inventory (product_id, quantity)
VALUES
(1, 10),
(2, 50);
INSERT INTO Carts (user_id)
VALUES (1);
INSERT INTO CartItems (cart_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 2, 2);
INSERT INTO Orders (user_id, status, total_amount, shipping_address_id)
VALUES (1, 'Paid', 125000, 1);
INSERT INTO OrderItems (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 120000),
(1, 2, 2, 2500);
INSERT INTO Payments (order_id, payment_method, payment_status, transaction_id)
VALUES
(1, 'Credit Card', 'Completed', 'TXN12345');
INSERT INTO Shipping (order_id, courier_name, tracking_number, shipping_status)
VALUES
(1, 'TCS', 'TRACK123', 'Shipped');
INSERT INTO Reviews (user_id, product_id, rating, comment)
VALUES
(1, 1, 5, 'Excellent laptop!');
INSERT INTO Wishlist (user_id, product_id)
VALUES (2, 1);

INSERT INTO Coupons (coupon_code, discount_type, discount_value, min_order_amount, expiry_date)
VALUES ('NEW10', 'Percentage', 10, 5000, '2026-12-31');
INSERT INTO CouponUsage (coupon_id, user_id, order_id)
VALUES (1, 1, 1);
