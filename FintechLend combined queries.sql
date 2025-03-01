--BUSINESS PERFORMANCE

SELECT * FROM ['Business Performance$']

--1.
SELECT channel, SUM(revenue) Total_Revenue
FROM ['Business Performance$']
GROUP BY channel
ORDER BY Total_Revenue DESC

--Distinct Channels
SELECT DISTINCT(channel)
FROM ['Business Performance$']

--Total Revenue by channel
SELECT 
	channel, SUM(revenue) 'Total Revenue' 
FROM ['Business Performance$']
GROUP BY channel

--Total Application Volume by product and channel
SELECT product, channel, SUM(application_volume) Total_application_volume
FROM ['Business Performance$']
GROUP BY product, channel
ORDER BY 1,3 DESC


--2.
SELECT 
    FORMAT(date, 'MMMM yyyy') AS month_year,  
    SUM(application_volume) AS [Total Application Volume]
FROM ['Business Performance$']
GROUP BY FORMAT([date], 'MMMM yyyy'), YEAR([date]), MONTH([date])
ORDER BY YEAR([date]), MONTH([date]);


-- Conversion Rate by channel
SELECT 
	channel, AVG(conversion_rate) 'Average conversion rate' 
FROM ['Business Performance$']
GROUP BY channel
ORDER BY [Average conversion rate] DESC


-- Acquisition cost by product and channel
SELECT 
	product,channel, AVG(acquisition_cost) 'Average acquisition cost'
FROM ['Business Performance$']
GROUP BY product,channel
ORDER BY 1, 3 DESC


--5.
WITH RankedData AS (
    SELECT 
        product,
        channel,
        AVG(acquisition_cost) AS "Average acquisition cost",
        RANK() OVER  (PARTITION BY product ORDER BY AVG(acquisition_cost) DESC) AS rank_order
    FROM ['Business Performance$']
    GROUP BY product, channel
)
SELECT product, channel, "Average acquisition cost"
FROM RankedData
WHERE rank_order = 1


-- Margin by product and channel
SELECT 
	product, channel, AVG(margin) 'Average Margin'
FROM ['Business Performance$']
GROUP BY product, channel
ORDER BY 1,3 DESC


--3. Trend Analysis of conersion rate (combo/line chart)
SELECT 
    FORMAT(date, 'MMMM yyyy') AS month_year,  
    AVG(conversion_rate) AS 'Average conversion rate'
FROM ['Business Performance$']
GROUP BY FORMAT([date], 'MMMM yyyy'), YEAR([date]), MONTH([date])
ORDER BY YEAR([date]), MONTH([date]);


--Trend Analysis of margin (line chart)
SELECT 
    FORMAT(date, 'MMMM yyyy') AS month_year,  
    AVG(margin) AS 'Average margin'
FROM ['Business Performance$']
GROUP BY FORMAT([date], 'MMMM yyyy'), YEAR([date]), MONTH([date])
ORDER BY YEAR([date]), MONTH([date]);


--Trend Analysis of Revenue
SELECT 
    FORMAT(date, 'MMMM yyyy') AS month_year,  
    SUM(revenue) AS 'Total Revenue'
FROM ['Business Performance$']
GROUP BY FORMAT([date], 'MMMM yyyy'), YEAR([date]), MONTH([date])
ORDER BY YEAR([date]), MONTH([date]);


--Trend Analysis of Revenue and average conversion rate.
SELECT 
    FORMAT(date, 'MMMM yyyy') AS month_year,  
    SUM(revenue) AS 'Total Revenue', AVG(conversion_rate) 'Average Conversion rate'
FROM ['Business Performance$']
GROUP BY FORMAT([date], 'MMMM yyyy'), YEAR([date]), MONTH([date])
ORDER BY YEAR([date]), MONTH([date]);


--4. Total Revenue
SELECT 
	SUM(revenue) 'Total Revenue'
FROM ['Business Performance$']



--MARKET RESEARCH


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




--MARKET DATA


