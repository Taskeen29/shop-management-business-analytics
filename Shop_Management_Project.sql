USE shop_management;
CREATE TABLE products (
      product_id VARCHAR(10) PRIMARY KEY,
      product_name VARCHAR(100),
      purchase_price DECIMAL(10,2),
      selling_price DECIMAL(10,2)
);
USE shop_management;

ALTER TABLE products
ADD COLUMN category VARCHAR(50),
ADD COLUMN supplier VARCHAR(100),
ADD COLUMN opening_stock INT,
ADD COLUMN reorder_level INT;

SELECT * FROM products;

INSERT INTO products
(product_id, product_name, purchase_price, selling_price, category, supplier, opening_stock, reorder_level)
VALUES
('P001', 'Laptop', 40000, 50000, 'Electronics', 'ABC Traders', 10, 3),
('P002', 'Mouse', 500, 750, 'Accessories', 'ABC Traders', 30, 10),
('P003', 'Keyboard', 800, 1200, 'Accessories', 'ABC Traders', 25, 8),
('P004', 'Printer', 8000, 10000, 'Electronics', 'XYZ Suppliers', 8, 3),
('P005', 'USB Cable', 150, 250, 'Accessories', 'XYZ Suppliers', 50, 15),
('P006', 'Headphones', 1000, 1500, 'Accessories', 'Tech World', 20, 5),
('P007', 'Monitor', 10000, 13000, 'Electronics', 'Tech World', 12, 4),
('P008', 'Webcam', 1500, 2200, 'Accessories', 'Tech World', 15, 5),
('P009', 'SSD 500GB', 3000, 4000, 'Storage', 'XYZ Suppliers', 10, 3),
('P010', 'Pendrive 64 GB', 500, 800, 'Storage', 'ABC Traders', 25, 8);

SELECT SUM(opening_stock) AS total_opening_stock
FROM products;

SELECT SUM(opening_stock * purchase_price) AS total_inventory_value
FROM products;

SELECT SUM(opening_stock * selling_price) AS potential_sales_value
FROM products;

SELECT MAX(selling_price) AS highest_selling_price
FROM products;

SELECT MIN(selling_price) AS lowest_selling_price
FROM products;

SELECT product_name, selling_price
FROM products
ORDER BY selling_price DESC
LIMIT 1;

SELECT product_id, product_name, opening_stock, reorder_level
FROM products
WHERE opening_stock <= reorder_level;

SELECT 
    product_name,
    opening_stock,
    reorder_level,
    CASE
        WHEN opening_stock <= reorder_level THEN 'Reorder Required'
        ELSE 'Stock OK'
    END AS stock_status
FROM products;

SELECT category, SUM(opening_stock) AS total_stock
FROM products
GROUP BY category;

SELECT 
    category,
    SUM(opening_stock * purchase_price) AS inventory_value
FROM products
GROUP BY category;

SELECT 
    supplier,
    SUM(opening_stock * purchase_price) AS inventory_value
FROM products
GROUP BY supplier;

SELECT product_name, selling_price
FROM products
ORDER BY selling_price DESC
LIMIT 5;

SELECT AVG(selling_price) AS average_selling_price
FROM products;

SELECT COUNT(*) AS total_products
FROM products;

SELECT 
    supplier,
    SUM(opening_stock) AS total_stock
FROM products
GROUP BY supplier;

SELECT product_name, selling_price
FROM products
WHERE selling_price > 5000;

SELECT
    product_name,
    purchase_price,
    selling_price,
    selling_price - purchase_price AS profit_per_unit
FROM products;

SELECT
    product_name,
    purchase_price,
    selling_price,
    selling_price - purchase_price AS profit,
    ROUND(
        ((selling_price - purchase_price) / purchase_price) * 100,
        2
    ) AS profit_margin_percent
FROM products;

SELECT
    product_name,
    selling_price - purchase_price AS profit_per_unit
FROM products
ORDER BY profit_per_unit DESC
LIMIT 1;

CREATE TABLE sales (
    sales_id VARCHAR(10) PRIMARY KEY,
    sales_date DATE,
    product_id VARCHAR(10),
    product_name VARCHAR(100),
    quantity INT,
    selling_price DECIMAL(10,2),
    total_sales DECIMAL(12,2),
    purchase_price DECIMAL(10,2),
    cost_of_goods_sold DECIMAL(12,2)
);

DESCRIBE sales;

SELECT * FROM sales;

ALTER TABLE sales
ADD COLUMN customer_type VARCHAR(20);

