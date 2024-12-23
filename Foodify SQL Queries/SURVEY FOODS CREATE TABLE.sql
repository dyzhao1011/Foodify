/*
	This query returns every survey foods ordered in a manner such that each row is a survey food with columns containing fdc_id, food name, category, and nutrient amounts.

	There are 2 tables in this query:
	1) PRELIM_TABLE: PIVOT query is used on this table to convert the 'nutrient' column, in the subqery, into columns only for the specified nutrients selected below.
	2) MAIN_TABLE: the final table and is the result of the PIVOT query

	This query assumes that the 'survey' table is non existent.

	NOTE: The data needs to be cleaned futhered by:
	1) Removing foods that are not apart of the 5 main food groups
	2) Removing duplicates for some food (Duplicates have different fdc_ids but same nutrient info)
	3) Removing "cooked" food 

	NOTE 2: Survey foods have no data collected on Trans Fat (G)
*/

SELECT fdc_id,
	   food,
	   category,
	   SUM([Energy (KCAL)]) AS 'Calories (kCal)', 	
	   SUM([Total lipid (fat) (G)]) AS 'Total Fat (G)',
	   SUM([Fatty acids, total saturated (G)]) AS 'Saturated Fat (G)',
	   SUM([Fatty acids, total trans (G)]) AS 'Trans Fat (G)',
	   SUM([Fatty acids, total polyunsaturated (G)]) AS 'Polyunsaturated Fat (G)',
	   SUM([Fatty acids, total monounsaturated (G)]) AS 'Monosaturated Fat (G)',
	   SUM([Cholesterol (MG)]) AS 'Cholesterol (MG)',
	   SUM([Sodium, Na (MG)]) AS 'Sodium (MG)',
	   SUM([Carbohydrate, by difference (G)]) AS 'Total Carbohydrate (G)',
	   SUM([Fiber, total dietary (G)]) AS 'Dietary Fiber (G)',
	   SUM([Sugars, Total (G)]) AS 'Total Sugars (G)',
	   SUM([Protein (G)]) AS 'Protein (G)',
	   SUM([Vitamin A, RAE (UG)]) AS 'Vitamin A (UG)',
	   SUM([Vitamin B-6 (MG)]) AS 'Vitamin B-6 (MG)',
	   SUM([Vitamin B-12 (UG)]) AS 'Vitamin B-12 (UG)',
	   SUM([Vitamin C, total ascorbic acid (MG)]) AS 'Vitamin C (MG)',
	   SUM([Vitamin D (D2 + D3), International Units (IU)]) AS 'Vitamin D (IU)',
	   SUM([Vitamin E (alpha-tocopherol) (MG)]) AS 'Vitamin E (MG)',
	   SUM([Vitamin K (phylloquinone) (UG)]) AS 'Vitamin K (UG)', 
	   SUM([Calcium, Ca (MG)]) AS 'Calcium (MG)',
	   SUM([Iron, Fe (MG)]) AS 'Iron (MG)',
	   SUM([Potassium, K (MG)]) AS 'Potassium (MG)'
FROM (
	SELECT F.fdc_id,
		   F.description AS food,
		   WFC.wweia_food_category_description AS category,
		   CONCAT(N.name, ' (', N.unit_name, ')') AS nutrient,
		   FN.amount
	FROM survey.food AS F
	LEFT JOIN survey.food_nutrient AS FN -- Join to get nutrient id and amount
		ON F.fdc_id = FN.fdc_id
	LEFT JOIN survey.survey_fndds_food AS SFF -- Join to get food category number
		ON F.fdc_id = SFF.fdc_id
	LEFT JOIN survey.wweia_food_category AS WFC -- Join to get food category name
		ON SFF.wweia_category_number = WFC.wweia_food_category
	LEFT JOIN survey.nutrient AS N -- Join to get nutrient name
		ON FN.nutrient_id = N.nutrient_nbr
) AS PRELIM_TABLE
PIVOT ( 
	SUM(amount) 
	FOR nutrient IN ([Energy (KCAL)],
					 [Total lipid (fat) (G)],
					 [Fatty acids, total saturated (G)],
					 [Fatty acids, total trans (G)],
					 [Fatty acids, total polyunsaturated (G)],
					 [Fatty acids, total monounsaturated (G)],
					 [Cholesterol (MG)],
					 [Sodium, Na (MG)],
					 [Carbohydrate, by difference (G)],
					 [Fiber, total dietary (G)],
					 [Sugars, Total (G)],
					 [Protein (G)],
					 [Vitamin A, RAE (UG)],
					 [Vitamin B-6 (MG)],
					 [Vitamin B-12 (UG)],
					 [Vitamin C, total ascorbic acid (MG)],
					 [Vitamin D (D2 + D3), International Units (IU)],
					 [Vitamin E (alpha-tocopherol) (MG)],
					 [Vitamin K (phylloquinone) (UG)], 
					 [Calcium, Ca (MG)],
					 [Iron, Fe (MG)],
					 [Potassium, K (MG)])
) AS MAIN_TABLE
GROUP BY fdc_id, food, category
