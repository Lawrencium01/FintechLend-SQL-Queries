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