INSERT INTO sales
(sales_id, sales_date, product_id, product_name, quantity, selling_price, total_sales, purchase_price, cost_of_goods_sold, customer_type)
VALUES
('S001', '2026-09-01', 'P001', 'Laptop', 2, 50000, 100000, 40000, 80000, 'Retail'),
('S002', '2026-09-01', 'P002', 'Mouse', 5, 750, 3750, 500, 2500, 'Retail'),
('S003', '2026-09-02', 'P003', 'Keyboard', 3, 1200, 3600, 800, 2400, 'Retail'),
('S004', '2026-09-02', 'P004', 'Printer', 1, 10000, 10000, 8000, 8000, 'Business'),
('S005', '2026-09-03', 'P005', 'USB Cable', 10, 250, 2500, 150, 1500, 'Retail'),
('S006', '2026-09-04', 'P006', 'Headphones', 4, 1500, 6000, 1000, 4000, 'Retail'),
('S007', '2026-09-05', 'P007', 'Monitor', 2, 13000, 26000, 10000, 20000, 'Business'),
('S008', '2026-09-06', 'P008', 'Webcam', 3, 2200, 6600, 1500, 4500, 'Retail'),
('S009', '2026-09-07', 'P009', 'SSD 500GB', 2, 4000, 8000, 3000, 6000, 'Business'),
('S010', '2026-09-08', 'P010', 'Pendrive 64 GB', 6, 800, 4800, 500, 3000, 'Retail');

SELECT SUM(total_sales) AS total_sales
FROM sales;

SELECT SUM(quantity) AS total_quantity_sold
FROM sales;

SELECT SUM(cost_of_goods_sold) AS total_cogs
FROM sales;

SELECT
    SUM(total_sales) - SUM(cost_of_goods_sold) AS gross_profit
FROM sales;

SELECT
    ROUND(
        ((SUM(total_sales) - SUM(cost_of_goods_sold)) / SUM(total_sales)) * 100,
        2
    ) AS gross_profit_margin_percent
FROM sales;

SELECT
    customer_type,
    SUM(total_sales) AS total_sales
FROM sales
GROUP BY customer_type;

SELECT
    product_name,
    SUM(quantity) AS quantity_sold,
    SUM(total_sales) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC;

SELECT
    product_name,
    SUM(total_sales) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    product_name,
    SUM(total_sales) - SUM(cost_of_goods_sold) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC;

SELECT
    product_name,
    SUM(total_sales) - SUM(cost_of_goods_sold) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 1;

SELECT
    sales_date,
    SUM(total_sales) AS daily_sales
FROM sales
GROUP BY sales_date
ORDER BY sales_date;

SELECT
    sales_date,
    SUM(total_sales) AS daily_sales
FROM sales
GROUP BY sales_date
ORDER BY daily_sales DESC
LIMIT 1;

SELECT
    ROUND(AVG(total_sales), 2) AS average_sale_value
FROM sales;

SELECT
    MONTHNAME(sales_date) AS month,
    SUM(total_sales) AS monthly_sales
FROM sales
GROUP BY MONTH(sales_date), MONTHNAME(sales_date)
ORDER BY MONTH(sales_date);

SELECT
    customer_type,
    SUM(quantity) AS total_quantity_sold
FROM sales
GROUP BY customer_type;

SELECT
    customer_type,
    SUM(total_sales) - SUM(cost_of_goods_sold) AS total_profit
FROM sales
GROUP BY customer_type;

SELECT
    p.product_name,
    p.category,
    s.quantity,
    s.total_sales
FROM products p
JOIN sales s
    ON p.product_id = s.product_id;
    
    SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(s.quantity) AS quantity_sold,
    SUM(s.total_sales) AS total_sales
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_sales DESC;

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(s.quantity), 0) AS quantity_sold,
    COALESCE(SUM(s.total_sales), 0) AS total_sales
FROM products p
LEFT JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_sales DESC;

SELECT
    p.product_id,
    p.product_name,
    p.category
FROM products p
LEFT JOIN sales s
    ON p.product_id = s.product_id
WHERE s.product_id IS NULL;

SELECT
    p.product_id,
    p.product_name,
    p.opening_stock,
    COALESCE(SUM(s.quantity), 0) AS quantity_sold,
    p.opening_stock - COALESCE(SUM(s.quantity), 0) AS remaining_stock
FROM products p
LEFT JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.opening_stock
ORDER BY remaining_stock ASC;

SELECT
    p.product_id,
    p.product_name,
    p.opening_stock - COALESCE(SUM(s.quantity), 0) AS remaining_stock,
    p.reorder_level,
    CASE
        WHEN p.opening_stock - COALESCE(SUM(s.quantity), 0) <= p.reorder_level
        THEN 'Reorder Required'
        ELSE 'Stock OK'
    END AS stock_status
FROM products p
LEFT JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.opening_stock,
    p.reorder_level
ORDER BY remaining_stock ASC;

SELECT
    p.category,
    SUM(s.total_sales) AS total_sales
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

