/*
	This query returns every samples from the foundations dataset ordered in a manner such that each row is a unique sample with columns containing information, such as food
	name, category, and nutrient amounts. 

	There are 3 tables in this query:
	1) PRELIM_TABLE: PIVOT query is used on this table to convert the 'nutrient' rows in the subqery into columns only for the specified nutrients selected below.
	2) MAIN_TABLE: result of the PIVOT query
	3) CALORIE_CONVERSION_TABLE: used to calculate and generate the 'Calories (Calculated)' column because some rows have missing 'Calories'

	This query assumes that the 'foundation' table is non existent.

	NOTE: The data needs to be cleaned futhered by:
	1) Removing foods that are not apart of the 5 main food groups
	2) Removing duplicates for some food (Duplicates have different fdc_ids but same nutrient info)
	3) Removing "cooked" food 
	4) Recategorizing foods into the right food group


*/
SELECT MAIN_TABLE.fdc_id, 
	   food AS Food, 
	   category AS Category,
	   COALESCE(SUM([Energy (Atwater Specific Factors) (KCAL)]),
				SUM([Carbohydrate, by difference (G)] * [carbohydrate_value] + [Total lipid (fat) (G)] * [fat_value] + [Protein (G)] * [protein_value]),
				NULL) AS 'Calories (kCal)', 
	   -- This query will use one of these calories starting in this order: atwater general factors, calories calculated from conversion factors, or null --
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

INTO foundation -- Create new table to store the results from this query
FROM (
	/*
		The below subquery returns the fdc_id, food, category, nutrient, and amount as a row.
		There are multiple rows with the same fdc_id corresponding to a different nutrient.
	*/
	SELECT F.fdc_id, 
		   F.description AS food, 
		   FC.description AS category, 
		   CONCAT(N.name, ' (', N.unit_name, ')') AS nutrient, 
		   FN.amount
	FROM foundation.food AS F 
	LEFT JOIN foundation.food_nutrient AS FN -- Join to get nutrient id and amount
		ON F.fdc_id=FN.fdc_id 
	LEFT JOIN foundation.food_category AS FC -- Join to get food category
		ON F.food_category_id=FC.id 
	LEFT JOIN foundation.nutrient AS N -- Join to get nutrient name
		ON FN.nutrient_id=N.id 
	WHERE data_type = 'foundation_food' -- Filter to get only foundation_food

) AS PRELIM_TABLE
PIVOT ( 
	SUM(amount) -- This aggregate function serves no purpose other than to be a placeholder for the syntax. There are no duplicate nutrients for the same fdc_id --
	FOR nutrient IN ([Energy (Atwater Specific Factors) (KCAL)],
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
LEFT JOIN (
/*
	The below subquery returns a table containing the fdc_id, and calorie conversion factors needed to calculate calories atwater specific factors.
*/
SELECT FNCF.fdc_id, 
	   FCCF.carbohydrate_value, 
	   FCCF.fat_value, 
	   FCCF.protein_value	
FROM foundation.food_calorie_conversion_factor AS FCCF
LEFT JOIN foundation.food_nutrient_conversion_factor AS FNCF
	ON FCCF.food_nutrient_conversion_factor_id=FNCF.id) AS CALORIE_CONVERSION_TABLE

	ON MAIN_TABLE.fdc_id=CALORIE_CONVERSION_TABLE.fdc_id

GROUP BY MAIN_TABLE.fdc_id, food, category




