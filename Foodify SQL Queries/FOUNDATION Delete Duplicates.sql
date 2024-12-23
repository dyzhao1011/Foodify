/*
	This query drops duplicate samples that have the least amount of nutritional information for each food. All samples have different fdc_ids but may be duplicate. Duplicate samples follows one of the follow criterias:
	1) 2 or more samples have the same nutrient values
	2) 2 or more samples have very similar nutrient values
	3) 2 or more samples have the same/similar values for some nutrients, but 1 has null for a nutrient while another has a value

*/

DELETE 
FROM dbo.foundationA
WHERE fdc_id IN (
	SELECT fdc_id
	FROM (
		SELECT *,
			   ROW_NUMBER() OVER (PARTITION BY Food, category ORDER BY 
			   CASE WHEN [Calories (kCal)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Total Fat (G)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Saturated Fat (G)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Trans Fat (G)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Cholesterol (MG)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Sodium (MG)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Total Carbohydrate (G)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Dietary Fiber (G)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Total Sugars (G)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Protein (G)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Vitamin D (IU)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Calcium (MG)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Iron (MG)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			   CASE WHEN [Potassium (MG)] IS NOT NULL THEN 1 ELSE 0 END DESC,
			  [Potassium (MG)] DESC) AS RN
		FROM dbo.foundationA ) as Ranked_Rows
	WHERE RN > 1
)