SELECT
    p.category,
    SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY total_profit DESC;

SELECT
    p.supplier,
    SUM(s.total_sales) AS total_sales
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.supplier
ORDER BY total_sales DESC;

SELECT
    p.supplier,
    SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.supplier
ORDER BY total_profit DESC;

SELECT
    p.product_name,
    SUM(s.total_sales) AS product_sales,
    ROUND(
        SUM(s.total_sales) * 100 /
        (SELECT SUM(total_sales) FROM sales),
        2
    ) AS sales_percentage
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY product_sales DESC;

SELECT
    p.product_name,
    SUM(s.total_sales) AS total_sales
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING SUM(s.total_sales) >
(
    SELECT AVG(product_sales)
    FROM
    (
        SELECT SUM(total_sales) AS product_sales
        FROM sales
        GROUP BY product_id
    ) AS sales_summary
)
ORDER BY total_sales DESC;

SELECT
    p.product_name,
    SUM(s.total_sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(s.total_sales) DESC) AS sales_rank
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY sales_rank;

SELECT
    DATE_FORMAT(sales_date, '%M') AS month_name,
    SUM(total_sales) AS monthly_sales
FROM sales
GROUP BY
    MONTH(sales_date),
    DATE_FORMAT(sales_date, '%M')
ORDER BY MONTH(sales_date);

SELECT
    sales_date,
    SUM(total_sales) AS daily_sales,
    SUM(quantity) AS quantity_sold
FROM sales
GROUP BY sales_date
ORDER BY sales_date;

SELECT
    sales_date,
    SUM(total_sales) AS total_sales
FROM sales
GROUP BY sales_date
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    ROUND(AVG(total_sales), 2) AS average_sale_value
FROM sales;

SELECT
    customer_type,
    COUNT(*) AS total_transactions,
    SUM(quantity) AS quantity_sold,
    SUM(total_sales) AS total_sales,
    SUM(total_sales - cost_of_goods_sold) AS total_profit
FROM sales
GROUP BY customer_type
ORDER BY total_sales DESC;

SELECT
    p.product_name,
    SUM(s.quantity) AS quantity_sold,
    SUM(s.total_sales) AS total_sales
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_sales DESC
LIMIT 3;

SELECT
    p.product_name,
    SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_profit DESC
LIMIT 3;

SELECT
    p.product_id,
    p.product_name,
    p.opening_stock - COALESCE(SUM(s.quantity), 0) AS remaining_stock,
    p.reorder_level
FROM products p
LEFT JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.opening_stock,
    p.reorder_level
HAVING remaining_stock <= p.reorder_level
ORDER BY remaining_stock ASC;

SELECT
    p.product_id,
    p.product_name,
    p.opening_stock - COALESCE(SUM(s.quantity), 0) AS remaining_stock,
    p.purchase_price,
    (p.opening_stock - COALESCE(SUM(s.quantity), 0)) * p.purchase_price AS inventory_value
FROM products p
LEFT JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.opening_stock,
    p.purchase_price
ORDER BY inventory_value DESC;

SELECT
    SUM(
        (p.opening_stock - COALESCE(s.sold_quantity, 0))
        * p.purchase_price
    ) AS total_inventory_value
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS sold_quantity
    FROM sales
    GROUP BY product_id
) s
ON p.product_id = s.product_id;

SELECT
    COUNT(DISTINCT sales_id) AS total_transactions,
    SUM(quantity) AS total_quantity_sold,
    SUM(total_sales) AS total_sales,
    SUM(cost_of_goods_sold) AS total_cogs,
    SUM(total_sales - cost_of_goods_sold) AS gross_profit,
    ROUND(
        SUM(total_sales - cost_of_goods_sold) * 100 / SUM(total_sales),
        2
    ) AS gross_profit_margin
FROM sales;

CREATE VIEW product_sales_performance AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(s.quantity) AS quantity_sold,
    SUM(s.total_sales) AS total_sales,
    SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category;
    
    SELECT * FROM product_sales_performance;
    
    CREATE VIEW inventory_status AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.opening_stock,
    COALESCE(SUM(s.quantity), 0) AS quantity_sold,
    p.opening_stock - COALESCE(SUM(s.quantity), 0) AS remaining_stock,
    p.reorder_level,
    CASE
        WHEN p.opening_stock - COALESCE(SUM(s.quantity), 0) <= p.reorder_level
        THEN 'Reorder Required'
        ELSE 'Stock OK'
    END AS stock_status
FROM products p
LEFT JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.opening_stock,
    p.reorder_level;
    
    SELECT * FROM inventory_status;
    
    SELECT
    product_id,
    product_name,
    category,
    remaining_stock,
    reorder_level,
    stock_status
FROM inventory_status
WHERE stock_status = 'Reorder Required';