SELECT * FROM ['Market Data$']

-- Trend of the market size and competitor revenue by product & competitor
SELECT 
	FORMAT(date, 'MMMM yyyy') AS month_year,
	product, competitor, SUM(market_size) 'Total Market Size', SUM(competitor_revenue) 'Total Competitor Revenue'
FROM ['Market Data$']
GROUP BY FORMAT([date], 'MMMM yyyy'), YEAR([date]), MONTH([date]),product,competitor
ORDER BY YEAR([date]), MONTH([date])

--2. Average competitor share by competitor
SELECT
	competitor, AVG(competitor_share) 'Average Competitor share'
FROM ['Market Data$']
GROUP BY competitor
ORDER BY [Average Competitor share] DESC


--3.
SELECT 
	competitor, AVG(digital_maturity) 'Digital maturity', AVG(customer_satisfaction) 'Customer satisfaction',
	AVG(competitor_share) 'Market Share'
FROM ['Market Data$']
GROUP BY competitor
ORDER BY 2 DESC


--4. Total Revenue by competitor
SELECT 
	competitor, SUM(competitor_revenue) 'Total Revenue'
FROM ['Market Data$']
GROUP BY competitor
ORDER BY [Total Revenue] DESC




--CUSTOMER FEEDBACK

SELECT * FROM ['Customer Feedback$']

SELECT 
	product, customer_segment,AVG(nps_score) 'Average nps score'
FROM ['Customer Feedback$']
GROUP BY product, customer_segment
ORDER BY 1;

--1.
WITH nps_category as (
	SELECT 
		*,
		CASE
			WHEN nps_score <= 40 THEN 'Detractors'
			WHEN nps_score > 40 AND nps_score <= 69 THEN 'Passive'
			ELSE 'Promoter' 
		END 'nps category'
	FROM ['Customer Feedback$']
)
SELECT 
	[nps category],COUNT([nps category]) 'Count per nps category'
FROM nps_category
GROUP BY [nps category]


--2.
WITH satisfaction_category as (
	SELECT  
		*,
		CASE
			WHEN satisfaction_score <= 1 THEN 'Very Dissatisfied'
			WHEN satisfaction_score > 1 AND satisfaction_score <=2 THEN 'Dissatisfied'
			WHEN satisfaction_score > 2 AND satisfaction_score <=3 THEN 'Neutral'
			WHEN satisfaction_score > 3 AND satisfaction_score <=4 THEN 'Satisfied'
			ELSE 'Very Satisfied'
		END 'Satisfaction_score_category'
	FROM ['Customer Feedback$']
)
SELECT 
	Satisfaction_score_category, COUNT(Satisfaction_score_category) 'count per satisfaction category'
FROM satisfaction_category
GROUP BY Satisfaction_score_category


WITH satisfaction_customers as (
	SELECT 
		*,
		CASE
			WHEN satisfaction_score <= 1 THEN 'Very Dissatisfied'
			WHEN satisfaction_score > 1 AND satisfaction_score <=2 THEN 'Dissatisfied'
			WHEN satisfaction_score > 2 AND satisfaction_score <=3 THEN 'Neutral'
			WHEN satisfaction_score > 3 AND satisfaction_score <=4 THEN 'Satisfied'
			ELSE 'Very Satisfied'
		END 'Satisfaction_score_category'
	FROM ['Customer Feedback$']
)
SELECT 
	product, customer_segment, Satisfaction_score_category, COUNT(Satisfaction_score_category) 'Satisfaction category by product & customer segment'
FROM satisfaction_customers
GROUP BY product, customer_segment,Satisfaction_score_category
ORDER BY 1;


--3.
SELECT 
    FORMAT(date, 'MMMM yyyy') AS month_year,product,  
    SUM(feedback_volume) AS 'Total Feedback Volume'
FROM ['Customer Feedback$']
GROUP BY FORMAT([date], 'MMMM yyyy'), YEAR([date]), MONTH([date]), product
ORDER BY YEAR([date]), MONTH([date]);


