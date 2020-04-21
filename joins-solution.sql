-- 1. Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" ON "customers".id = "addresses".customer_id;

-- 2. Get all orders and their line items (orders, quantity and product)
SELECT "customers".first_name, "customers".last_name, "orders".order_date, "products".description, "products".unit_price, "line_items".quantity FROM "customers"
JOIN "addresses" ON "customers".id = "addresses".customer_id
JOIN "orders" ON "addresses".id = "orders".address_id
JOIN "line_items" ON "orders".id = "line_items".order_id
JOIN "products" ON "line_items".product_id = "products".id;

-- 3. Which warehouses have cheetos?
SELECT "products".description, "warehouse_product".on_hand, "warehouse".warehouse FROM "warehouse_product"
JOIN "warehouse" ON "warehouse_product".warehouse_id = "warehouse".id
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".description = 'cheetos'
ORDER BY "warehouse_product".on_hand DESC;

-- 4. Which warehouses have diet pepsi?
SELECT "products".description, "warehouse_product".on_hand, "warehouse".warehouse FROM "warehouse_product"
JOIN "warehouse" ON "warehouse_product".warehouse_id = "warehouse".id
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".description = 'diet pepsi'
ORDER BY "warehouse_product".on_hand DESC;

-- 5. Get the number of orders for each customer.
SELECT "customers".first_name, "customers".last_name, count("address_id") as "order_num" FROM "customers"
JOIN "addresses" ON "customers".id = "addresses".customer_id
JOIN "orders" ON "addresses".id = "orders".address_id
GROUP BY "customers".first_name, "customers".last_name;

-- 6. How many customers do we have?
SELECT count(*) as "total_customers" FROM "customers";

-- 7. How many products do we carry?
SELECT count(*) as "num_of_product_types" FROM "products";

-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM("on_hand") as "total_num_of_diet_pepsi" FROM "warehouse_product"
JOIN "warehouse" ON "warehouse_product".warehouse_id = "warehouse".id
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".description = 'diet pepsi';

-- 9. How much was the total cost for each order?
SELECT "customers".first_name, "customers".last_name, SUM("unit_price"*"quantity") as "total_cost"  FROM "customers"
JOIN "addresses" ON "customers".id = "addresses".customer_id
JOIN "orders" ON "addresses".id = "orders".address_id
JOIN "line_items" ON "orders".id = "line_items".order_id
JOIN "products" ON "line_items".product_id = "products".id
GROUP BY "orders".id, "customers".first_name, "customers".last_name;

-- 10. How much has each customer spent in total?
SELECT SUM("unit_price"*"quantity") as "total_cost", "customers".first_name, "customers".last_name FROM "customers"
JOIN "addresses" ON "customers".id = "addresses".customer_id
JOIN "orders" ON "addresses".id = "orders".address_id
JOIN "line_items" ON "orders".id = "line_items".order_id
JOIN "products" ON "line_items".product_id = "products".id
GROUP BY "customers".first_name, "customers".last_name;