CREATE VIEW customer_sales_analysis AS
SELECT
    customer_type,
    COUNT(*) AS total_transactions,
    SUM(quantity) AS quantity_sold,
    SUM(total_sales) AS total_sales,
    SUM(cost_of_goods_sold) AS total_cogs,
    SUM(total_sales - cost_of_goods_sold) AS total_profit
FROM sales
GROUP BY customer_type;

SELECT * FROM customer_sales_analysis;

CREATE VIEW monthly_sales_analysis AS
SELECT
    YEAR(sales_date) AS sales_year,
    MONTH(sales_date) AS sales_month,
    DATE_FORMAT(sales_date, '%M') AS month_name,
    SUM(quantity) AS quantity_sold,
    SUM(total_sales) AS total_sales,
    SUM(total_sales - cost_of_goods_sold) AS total_profit
FROM sales
GROUP BY
    YEAR(sales_date),
    MONTH(sales_date),
    DATE_FORMAT(sales_date, '%M');
    
    SELECT * FROM monthly_sales_analysis;
    
    CREATE VIEW sales_kpi AS
SELECT
    COUNT(DISTINCT sales_id) AS total_transactions,
    SUM(quantity) AS total_quantity_sold,
    SUM(total_sales) AS total_sales,
    SUM(cost_of_goods_sold) AS total_cogs,
    SUM(total_sales - cost_of_goods_sold) AS gross_profit,
    ROUND(
        SUM(total_sales - cost_of_goods_sold) * 100 / SUM(total_sales),
        2
    ) AS gross_profit_margin,
    ROUND(AVG(total_sales), 2) AS average_sale_value
FROM sales;

SELECT * FROM sales_kpi;

CREATE TABLE purchases (
    purchase_id VARCHAR(10) PRIMARY KEY,
    purchase_date DATE,
    product_id VARCHAR(10),
    product_name VARCHAR(100),
    supplier VARCHAR(100),
    quantity INT,
    purchase_price DECIMAL(10,2),
    total_purchase DECIMAL(12,2)
);

INSERT INTO purchases
(purchase_id, purchase_date, product_id, product_name, supplier, quantity, purchase_price, total_purchase)
VALUES
('PU001', '2026-09-01', 'P001', 'Laptop', 'ABC Traders', 5, 40000, 200000),
('PU002', '2026-09-01', 'P002', 'Mouse', 'ABC Traders', 20, 500, 10000),
('PU003', '2026-09-02', 'P003', 'Keyboard', 'ABC Traders', 15, 800, 12000),
('PU004', '2026-09-02', 'P004', 'Printer', 'XYZ Suppliers', 5, 8000, 40000),
('PU005', '2026-09-03', 'P005', 'USB Cable', 'XYZ Suppliers', 30, 150, 4500),
('PU006', '2026-09-04', 'P006', 'Headphones', 'Tech World', 10, 1000, 10000),
('PU007', '2026-09-05', 'P007', 'Monitor', 'Tech World', 5, 10000, 50000),
('PU008', '2026-09-06', 'P008', 'Webcam', 'Tech World', 8, 1500, 12000),
('PU009', '2026-09-07', 'P009', 'SSD 500GB', 'XYZ Suppliers', 10, 3000, 30000),
('PU010', '2026-09-08', 'P010', 'Pendrive 64 GB', 'ABC Traders', 20, 500, 10000);

SELECT * FROM purchases;

SELECT
    COUNT(DISTINCT purchase_id) AS total_purchase_transactions,
    SUM(quantity) AS total_quantity_purchased,
    SUM(total_purchase) AS total_purchase_cost
FROM purchases;

SELECT
    supplier,
    COUNT(DISTINCT purchase_id) AS purchase_transactions,
    SUM(quantity) AS quantity_purchased,
    SUM(total_purchase) AS total_purchase_cost
FROM purchases
GROUP BY supplier
ORDER BY total_purchase_cost DESC;

SELECT
    product_id,
    product_name,
    SUM(quantity) AS quantity_purchased,
    SUM(total_purchase) AS total_purchase_cost
FROM purchases
GROUP BY
    product_id,
    product_name
ORDER BY total_purchase_cost DESC;

SELECT
    p.product_name,
    COALESCE(SUM(pu.total_purchase), 0) AS total_purchase_cost,
    COALESCE(SUM(s.total_sales), 0) AS total_sales
FROM products p
LEFT JOIN purchases pu
    ON p.product_id = pu.product_id
LEFT JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_sales DESC;

SELECT
    p.product_name,
    COALESCE(pu.total_purchase_cost, 0) AS total_purchase_cost,
    COALESCE(s.total_sales, 0) AS total_sales,
    COALESCE(s.total_sales, 0) - COALESCE(pu.total_purchase_cost, 0) AS sales_minus_purchase
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(total_purchase) AS total_purchase_cost
    FROM purchases
    GROUP BY product_id
) pu
ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(total_sales) AS total_sales
    FROM sales
    GROUP BY product_id
) s
ON p.product_id = s.product_id
ORDER BY total_sales DESC;

