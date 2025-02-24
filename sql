-- Product Queries

-- Insert product "chair" with a price of 44.00 and not returnable.
INSERT INTO products (name, price, can_be_returned)
VALUES ('chair', 44.00, false);

-- Insert product "stool" with a price of 25.99 and returnable.
INSERT INTO products (name, price, can_be_returned)
VALUES ('stool', 25.99, true);

-- Insert product "table" with a price of 124.00 and not returnable.
INSERT INTO products (name, price, can_be_returned)
VALUES ('table', 124.00, false);

-- Retrieve all rows and columns from the products table.
SELECT * FROM products;

-- Retrieve only the names of all products.
SELECT name FROM products;

-- Retrieve the names and prices of all products.
SELECT name, price FROM products;

-- Insert a new product "hammock" with a price of 99.00 and returnable.
INSERT INTO products (name, price, can_be_returned)
VALUES ('hammock', 99.00, true);

-- Retrieve only the products that are returnable.
SELECT * FROM products WHERE can_be_returned = true;

-- Retrieve only the products with a price less than 44.00.
SELECT * FROM products WHERE price < 44.00;

-- Retrieve only the products with a price between 22.50 and 99.99.
SELECT * FROM products WHERE price BETWEEN 22.50 AND 99.99;

-- Apply a sale: reduce the price of every product by $20.
UPDATE products SET price = price - 20;

-- Remove products that now cost less than $25.
DELETE FROM products WHERE price < 25;

-- End the sale: increase the price of the remaining products by $20.
UPDATE products SET price = price + 20;

-- Update company policy: mark all products as returnable.
UPDATE products SET can_be_returned = true;


--------------------------------------------------


-- Playstore Queries

-- Query 0: Retrieve all records from the analytics table.
SELECT * FROM analytics;

-- 1. Retrieve the complete record for the app with an ID of 1880.
SELECT * FROM analytics
WHERE id = 1880;

-- 2. Retrieve the ID and app name for all apps last updated on August 1, 2018.
SELECT id, app_name FROM analytics
WHERE last_updated = '2018-08-01';

-- 3. Count the number of apps in each category.
SELECT category, COUNT(*) AS app_count
FROM analytics
GROUP BY category;

-- 4. Retrieve the top 5 most-reviewed apps along with their review counts.
SELECT * FROM analytics
ORDER BY reviews DESC
LIMIT 5;

-- 5. Retrieve the complete record for the app with the most reviews 
--    among apps with a rating of at least 4.8.
SELECT * FROM analytics
WHERE rating >= 4.8
ORDER BY reviews DESC
LIMIT 1;

-- 6. Retrieve the average rating for each category, ordered from highest to lowest average.
SELECT category, AVG(rating) AS avg_rating
FROM analytics
GROUP BY category
ORDER BY avg_rating DESC;

-- 7. Retrieve the app name, price, and rating of the most expensive app with a rating below 3.
SELECT app_name, price, rating FROM analytics
WHERE rating < 3
ORDER BY price DESC
LIMIT 1;

-- 8. Retrieve all records for apps with a minimum install count of 50 or fewer that have a rating.
SELECT * FROM analytics
WHERE min_installs <= 50
  AND rating IS NOT NULL
ORDER BY rating DESC;

-- 9. Retrieve the names of all apps with a rating below 3 and at least 10,000 reviews.
SELECT app_name FROM analytics
WHERE rating < 3
  AND reviews >= 10000;

-- 10. Retrieve the top 10 most-reviewed apps that cost between $0.10 and $1.00.
SELECT * FROM analytics
WHERE price BETWEEN 0.1 AND 1
ORDER BY reviews DESC
LIMIT 10;

-- 11. Retrieve the record of the most outdated app.
-- Option 1: Using a subquery
SELECT * FROM analytics
WHERE last_updated = (SELECT MIN(last_updated) FROM analytics);
-- Option 2: Without a subquery
SELECT * FROM analytics
ORDER BY last_updated
LIMIT 1;

-- 12. Retrieve the record of the most expensive app.
-- Option 1: Using a subquery
SELECT * FROM analytics
WHERE price = (SELECT MAX(price) FROM analytics);
-- Option 2: Without a subquery
SELECT * FROM analytics
ORDER BY price DESC
LIMIT 1;

-- 13. Calculate the total number of reviews in the Google Play Store.
SELECT SUM(reviews) AS total_reviews FROM analytics;

-- 14. Retrieve the categories that have more than 300 apps.
SELECT category
FROM analytics
GROUP BY category
HAVING COUNT(*) > 300;

-- 15. Retrieve the app with the highest ratio of reviews to minimum installs
-- among apps with at least 100,000 installs.
SELECT app_name, reviews, min_installs, (reviews::numeric / min_installs) AS review_ratio
FROM analytics
WHERE min_installs >= 100000
ORDER BY review_ratio DESC
LIMIT 1;


--------------------------------------------------


-- Further Study Queries

-- FS1. Retrieve the name and rating of the top-rated app in each category
-- among apps with at least 50,000 installs.
SELECT app_name, rating, category
FROM analytics
WHERE (rating, category) IN (
    SELECT MAX(rating), category
    FROM analytics
    WHERE min_installs >= 50000
    GROUP BY category
)
ORDER BY category;

-- FS2. Retrieve all apps with names that include "facebook" (case-insensitive).
SELECT * FROM analytics
WHERE app_name ILIKE '%facebook%';

-- FS3. Retrieve all apps that belong to more than one genre.
SELECT * FROM analytics
WHERE array_length(genres, 1) > 1;

-- FS4. Retrieve all apps that include "Education" as one of their genres.
SELECT * FROM analytics
WHERE genres @> ARRAY['Education'];
