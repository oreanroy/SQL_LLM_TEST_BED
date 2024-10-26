-- Certainly! I've updated the SQL code to reflect your requests:

-- - **Plural table names** following Rails conventions.
-- - **Simplified field names**, using `id` instead of `invoice_id`, `order_id`, etc.
-- - Added **customer_id** to the `invoices` table.
-- - Modified `invoice_lines` to include **amount**, **unit_price**, and **total_price**.
-- - Included **more sample data** (twice as many records).
-- - Expanded the `customers` table with additional fields for targeted advertising.
-- - Created a **`product_prices`** table to manage price changes over time.
-- - Added a **`discounts`** table for temporary discounts with start and end dates.
-- - Added a **picture URL** and **created_at** timestamp to the `products` table.
-- - Included a **discount_percentage** in the `invoices` table for flexible pricing.
-- - Made other minor enhancements for a fully functional online shop database.

-- ---




-- Customers Table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200),
    date_of_birth DATE,
    loyalty_points INTEGER DEFAULT 0,
    preferred_contact_method VARCHAR(50),
    marketing_opt_in BOOLEAN DEFAULT TRUE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories Table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Products Table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(id),
    name VARCHAR(100),
    description TEXT,
    price NUMERIC(10, 2),
    picture_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Product Prices Table
CREATE TABLE product_prices (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    price NUMERIC(10, 2),
    start_date DATE,
    end_date DATE
);

-- Discounts Table
CREATE TABLE discounts (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(id),
    product_id INTEGER REFERENCES products(id),
    discount_percentage NUMERIC(5, 2),
    start_date DATE,
    end_date DATE
);

-- Orders Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    discount_percentage NUMERIC(5, 2) DEFAULT 0
);

-- Order Lines Table
CREATE TABLE order_lines (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_id INTEGER REFERENCES products(id),
    amount INTEGER,
    unit_price NUMERIC(10, 2),
    total_price NUMERIC(10, 2)
);

-- Invoices Table
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    customer_id INTEGER REFERENCES customers(id),
    invoice_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10, 2),
    discount_percentage NUMERIC(5, 2) DEFAULT 0
);

-- Invoice Lines Table
CREATE TABLE invoice_lines (
    id SERIAL PRIMARY KEY,
    invoice_id INTEGER REFERENCES invoices(id),
    product_id INTEGER REFERENCES products(id),
    amount INTEGER,
    unit_price NUMERIC(10, 2),
    total_price NUMERIC(10, 2)
);


---






INSERT INTO customers (name, email, phone, address, date_of_birth, loyalty_points, preferred_contact_method, marketing_opt_in) VALUES
('John Doe', 'johndoe@example.com', '555-1234', '123 Main St, Cityville', '1985-05-15', 100, 'Email', TRUE),
('Jane Smith', 'janesmith@example.com', '555-5678', '456 Oak Ave, Townsville', '1990-07-22', 150, 'SMS', TRUE),
('Alice Johnson', 'alicej@example.com', '555-8765', '789 Pine Rd, Villageville', '1978-11-30', 200, 'Email', FALSE),
('Bob Brown', 'bobbrown@example.com', '555-4321', '321 Maple St, Hamletville', '1982-03-10', 50, 'Phone', TRUE),
('Maria Rossi', 'mariarossi@example.com', '555-9876', '654 Elm St, Boroughville', '1995-12-05', 120, 'Email', TRUE),
('Carlos Garcia', 'carlosg@example.com', '555-6543', '987 Cedar Ln, Metropolis', '1988-08-18', 80, 'SMS', FALSE),
('Linda Nguyen', 'lindang@example.com', '555-3456', '159 Spruce Dr, Cityville', '1992-09-25', 60, 'Email', TRUE),
('Michael Lee', 'michaell@example.com', '555-7890', '753 Birch Blvd, Townsville', '1975-02-14', 180, 'Phone', TRUE),
('Emma Wilson', 'emmaw@example.com', '555-2109', '852 Fir St, Villageville', '1980-06-28', 220, 'Email', TRUE),
('Oliver Davis', 'oliverd@example.com', '555-0192', '951 Walnut Ave, Hamletville', '1987-04-12', 90, 'SMS', FALSE);





INSERT INTO categories (name) VALUES
('Antipasti'),       -- Appetizers
('Primi Piatti'),    -- First Courses
('Secondi Piatti'),  -- Main Courses
('Dolci'),           -- Desserts
('Bevande');         -- Beverages