CREATE VIEW purchase_analysis AS
SELECT
    supplier,
    COUNT(DISTINCT purchase_id) AS purchase_transactions,
    SUM(quantity) AS quantity_purchased,
    SUM(total_purchase) AS total_purchase_cost
FROM purchases
GROUP BY supplier;

SELECT * FROM purchase_analysis;

CREATE TABLE expenses (
    expense_id VARCHAR(10) PRIMARY KEY,
    expense_date DATE,
    expense_type VARCHAR(50),
    description VARCHAR(150),
    amount DECIMAL(12,2)
);

INSERT INTO expenses
(expense_id, expense_date, expense_type, description, amount)
VALUES
('E001', '2026-09-01', 'Internet', 'Internet bill', 15000),
('E002', '2026-09-02', 'Maintenance', 'Shop maintenance', 12000),
('E003', '2026-09-03', 'Packaging', 'Packaging materials', 4000),
('E004', '2026-09-04', 'Marketing', 'Marketing expense', 1500),
('E005', '2026-09-05', 'Miscellaneous', 'Miscellaneous expense', 1000),
('E006', '2026-09-06', 'Marketing', 'Online promotion', 2000),
('E007', '2026-09-07', 'Packaging', 'Additional packaging', 2500),
('E008', '2026-09-08', 'Miscellaneous', 'Other shop expense', 500);

SELECT * FROM expenses;

SELECT
    COUNT(*) AS total_expense_transactions,
    SUM(amount) AS total_expenses
FROM expenses;

SELECT
    expense_type,
    COUNT(*) AS transactions,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY expense_type
ORDER BY total_expense DESC;

SELECT
    expense_id,
    expense_date,
    expense_type,
    description,
    amount
FROM expenses
ORDER BY amount DESC
LIMIT 1;

SELECT
    (SELECT SUM(total_sales - cost_of_goods_sold)
     FROM sales)
    -
    (SELECT SUM(amount)
     FROM expenses) AS net_profit_after_expenses;
     
     SELECT
    ROUND(
        (
            (SELECT SUM(total_sales - cost_of_goods_sold) FROM sales)
            -
            (SELECT SUM(amount) FROM expenses)
        ) * 100
        /
        (SELECT SUM(total_sales) FROM sales),
        2
    ) AS net_profit_margin;
    
    SELECT
    YEAR(expense_date) AS expense_year,
    MONTH(expense_date) AS expense_month,
    DATE_FORMAT(expense_date, '%M') AS month_name,
    SUM(amount) AS total_expenses
FROM expenses
GROUP BY
    YEAR(expense_date),
    MONTH(expense_date),
    DATE_FORMAT(expense_date, '%M')
ORDER BY
    expense_year,
    expense_month;
    
    SELECT
    ROUND(
        (SELECT SUM(amount) FROM expenses)
        * 100
        /
        (SELECT SUM(total_sales) FROM sales),
        2
    ) AS expense_to_sales_ratio;
    
    CREATE VIEW expense_analysis AS
SELECT
    expense_type,
    COUNT(*) AS transactions,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY expense_type;

SELECT * FROM expense_analysis
ORDER BY total_expense DESC;

SELECT
    total_sales,
    total_cogs,
    gross_profit,
    total_expenses,
    gross_profit - total_expenses AS net_profit
FROM
(
    SELECT
        SUM(total_sales) AS total_sales,
        SUM(cost_of_goods_sold) AS total_cogs,
        SUM(total_sales - cost_of_goods_sold) AS gross_profit
    FROM sales
) s
CROSS JOIN
(
    SELECT
        SUM(amount) AS total_expenses
    FROM expenses
) e;

SELECT
    customer_type,
    SUM(total_sales) AS total_sales,
    SUM(cost_of_goods_sold) AS total_cogs,
    SUM(total_sales - cost_of_goods_sold) AS gross_profit
FROM sales
GROUP BY customer_type
ORDER BY gross_profit DESC;

SELECT
    p.product_name,
    SUM(s.total_sales) AS total_sales,
    SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit,
    ROUND(
        SUM(s.total_sales - s.cost_of_goods_sold) * 100
        / SUM(s.total_sales),
        2
    ) AS profit_margin
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY profit_margin DESC;

SELECT
    p.category,
    SUM(s.total_sales) AS total_sales,
    SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit,
    ROUND(
        SUM(s.total_sales - s.cost_of_goods_sold) * 100
        / SUM(s.total_sales),
        2
    ) AS profit_margin
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY profit_margin DESC;

