-- New database called Book store
CREATE DATABASE bookstoreDB;

-- 1. book: A list of all books available in the store.
USE bookstoreDB;

CREATE TABLE IF NOT EXISTS book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    genre VARCHAR(100),
    published_year YEAR,
    price DECIMAL(8, 2),
    stock_quantity INT,
    isbn VARCHAR(20) UNIQUE
);

-- 2. book_author: A table to manage the many-to-many relationship between books and authors. & 3. author: A list of all authors
CREATE TABLE IF NOT EXISTS author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    bio TEXT,
    nationality VARCHAR(100),
    birth_date DATE
);

CREATE TABLE IF NOT EXISTS book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE
);

-- 4. book_language: A list of the possible languages of books.
CREATE TABLE IF NOT EXISTS book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

-- 5. publisher: A list of publishers for books.
CREATE TABLE IF NOT EXISTS publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
);

-- 6. Customer: A list of the bookstore's customers.
CREATE TABLE IF NOT EXISTS customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20)
);

-- 10. country: A list of countries where the addresses are located. & 9.address: A list of all addresses in the system.
CREATE TABLE IF NOT EXISTS country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 7. customer_address: A list of addresses for customers. Each customer can have multiple addresses.
CREATE TABLE IF NOT EXISTS customer_address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

-- address_status: A list of statuses for an address (e.g., current, old). 
CREATE TABLE IF NOT EXISTS address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_description VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS shipping_method (
shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
method_name VARCHAR(100)
);

 CREATE TABLE IF NOT EXISTS cust_order (
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
shipping_method_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

 CREATE TABLE IF NOT EXISTS order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE IF NOT EXISTS order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_description VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

CREATE USER 'admin1'@'%^' IDENTIFIED BY 'adminpass1';
CREATE USER 'admin2'@'%' IDENTIFIED BY 'adminpass2';
CREATE USER 'admin3'@'%' IDENTIFIED BY 'adminpass3';

GRANT ALL PRIVILEGES ON bookstoredb.* TO 'admin1'@'%';
GRANT ALL PRIVILEGES ON bookstoredb.* TO 'admin2'@'%';
GRANT ALL PRIVILEGES ON bookstoredb.* TO 'admin3'@'%';

FLUSH PRIVILEGES;