INSERT INTO products (category_id, name, description, price, picture_url) VALUES
(1, 'Bruschetta', 'Grilled bread topped with fresh tomatoes, garlic, and basil.', 6.50, 'images/bruschetta.jpg'),
(1, 'Caprese Salad', 'Fresh mozzarella, tomatoes, and basil drizzled with olive oil.', 7.00, 'images/caprese_salad.jpg'),
(1, 'Garlic Bread', 'Toasted bread with garlic and butter.', 5.00, 'images/garlic_bread.jpg'),
(2, 'Spaghetti Carbonara', 'Spaghetti with pancetta, eggs, and pecorino cheese.', 12.00, 'images/spaghetti_carbonara.jpg'),
(2, 'Lasagna Bolognese', 'Layered pasta with meat sauce and béchamel.', 13.50, 'images/lasagna_bolognese.jpg'),
(2, 'Risotto ai Funghi', 'Creamy risotto with mushrooms.', 13.00, 'images/risotto_ai_funghi.jpg'),
(3, 'Chicken Parmigiana', 'Breaded chicken topped with tomato sauce and mozzarella.', 15.00, 'images/chicken_parmigiana.jpg'),
(3, 'Grilled Salmon', 'Salmon fillet with lemon butter sauce.', 17.50, 'images/grilled_salmon.jpg'),
(3, 'Veal Scaloppine', 'Veal slices with lemon sauce.', 16.00, 'images/veal_scaloppine.jpg'),
(4, 'Tiramisu', 'Coffee-flavored Italian dessert.', 6.00, 'images/tiramisu.jpg'),
(4, 'Gelato', 'Italian-style ice cream.', 5.00, 'images/gelato.jpg'),
(4, 'Cannoli', 'Tube-shaped shells filled with sweet ricotta.', 6.50, 'images/cannoli.jpg'),
(5, 'Espresso', 'Strong Italian coffee.', 2.50, 'images/espresso.jpg'),
(5, 'Chianti Wine', 'Red wine from Tuscany.', 8.00, 'images/chianti_wine.jpg'),
(5, 'Mineral Water', 'Sparkling or still water.', 2.00, 'images/mineral_water.jpg'),
(5, 'Limoncello', 'Italian lemon liqueur.', 7.00, 'images/limoncello.jpg'),
(5, 'San Pellegrino', 'Sparkling fruit beverages.', 3.00, 'images/san_pellegrino.jpg');





INSERT INTO product_prices (product_id, price, start_date, end_date) VALUES
(1, 6.50, '2023-01-01', NULL),
(2, 7.00, '2023-01-01', NULL),
-- Additional entries for each product to reflect price changes over time
(1, 6.00, '2023-05-01', '2023-12-31'),
(2, 6.50, '2023-05-01', '2023-12-31');





-- Discount on all desserts in July
INSERT INTO discounts (category_id, discount_percentage, start_date, end_date) VALUES
(4, 10.00, '2023-07-01', '2023-07-31');

-- Discount on specific product
INSERT INTO discounts (product_id, discount_percentage, start_date, end_date) VALUES
(5, 15.00, '2023-08-15', '2023-08-31');  -- Lasagna Bolognese





INSERT INTO orders (customer_id, order_date, status, discount_percentage) VALUES
(1, '2023-01-01 18:30:00', 'Completed', 0),
(2, '2023-01-02 19:00:00', 'Completed', 5.00),
(3, '2023-01-03 20:15:00', 'Pending', 0),
(1, '2023-01-04 18:45:00', 'Completed', 10.00),
(4, '2023-01-05 19:30:00', 'Cancelled', 0),
(5, '2023-01-06 18:20:00', 'Completed', 0),
(6, '2023-01-07 20:00:00', 'Completed', 0),
(7, '2023-01-08 19:15:00', 'Completed', 0),
(8, '2023-01-09 18:50:00', 'Pending', 0),
(9, '2023-01-10 19:40:00', 'Completed', 5.00);





-- Order 1 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(1, 1, 1, 6.50, 6.50),   -- Bruschetta
(1, 4, 2, 12.00, 24.00), -- Spaghetti Carbonara
(1, 13, 2, 2.50, 5.00);  -- Espresso

-- Order 2 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(2, 2, 1, 7.00, 7.00),    -- Caprese Salad
(2, 5, 1, 13.50, 13.50),  -- Lasagna Bolognese
(2, 14, 2, 8.00, 16.00);  -- Chianti Wine

-- Order 3 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(3, 7, 1, 15.00, 15.00), -- Chicken Parmigiana
(3, 15, 1, 2.00, 2.00);  -- Mineral Water

-- Additional Order Lines for more orders
-- Order 4 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(4, 3, 1, 5.00, 5.00),   -- Garlic Bread
(4, 6, 1, 13.00, 13.00), -- Risotto ai Funghi
(4, 10, 1, 6.00, 6.00);  -- Tiramisu

-- Order 5 Lines (Cancelled Order)
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(5, 2, 1, 7.00, 7.00),   -- Caprese Salad
(5, 9, 1, 16.00, 16.00); -- Veal Scaloppine

-- Order 6 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(6, 8, 1, 17.50, 17.50), -- Grilled Salmon
(6, 14, 2, 8.00, 16.00); -- Chianti Wine

-- Order 7 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(7, 11, 2, 5.00, 10.00), -- Gelato
(7, 13, 1, 2.50, 2.50);  -- Espresso

-- Order 8 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(8, 12, 1, 6.50, 6.50),  -- Cannoli
(8, 16, 1, 7.00, 7.00);  -- Limoncello

-- Order 9 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(9, 4, 1, 12.00, 12.00), -- Spaghetti Carbonara
(9, 5, 1, 13.50, 13.50); -- Lasagna Bolognese
(9, 14, 1, 8.00, 8.00);  -- Chianti Wine