SELECT
    p.category,
    SUM(pu.quantity) AS quantity_purchased,
    SUM(pu.total_purchase) AS total_purchase_cost
FROM products p
JOIN purchases pu
    ON p.product_id = pu.product_id
GROUP BY p.category
ORDER BY total_purchase_cost DESC;

SELECT
    p.supplier,
    COUNT(DISTINCT pu.purchase_id) AS purchase_transactions,
    SUM(pu.quantity) AS quantity_purchased,
    SUM(pu.total_purchase) AS total_purchase_cost,
    ROUND(AVG(pu.purchase_price), 2) AS average_purchase_price
FROM products p
JOIN purchases pu
    ON p.product_id = pu.product_id
GROUP BY p.supplier
ORDER BY total_purchase_cost DESC;

SELECT
    p.product_name,
    COALESCE(pu.total_purchase_cost, 0) AS purchase_cost,
    COALESCE(s.total_sales, 0) AS sales_revenue,
    COALESCE(s.total_sales, 0) - COALESCE(pu.total_purchase_cost, 0) AS revenue_minus_purchase
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(total_purchase) AS total_purchase_cost
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(total_sales) AS total_sales
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id
ORDER BY sales_revenue DESC;

SELECT
    p.product_id,
    p.product_name,
    p.opening_stock,
    COALESCE(pu.quantity_purchased, 0) AS quantity_purchased,
    COALESCE(s.quantity_sold, 0) AS quantity_sold,
    p.opening_stock
        + COALESCE(pu.quantity_purchased, 0)
        - COALESCE(s.quantity_sold, 0) AS current_stock
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_purchased
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id
ORDER BY current_stock ASC;

SELECT
    p.product_id,
    p.product_name,
    p.purchase_price,
    (
        p.opening_stock
        + COALESCE(pu.quantity_purchased, 0)
        - COALESCE(s.quantity_sold, 0)
    ) AS current_stock,
    (
        p.opening_stock
        + COALESCE(pu.quantity_purchased, 0)
        - COALESCE(s.quantity_sold, 0)
    ) * p.purchase_price AS current_stock_value
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_purchased
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id
ORDER BY current_stock_value DESC;

SELECT
    p.product_id,
    p.product_name,
    p.opening_stock
        + COALESCE(pu.quantity_purchased, 0)
        - COALESCE(s.quantity_sold, 0) AS current_stock,
    p.reorder_level,
    CASE
        WHEN p.opening_stock
             + COALESCE(pu.quantity_purchased, 0)
             - COALESCE(s.quantity_sold, 0)
             <= p.reorder_level
        THEN 'Reorder Required'
        ELSE 'Stock OK'
    END AS stock_status
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_purchased
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id
ORDER BY current_stock ASC;

SELECT
    p.category,
    SUM(
        (
            p.opening_stock
            + COALESCE(pu.quantity_purchased, 0)
            - COALESCE(s.quantity_sold, 0)
        ) * p.purchase_price
    ) AS current_inventory_value
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_purchased
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY current_inventory_value DESC;

SELECT
    SUM(
        (
            p.opening_stock
            + COALESCE(pu.quantity_purchased, 0)
            - COALESCE(s.quantity_sold, 0)
        ) * p.purchase_price
    ) AS total_current_inventory_value
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_purchased
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id;
    
    SELECT
    p.supplier,
    SUM(
        (
            p.opening_stock
            + COALESCE(pu.quantity_purchased, 0)
            - COALESCE(s.quantity_sold, 0)
        ) * p.purchase_price
    ) AS current_inventory_value
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_purchased
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id
GROUP BY p.supplier
ORDER BY current_inventory_value DESC;

CREATE VIEW current_inventory AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.supplier,
    p.purchase_price,
    p.opening_stock,
    COALESCE(pu.quantity_purchased, 0) AS quantity_purchased,
    COALESCE(s.quantity_sold, 0) AS quantity_sold,
    p.opening_stock
        + COALESCE(pu.quantity_purchased, 0)
        - COALESCE(s.quantity_sold, 0) AS current_stock,
    (
        p.opening_stock
        + COALESCE(pu.quantity_purchased, 0)
        - COALESCE(s.quantity_sold, 0)
    ) * p.purchase_price AS inventory_value,
    p.reorder_level
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_purchased
    FROM purchases
    GROUP BY product_id
) pu
    ON p.product_id = pu.product_id
