-- a. Who prefers energy drink more? (male/female/non-binary?)

SELECT Gender, COUNT(*) AS Total
FROM dim_respondents
GROUP BY Gender;

-- b. Which age group prefers energy drinks more?
SELECT Age_Group, COUNT(*) AS Total
FROM dim_respondents r
INNER JOIN fact_survey_responses s ON r.Respondent_ID = s.Respondent_ID
GROUP BY Age_Group;
-- Which type of marketing reaches the most Youth (15-30)? 
SELECT fsr.Marketing_channels, COUNT(*) AS Youth_Count
FROM fact_survey_responses fsr
JOIN dim_respondents dr ON fsr.Respondent_ID = dr.Respondent_ID
WHERE dr.Age_Group IN ('15-20', '21-30')
GROUP BY fsr.Marketing_channels
ORDER BY Youth_Count DESC
LIMIT 1;

-- a. What are the preferred ingredients of energy drinks among respondents?

SELECT Ingredients_expected, COUNT(*) AS Ingredient_Count
FROM fact_survey_responses
GROUP BY Ingredients_expected
ORDER BY Ingredient_Count DESC;

-- b. What packaging preferences do respondents have for energy drinks?
SELECT Packaging_preference, COUNT(*) AS Packaging_Count
FROM fact_survey_responses
GROUP BY Packaging_preference
ORDER BY Packaging_Count DESC;

-- a. Who are the current market leaders?
SELECT DISTINCT Current_brands
FROM fact_survey_responses;

-- b. What are the primary reasons consumers prefer those brands over ours?

SELECT Reasons_for_choosing_brands, COUNT(*) AS Reason_Count
FROM fact_survey_responses
WHERE Current_brands IN (SELECT DISTINCT Current_brands FROM fact_survey_responses)
GROUP BY Reasons_for_choosing_brands
ORDER BY Reason_Count DESC;

-- a. Which marketing channel can be used to reach more customers?

SELECT Marketing_channels, COUNT(*) AS Customer_Count
FROM fact_survey_responses
GROUP BY Marketing_channels
ORDER BY Customer_Count DESC
LIMIT 1;
-- b. How effective are different marketing strategies and channels in reaching our customers?
SELECT Marketing_channels, Brand_perception, COUNT(*) AS Perception_Count
FROM fact_survey_responses
GROUP BY Marketing_channels, Brand_perception;

-- a. What do people think about our brand? (overall rating)
SELECT AVG(Brand_perception) AS Overall_Rating
FROM fact_survey_responses;
-- b. Which cities do we need to focus more on?
SELECT c.City
FROM fact_survey_responses fsr
JOIN dim_cities c ON fsr.City_ID = c.City_ID
GROUP BY c.City
ORDER BY COUNT(*) DESC
LIMIT 5;

-- a. Where do respondents prefer to purchase energy drinks?
SELECT Purchase_location, COUNT(*) AS Preference_Count
FROM fact_survey_responses
GROUP BY Purchase_location
ORDER BY Preference_Count DESC;

-- b. What are the typical consumption situations for energy drinks among respondents?
SELECT Typical_consumption_situations, COUNT(*) AS Situation_Count
FROM fact_survey_responses
GROUP BY Typical_consumption_situations
ORDER BY Situation_Count DESC;

 -- c. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
 
 SELECT Price_range, Limited_edition_packaging, COUNT(*) AS Decision_Count
FROM fact_survey_responses
GROUP BY Price_range, Limited_edition_packaging;

-- a. Which area of business should we focus more on our product development?
-- (Branding/taste/availability)
SELECT
    CASE
        WHEN COUNT(*) = MAX(count) THEN 'Branding'
        WHEN COUNT(*) = MAX(count) THEN 'Taste'
        WHEN COUNT(*) = MAX(count) THEN 'Availability'
    END AS Focus_Area
FROM
    (
        SELECT
            Improvements_desired,
            COUNT(*) AS count
        FROM
            fact_survey_responses
        WHERE
            Improvements_desired IN ('Branding', 'Taste', 'Availability')
        GROUP BY
            Improvements_desired
    ) AS subquery;

 
 
 
 
 
 
 