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


