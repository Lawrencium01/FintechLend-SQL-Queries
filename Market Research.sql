--Segement by digital preference
SELECT 
	segment, AVG(digital_preference) 'digital preference'
FROM ['Market Research$']
GROUP BY segment
ORDER BY [digital preference] DESC

--
SELECT 
	income_level,segment, COUNT(income_level) 'count'
FROM ['Market Research$']
GROUP BY income_level,segment
ORDER BY 1,3 DESC;

--Count of segment by product interest
SELECT 
	segment,product_interest,COUNT(segment)  'Count'
FROM ['Market Research$']
GROUP BY segment,product_interest
ORDER BY 2,3 DESC

--1.
SELECT 
	age_group, AVG(price_sensitivity) 'Price Sensitivity'
FROM ['Market Research$']
GROUP BY age_group
ORDER BY [Price Sensitivity] DESC


--2. Customer segment by product interest and brand importance
WITH RankedData AS (
	SELECT 
		segment,product_interest, AVG(brand_importance) 'brand importance',
		RANK() OVER  (PARTITION BY segment ORDER BY AVG(brand_importance) DESC) AS rank_order
	FROM ['Market Research$']
	GROUP BY segment, product_interest
)
SELECT segment, product_interest, "brand importance"
FROM RankedData
WHERE rank_order = 1


--Age group by product interest and brand importance
SELECT 
	age_group, product_interest,AVG(brand_importance) 'brand importance'
FROM ['Market Research$']
GROUP BY age_group, product_interest
ORDER BY 1,3 DESC


--Customer segment by product interest and service importance
SELECT 
	segment,product_interest, AVG(service_importance) 'service importance'
FROM ['Market Research$']
GROUP BY segment, product_interest
ORDER BY 1,3 DESC


--Customer segment by service importance
SELECT 
	segment,AVG(service_importance) 'service importance'
FROM ['Market Research$']
GROUP BY segment
ORDER BY [service importance] DESC


--3. Top considered competitor by segment
WITH RankedData AS (
	SELECT 
		segment,competitor_consideration,COUNT(competitor_consideration) 'Count',
		RANK() OVER  (PARTITION BY segment ORDER BY COUNT(competitor_consideration) DESC) AS rank_order
	FROM ['Market Research$']
	GROUP BY segment,competitor_consideration
)
SELECT segment, competitor_consideration, "count"
FROM RankedData
WHERE rank_order = 1



SELECT * FROM ['Market Research$']


