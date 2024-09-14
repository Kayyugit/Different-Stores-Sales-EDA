-- Total Sales by Category
SELECT category, 
    SUM(quantity * selling_price_per_unit) AS Total_Sales
FROM store_sales
GROUP BY category
ORDER BY Total_Sales DESC;

-- Average Selling Price by Category
SELECT category, 
    AVG(selling_price_per_unit) AS avg_selling_price
FROM store_sales
GROUP BY category
ORDER BY avg_selling_price DESC;

-- Sales Distribution by Region
SELECT region, 
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY region
ORDER BY total_sales DESC;

-- Most Popular Payment Method
SELECT payment_method, 
    COUNT(*) AS usage_count
FROM store_sales
GROUP BY payment_method
ORDER BY usage_count DESC;

-- Top 5 Customers by Spending
SELECT customer_id, 
    SUM(quantity * selling_price_per_unit) AS total_spending
FROM store_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 5;

-- Sales Trend by Date
SELECT invoice_date, 
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY invoice_date
ORDER BY invoice_date ASC;

-- Profit Margin by Category
SELECT 
    category, 
    SUM((selling_price_per_unit - cost_price_per_unit) * quantity) AS total_profit,
    SUM(selling_price_per_unit * quantity) AS total_revenue,
    SUM((selling_price_per_unit - cost_price_per_unit) * quantity) / SUM(selling_price_per_unit * quantity) * 100 AS profit_margin_percentage
FROM store_sales
GROUP BY category
ORDER BY profit_margin_percentage DESC;

-- Age Demographics of Customers
SELECT age, 
    COUNT(*) AS customer_count
FROM store_sales
GROUP BY age
ORDER BY customer_count DESC;

-- Sales by Gender
SELECT gender,
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY gender
ORDER BY total_sales DESC;

-- Sales by State and Shopping Mall
SELECT state, 
    shopping_mall, 
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY state, shopping_mall
ORDER BY total_sales DESC;

-- Sales Contribution by Payment Method per Category
SELECT category, payment_method, 
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY category, payment_method
ORDER BY 
    category, total_sales DESC;
    
-- Average Quantity Sold per Transaction
SELECT 
    AVG(quantity) AS average_quantity_sold
FROM 
    store_sales;
    
-- Customer Retention Analysis (Returning Customers)
SELECT customer_id, 
    COUNT(DISTINCT invoice_no) AS purchase_count
FROM store_sales
GROUP BY customer_id
HAVING purchase_count > 1
ORDER BY purchase_count DESC;

-- Highest Revenue-Generating State
SELECT state, 
    SUM(quantity * selling_price_per_unit) AS total_revenue
FROM store_sales
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 1;

-- Revenue by State
SELECT state, 
    SUM(quantity * selling_price_per_unit) AS total_revenue
FROM store_sales
GROUP BY state
ORDER BY total_revenue DESC;

-- Time of Day Analysis (Peak Sales Hours)
SELECT 
    HOUR(invoice_time) AS hour_of_day, 
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY HOUR(invoice_time)
ORDER BY total_sales DESC;

-- Gender-based Spending Analysis
SELECT gender, 
    AVG(quantity * selling_price_per_unit) AS average_spending
FROM store_sales
GROUP BY gender
ORDER BY average_spending DESC;

-- Top Performing Shopping Malls
SELECT shopping_mall, 
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY shopping_mall
ORDER BY total_sales DESC;

-- Profitability by Region
SELECT region, 
    SUM((selling_price_per_unit - cost_price_per_unit) * quantity) AS total_profit
FROM store_sales
GROUP BY region
ORDER BY total_profit DESC;

-- Customer Spending Distribution
SELECT 
    CASE 
        WHEN total_spending < 1000 THEN 'Low'
        WHEN total_spending BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'High'
    END AS spending_category,
    COUNT(*) AS customer_count
FROM 
    (SELECT 
        customer_id, 
        SUM(quantity * selling_price_per_unit) AS total_spending
     FROM 
        store_sales
     GROUP BY 
        customer_id) AS customer_spending
GROUP BY spending_category;

-- Sales Comparison by Age Group
SELECT 
    CASE 
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY age_group
ORDER BY total_sales DESC;

-- Customer Segmentation by Frequency of Purchase
SELECT 
    CASE 
        WHEN purchase_count = 1 THEN 'One-time Buyer'
        WHEN purchase_count BETWEEN 2 AND 5 THEN 'Frequent Buyer'
        ELSE 'Loyal Customer'
    END AS customer_segment,
    COUNT(*) AS customer_count
FROM 
    (SELECT 
        customer_id, 
        COUNT(DISTINCT invoice_no) AS purchase_count
     FROM 
        store_sales
     GROUP BY 
        customer_id) AS customer_frequency
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- Product Category Contribution to Total Profit
SELECT category, 
    SUM((selling_price_per_unit - cost_price_per_unit) * quantity) AS total_profit
