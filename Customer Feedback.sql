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
