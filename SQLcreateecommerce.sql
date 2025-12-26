CREATE DATABASE ECommerceDBMS;
GO
USE ECommerceDBMS;
GO
CREATE TABLE Roles (
    role_id INT IDENTITY PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Users (
    user_id INT IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
CREATE TABLE Addresses (
    address_id INT IDENTITY PRIMARY KEY,
    user_id INT,
    address_line VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50),
    address_type VARCHAR(20) CHECK (address_type IN ('Shipping','Billing')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Categories (
    category_id INT IDENTITY PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT NULL,
    FOREIGN KEY (parent_category_id) REFERENCES Categories(category_id)
);
CREATE TABLE Products (
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
CREATE TABLE ProductImages (
    image_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Inventory (
    inventory_id INT IDENTITY PRIMARY KEY,
    product_id INT UNIQUE,
    quantity INT NOT NULL CHECK (quantity >= 0),
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Carts (
    cart_id INT IDENTITY PRIMARY KEY,
    user_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE CartItems (
    cart_item_id INT IDENTITY PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    UNIQUE (cart_id, product_id)
);
CREATE TABLE Orders (
    order_id INT IDENTITY PRIMARY KEY,
    user_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(30) CHECK (status IN ('Pending','Paid','Shipped','Delivered','Cancelled')),
    total_amount DECIMAL(10,2),
    shipping_address_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (shipping_address_id) REFERENCES Addresses(address_id)
);
CREATE TABLE OrderItems (
    order_item_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Payments (
    payment_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(30) CHECK (payment_status IN ('Pending','Completed','Failed')),
    transaction_id VARCHAR(100),
    payment_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Shipping (
    shipping_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    courier_name VARCHAR(50),
    tracking_number VARCHAR(100),
    shipping_status VARCHAR(30),
    shipped_date DATETIME,
    delivered_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Reviews (
    review_id INT IDENTITY PRIMARY KEY,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Wishlist (
    wishlist_id INT IDENTITY PRIMARY KEY,
    user_id INT,
    product_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    UNIQUE (user_id, product_id)
);
CREATE TABLE Returns (
    return_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    user_id INT,
    reason VARCHAR(255),
    return_status VARCHAR(30) CHECK (return_status IN ('Requested','Approved','Rejected','Completed')),
    request_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Refunds (
    refund_id INT IDENTITY PRIMARY KEY,
    return_id INT,
    refund_amount DECIMAL(10,2),
    refund_method VARCHAR(50),
    refund_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (return_id) REFERENCES Returns(return_id)
);
CREATE TABLE Notifications (
    notification_id INT IDENTITY PRIMARY KEY,
    user_id INT,
    message VARCHAR(255),
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Coupons (
    coupon_id INT IDENTITY PRIMARY KEY,
    coupon_code VARCHAR(50) UNIQUE NOT NULL,
    discount_type VARCHAR(20) CHECK (discount_type IN ('Percentage','Flat')),
    discount_value DECIMAL(10,2),
    min_order_amount DECIMAL(10,2),
    expiry_date DATE,
    is_active BIT DEFAULT 1
);

CREATE TABLE CouponUsage (
    usage_id INT IDENTITY PRIMARY KEY,
    coupon_id INT,
    user_id INT,
    order_id INT,
    used_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (coupon_id) REFERENCES Coupons(coupon_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