FROM store_sales
GROUP BY category
ORDER BY total_profit DESC;

-- Regional Preference for Payment Methods
SELECT region, payment_method, 
    COUNT(*) AS usage_count
FROM store_sales
GROUP BY region, payment_method
ORDER BY region, usage_count DESC;

-- Seasonality Analysis (Sales by Month)
SELECT 
    MONTH(invoice_date) AS month, 
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY month
ORDER BY total_sales DESC;

-- Cost vs. Selling Price Analysis
SELECT 
    AVG(cost_price_per_unit) AS average_cost_price,
    AVG(selling_price_per_unit) AS average_selling_price,
    AVG(selling_price_per_unit) - AVG(cost_price_per_unit) AS average_profit_margin
FROM 
    store_sales;

-- Sales Growth Over Time
SELECT 
    DATE_FORMAT(invoice_date, '%Y-%m') AS month,
    SUM(quantity * selling_price_per_unit) AS total_sales,
    LAG(SUM(quantity * selling_price_per_unit)) OVER (ORDER BY DATE_FORMAT(invoice_date, '%Y-%m')) AS previous_month_sales,
    (SUM(quantity * selling_price_per_unit) - LAG(SUM(quantity * selling_price_per_unit)) OVER (ORDER BY DATE_FORMAT(invoice_date, '%Y-%m'))) / LAG(SUM(quantity * selling_price_per_unit)) OVER (ORDER BY DATE_FORMAT(invoice_date, '%Y-%m')) * 100 AS sales_growth_percentage
FROM store_sales
GROUP BY DATE_FORMAT(invoice_date, '%Y-%m')
ORDER BY month;

-- Customer Lifetime Value (CLV)
SELECT customer_id, 
    SUM(quantity * selling_price_per_unit) AS lifetime_value
FROM store_sales
GROUP BY customer_id
ORDER BY lifetime_value DESC;

-- Inventory Turnover Ratio by Category
SELECT 
    category, 
    SUM(quantity) AS total_quantity_sold,
    AVG(cost_price_per_unit) * SUM(quantity) AS total_cost_of_goods_sold,
    AVG(quantity * cost_price_per_unit) AS average_inventory_value,
    (SUM(quantity) / AVG(quantity * cost_price_per_unit)) AS inventory_turnover_ratio
FROM store_sales
GROUP BY category
ORDER BY inventory_turnover_ratio DESC;

-- Correlation Between Quantity and Price
SELECT category,
    (SUM(quantity * selling_price_per_unit) - (SUM(quantity) * SUM(selling_price_per_unit) / COUNT(*))) / 
    (SQRT(SUM(POWER(quantity, 2)) - POWER(SUM(quantity), 2) / COUNT(*)) * 
    SQRT(SUM(POWER(selling_price_per_unit, 2)) - POWER(SUM(selling_price_per_unit), 2) / COUNT(*))) AS correlation_quantity_price
FROM store_sales
GROUP BY category
ORDER BY correlation_quantity_price DESC;

-- Revenue Contribution by Top 20% Customers (Pareto Analysis)
SELECT customer_id,
    total_spending,
    (SELECT SUM(total_spending) FROM (SELECT SUM(quantity * selling_price_per_unit) AS total_spending FROM store_sales GROUP BY customer_id) AS all_customers) AS total_revenue,
    SUM(total_spending) OVER (ORDER BY total_spending DESC) / (SELECT SUM(total_spending) FROM (SELECT SUM(quantity * selling_price_per_unit) AS total_spending FROM store_sales GROUP BY customer_id) AS all_customers) AS cumulative_revenue_percentage
FROM 
    (SELECT 
        customer_id, 
        SUM(quantity * selling_price_per_unit) AS total_spending
     FROM 
        store_sales
     GROUP BY 
        customer_id) AS customer_revenue
ORDER BY 
    total_spending DESC
LIMIT 20;

-- Seasonal Product Demand Analysis
SELECT category, 
    CASE 
        WHEN MONTH(invoice_date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(invoice_date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(invoice_date) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(invoice_date) IN (9, 10, 11) THEN 'Fall'
    END AS season,
    SUM(quantity * selling_price_per_unit) AS total_sales
FROM store_sales
GROUP BY category, season
ORDER BY total_sales DESC;

-- Profitability of Different Payment Methods
SELECT payment_method, 
    SUM((selling_price_per_unit - cost_price_per_unit) * quantity) AS total_profit
FROM store_sales
GROUP BY payment_method
ORDER BY total_profit DESC;

-- Time Series Decomposition of Sales
SELECT invoice_date, 
    SUM(quantity * selling_price_per_unit) AS daily_sales
FROM store_sales
GROUP BY invoice_date
ORDER BY invoice_date;

