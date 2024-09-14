CREATE DATABASE different_store_sales;

CREATE TABLE store_sales (
    invoice_no VARCHAR(50),
    customer_id VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    category VARCHAR(50),
    quantity INT,
    selling_price_per_unit DECIMAL(10, 2),
    cost_price_per_unit DECIMAL(10, 2),
    payment_method VARCHAR(50),
    region VARCHAR(50),
    state VARCHAR(50),
    shopping_mall VARCHAR(100),
    invoice_date DATE,
    invoice_time TIME
);