LEFT JOIN
(
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id;
    
    SELECT * FROM current_inventory;
    
    SELECT
    product_id,
    product_name,
    category,
    supplier,
    current_stock,
    reorder_level,
    CASE
        WHEN current_stock <= reorder_level
        THEN 'Reorder Required'
        ELSE 'Stock OK'
    END AS stock_status
FROM current_inventory
ORDER BY current_stock ASC;

SELECT
    category,
    SUM(current_stock) AS total_current_stock,
    SUM(inventory_value) AS total_inventory_value
FROM current_inventory
GROUP BY category
ORDER BY total_inventory_value DESC;

SELECT
    category,
    SUM(inventory_value) AS inventory_value,
    ROUND(
        SUM(inventory_value) * 100 /
        (SELECT SUM(inventory_value) FROM current_inventory),
        2
    ) AS inventory_share_percentage
FROM current_inventory
GROUP BY category
ORDER BY inventory_value DESC;

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(s.total_sales, 0) AS total_sales,
    COALESCE(s.quantity_sold, 0) AS quantity_sold,
    ci.current_stock,
    ci.inventory_value,
    CASE
        WHEN ci.current_stock <= ci.reorder_level
        THEN 'Reorder Required'
        ELSE 'Stock OK'
    END AS stock_status
FROM products p
LEFT JOIN
(
    SELECT
        product_id,
        SUM(total_sales) AS total_sales,
        SUM(quantity) AS quantity_sold
    FROM sales
    GROUP BY product_id
) s
    ON p.product_id = s.product_id
JOIN current_inventory ci
    ON p.product_id = ci.product_id
ORDER BY total_sales DESC;

SELECT
    product_id,
    product_name,
    category,
    current_stock,
    inventory_value
FROM current_inventory
WHERE inventory_value > 50000
ORDER BY inventory_value DESC;

SELECT
    product_id,
    product_name,
    category,
    total_sales,
    total_profit
FROM product_sales_performance
WHERE total_sales > 5000
  AND total_profit > 1000
ORDER BY total_profit DESC;

SELECT
    product_id,
    product_name,
    category,
    total_sales,
    total_profit
FROM product_sales_performance
WHERE total_sales > 5000
  AND total_profit > 1000
ORDER BY total_profit DESC;

SELECT
    p.category,
    SUM(s.total_sales) AS total_sales
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.total_sales) > 20000
ORDER BY total_sales DESC;

SELECT
    product_id,
    product_name,
    category,
    selling_price
FROM products
WHERE selling_price > (
    SELECT AVG(selling_price)
    FROM products
)
ORDER BY selling_price DESC;

SELECT AVG(selling_price)
FROM products

SELECT
    product_id,
    product_name,
    total_sales
FROM product_sales_performance
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM product_sales_performance
)
ORDER BY total_sales DESC;

SELECT
    product_id,
    product_name,
    selling_price,
    CASE
        WHEN selling_price >= 10000 THEN 'High Value'
        WHEN selling_price >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS product_value
FROM products
ORDER BY selling_price DESC;

SELECT
    product_id,
    product_name,
    total_sales,
    total_profit,
    CASE
        WHEN total_profit >= 10000 THEN 'High Profit'
        WHEN total_profit >= 5000 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS profit_category
FROM product_sales_performance
ORDER BY total_profit DESC;

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(s.total_sales) AS total_sales
    FROM products p
    JOIN sales s
        ON p.product_id = s.product_id
    GROUP BY
        p.product_id,
        p.product_name
)
SELECT
    product_id,
    product_name,
    total_sales
FROM product_sales
WHERE total_sales > 5000
ORDER BY total_sales DESC;

