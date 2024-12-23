/*
	This query compares duplicates
*/

SELECT A.fdc_id, A.food, A.category, A.[Calories (kCal)], A.[Dietary Fiber (G)], B.fdc_id, B.food, B.category, B.[Calories (kCal)], B.[Dietary Fiber (G)]
FROM foundationA AS A, foundationA AS B
WHERE A.fdc_id <> B.fdc_id AND A.food = B.food AND A.Category = B.Category