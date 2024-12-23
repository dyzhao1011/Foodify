SELECT MAIN_TABLE.fdc_id, 
	   food AS Food, 
	   category AS Category,
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

INTO sr_legacy -- Create new table to store the results from this query
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
	FROM SR_LEGACY.food AS F
	JOIN SR_LEGACY.food_nutrient AS FN
		ON F.fdc_id=FN.fdc_id
	JOIN SR_LEGACY.food_category as FC
		ON F.food_category_id=FC.id
	JOIN SR_LEGACY.nutrient AS N
		ON FN.nutrient_id=N.id	
	


) AS PRELIM_TABLE
PIVOT ( 
	SUM(amount) -- This aggregate function serves no purpose other than to be a placeholder for the syntax. There are no duplicate nutrients for the same fdc_id --
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
GROUP BY MAIN_TABLE.fdc_id, food, category