WITH category_performance AS (
    SELECT
        p.category,
        SUM(s.total_sales) AS total_sales,
        SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit
    FROM products p
    JOIN sales s
        ON p.product_id = s.product_id
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    total_profit
FROM category_performance
ORDER BY total_profit DESC;

WITH category_profit AS (
    SELECT
        p.category,
        SUM(s.total_sales) AS total_sales,
        SUM(s.total_sales - s.cost_of_goods_sold) AS total_profit
    FROM products p
    JOIN sales s
        ON p.product_id = s.product_id
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    total_profit,
    ROUND(total_profit * 100 / total_sales, 2) AS profit_margin
FROM category_profit
ORDER BY profit_margin DESC;

SELECT
    product_id,
    product_name,
    total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM product_sales_performance
ORDER BY sales_rank;

SELECT
    sales_date,
    sales_id,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY sales_date, sales_id
    ) AS running_sales
FROM sales
ORDER BY sales_date, sales_id;

SELECT
    product_id,
    product_name,
    total_sales,
    ROUND(
        total_sales * 100 /
        SUM(total_sales) OVER (),
        2
    ) AS sales_percentage
FROM product_sales_performance
ORDER BY sales_percentage DESC;

SELECT
    product_id,
    product_name,
    category,
    total_sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS category_sales_rank
FROM product_sales_performance
ORDER BY category, category_sales_rank;

SELECT
    product_id,
    product_name,
    category,
    total_sales,
    ROW_NUMBER() OVER (
        ORDER BY total_sales DESC
    ) AS product_rank
FROM product_sales_performance
ORDER BY product_rank;

SELECT
    product_id,
    product_name,
    total_sales,
    DENSE_RANK() OVER (
        ORDER BY total_sales DESC
    ) AS dense_sales_rank
FROM product_sales_performance
ORDER BY dense_sales_rank;

SELECT
    sales_id,
    COUNT(*) AS occurrence_count
FROM sales
GROUP BY sales_id
HAVING COUNT(*) > 1;

SELECT
    s.sales_id,
    s.product_id,
    s.product_name
FROM sales s
LEFT JOIN products p
    ON s.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT
    sales_id,
    product_id,
    quantity,
    selling_price,
    total_sales,
    quantity * selling_price AS calculated_sales
FROM sales
WHERE total_sales <> quantity * selling_price;

SELECT
    sales_id,
    product_id,
    quantity,
    purchase_price,
    cost_of_goods_sold,
    quantity * purchase_price AS calculated_cogs
FROM sales
WHERE cost_of_goods_sold <> quantity * purchase_price;

SELECT
    purchase_id,
    product_id,
    quantity,
    purchase_price,
    total_purchase,
    quantity * purchase_price AS calculated_purchase
FROM purchases
WHERE total_purchase <> quantity * purchase_price;

SELECT
    product_id,
    product_name,
    current_stock,
    inventory_value
FROM current_inventory
WHERE current_stock <= 0;

SELECT
    product_id,
    product_name,
    purchase_price,
    selling_price
FROM products
WHERE selling_price <= purchase_price;

DESCRIBE products;

DESCRIBE sales;

SHOW TABLES;

CREATE INDEX idx_sales_product_id
ON sales(product_id);

CREATE INDEX idx_purchases_product_id
ON purchases(product_id);

SHOW INDEX FROM sales;

SELECT
    MAX(sales_date) AS latest_sale_date
FROM sales;

SELECT
    MIN(sales_date) AS first_sale_date
FROM sales;

SELECT
    DATEDIFF(
        MAX(sales_date),
        MIN(sales_date)
    ) + 1 AS sales_period_days
FROM sales;

SELECT
    COUNT(DISTINCT sales_id) AS total_transactions,
    SUM(quantity) AS total_quantity_sold,
    SUM(total_sales) AS total_sales,
    SUM(cost_of_goods_sold) AS total_cogs,
    SUM(total_sales - cost_of_goods_sold) AS gross_profit,
    ROUND(
        SUM(total_sales - cost_of_goods_sold) * 100
        / SUM(total_sales),
        2
    ) AS gross_profit_margin,
    ROUND(AVG(total_sales), 2) AS average_sale_value
FROM sales;

SHOW FULL TABLES;

SELECT *
FROM sales_kpi;

SELECT *
FROM current_inventory;

SELECT *
FROM customer_sales_analysis;

SELECT *
FROM purchase_analysis;

CREATE VIEW business_performance AS
SELECT
    s.total_sales,
    s.total_cogs,
    s.gross_profit,
    e.total_expenses,
    s.gross_profit - e.total_expenses AS net_profit,
    ROUND(
        (s.gross_profit - e.total_expenses) * 100
        / s.total_sales,
        2
    ) AS net_profit_margin
FROM
(
    SELECT
        SUM(total_sales) AS total_sales,
        SUM(cost_of_goods_sold) AS total_cogs,
        SUM(total_sales - cost_of_goods_sold) AS gross_profit
    FROM sales
) s
CROSS JOIN
(
    SELECT
        SUM(amount) AS total_expenses
    FROM expenses
) e;

SELECT *
FROM business_performance;

DESCRIBE business_performance;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT
    (SELECT COUNT(*) FROM products) AS products_count,
    (SELECT COUNT(*) FROM sales) AS sales_count,
    (SELECT COUNT(*) FROM purchases) AS purchases_count,
    (SELECT COUNT(*) FROM expenses) AS expenses_count;
    
    SELECT
    total_sales,
    total_cogs,
    gross_profit,
    total_expenses,
    net_profit,
    net_profit_margin
FROM business_performance
WHERE net_profit IS NOT NULL;

SELECT
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT SUM(quantity) FROM sales) AS total_quantity_sold,
    (SELECT SUM(total_sales) FROM sales) AS total_sales,
    (SELECT SUM(cost_of_goods_sold) FROM sales) AS total_cogs,
    (SELECT SUM(total_sales - cost_of_goods_sold) FROM sales) AS gross_profit,
    (SELECT SUM(amount) FROM expenses) AS total_expenses,
    (SELECT SUM(total_sales - cost_of_goods_sold) FROM sales)
        - (SELECT SUM(amount) FROM expenses) AS net_profit;
        
        SHOW CREATE DATABASE shop_management;