-- Order 10 Lines
INSERT INTO order_lines (order_id, product_id, amount, unit_price, total_price) VALUES
(10, 6, 1, 13.00, 13.00), -- Risotto ai Funghi
(10, 15, 1, 2.00, 2.00);  -- Mineral Water
(10, 10, 1, 6.00, 6.00);  -- Tiramisu





INSERT INTO invoices (order_id, customer_id, invoice_date, total_amount, discount_percentage) VALUES
(1, 1, '2023-01-01 20:00:00', 35.50, 0),
(2, 2, '2023-01-02 21:00:00', 34.20, 5.00),
(3, 3, '2023-01-03 21:30:00', 17.00, 0),
(4, 1, '2023-01-04 20:15:00', 21.60, 10.00),
(6, 5, '2023-01-06 21:00:00', 33.50, 0),
(7, 6, '2023-01-07 21:45:00', 12.50, 0),
(9, 8, '2023-01-10 21:00:00', 31.35, 5.00);





-- Invoice 1 Lines
INSERT INTO invoice_lines (invoice_id, product_id, amount, unit_price, total_price) VALUES
(1, 1, 1, 6.50, 6.50),
(1, 4, 2, 12.00, 24.00),
(1, 13, 2, 2.50, 5.00);

-- Invoice 2 Lines
INSERT INTO invoice_lines (invoice_id, product_id, amount, unit_price, total_price) VALUES
(2, 2, 1, 7.00, 7.00),
(2, 5, 1, 13.50, 13.50),
(2, 14, 2, 8.00, 16.00);

-- Invoice 3 Lines
INSERT INTO invoice_lines (invoice_id, product_id, amount, unit_price, total_price) VALUES
(3, 7, 1, 15.00, 15.00),
(3, 15, 1, 2.00, 2.00);

-- Additional Invoice Lines for more invoices
-- Invoice 4 Lines
INSERT INTO invoice_lines (invoice_id, product_id, amount, unit_price, total_price) VALUES
(4, 3, 1, 5.00, 5.00),
(4, 6, 1, 13.00, 13.00),
(4, 10, 1, 6.00, 6.00);

-- Invoice 5 Lines
INSERT INTO invoice_lines (invoice_id, product_id, amount, unit_price, total_price) VALUES
(5, 8, 1, 17.50, 17.50),
(5, 14, 2, 8.00, 16.00);

-- Invoice 6 Lines
INSERT INTO invoice_lines (invoice_id, product_id, amount, unit_price, total_price) VALUES
(6, 11, 2, 5.00, 10.00),
(6, 13, 1, 2.50, 2.50);

-- Invoice 7 Lines
INSERT INTO invoice_lines (invoice_id, product_id, amount, unit_price, total_price) VALUES
(7, 4, 1, 12.00, 12.00),
(7, 5, 1, 13.50, 13.50),
(7, 14, 1, 8.00, 8.00);


---



-- - **Field Names and Conventions**: All table names are pluralized, and primary keys are named `id` for simplicity and Rails compatibility.
-- - **Customers**: The `customers` table now includes additional fields like `address`, `date_of_birth`, `loyalty_points`, `preferred_contact_method`, and `marketing_opt_in` to support targeted advertising.
-- - **Products**: Added `picture_url` for product images and `created_at` timestamp to track when products were added.
-- - **Product Prices**: The `product_prices` table allows you to manage price changes over time with `start_date` and `end_date`.
-- - **Discounts**: The `discounts` table lets you create temporary discounts on products or entire categories, with start and end dates for promotional periods.
-- - **Invoices**: Added `customer_id` to link invoices directly to customers and included `discount_percentage` for flexible pricing strategies.
-- - **Order and Invoice Lines**: Updated to include `amount`, `unit_price`, and `total_price` for detailed transaction records.
-- - **Additional Data**: Expanded sample data to include more records across all tables, ensuring robust testing and development.



-- - **Timestamps**: Consider adding `created_at` and `updated_at` timestamps to all tables for better tracking and auditing.
-- - **Indexes**: Add indexes on foreign key columns to improve query performance.
-- - **Constraints**: Implement constraints like `CHECK` for data validation (e.g., ensuring `discount_percentage` is between 0 and 100).
-- - **User Authentication**: For a real application, you'd need to handle user authentication and security, possibly with a separate `users` table.



-- -- To illustrate how the data can be used, here are some sample queries:

-- -- - **Retrieve all active discounts**:
  
--   SELECT * FROM discounts
--   WHERE start_date <= CURRENT_DATE AND (end_date IS NULL OR end_date >= CURRENT_DATE);
  

-- - **Calculate total sales for a product**:
  
--   SELECT p.name, SUM(il.total_price) as total_sales
--   FROM invoice_lines il
--   JOIN products p ON il.product_id = p.id
--   GROUP BY p.name;
  

-- - **Find customers who opted in for marketing**:
  
--   SELECT name, email FROM customers
--   WHERE marketing_opt_in = TRUE;
  

---

-- Feel free to adjust any part of this setup to better fit your project's needs. If you have further questions or need additional assistance, don't hesitate to ask. Good luck with your online restaurant project!