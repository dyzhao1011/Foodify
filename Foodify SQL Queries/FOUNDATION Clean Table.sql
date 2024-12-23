/* 
	The below query deletes the following sample because they do not belong in any food groups.
*/

DELETE FROM dbo.foundationA
WHERE fdc_id IN (333008, 789828, 790508, 2346385, 2346386, 2346387, 2512378, 2512379);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes the following foundation food categories because they do not belong in any food group.
	
	*'Beverages': includes almond and oat milk which are not apart of the dairy group as per the USDA (https://www.myplate.gov/eat-healthy/dairy) and it is unclear which food group they belong to
*/

DELETE FROM dbo.foundationA
WHERE Category IN ('Beverages', 
				   'Fats and Oils', 
				   'Restaurant Foods', 
				   'Soups, Sauces, and Gravies', 
				   'Spices and Herbs', 
				   'Sweets');

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
	The below query deletes the raw ingredient flour because it does not belong in any food group and isn't consumed in its raw form.
*/

DELETE FROM dbo.foundationA
WHERE Food LIKE '%Flour%';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	The below query deletes any form of cooked and dried foods.
*/

DELETE FROM foundationA
WHERE fdc_id IN (SELECT fdc_id FROM foundationA
				WHERE Food LIKE '%cooked%'
				   OR Food LIKE '%canned%' 
				   OR Food LIKE '%roast%' 
				   OR Food LIKE '%dried%' 
				   OR Food LIKE '%Broiled%'
				   OR Food LIKE '%heated%'
				   OR Food LIKE '%hummus%')
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The following query duplicates certain foods that are categorized as 'Legumes and Legume Products' since the USDA categorizes this categorize as 'Protein Food' and 'Vegetable'
*/

INSERT INTO dbo.foundationA([fdc_id]
      ,[Food]
      ,[Category]
      ,[Calories (kCal)]
      ,[Total Fat (G)]
      ,[Saturated Fat (G)]
      ,[Trans Fat (G)]
      ,[Polyunsaturated Fat (G)]
      ,[Monosaturated Fat (G)]
      ,[Cholesterol (MG)]
      ,[Sodium (MG)]
      ,[Total Carbohydrate (G)]
      ,[Dietary Fiber (G)]
      ,[Total Sugars (G)]
      ,[Protein (G)]
      ,[Vitamin A (UG)]
      ,[Vitamin B-6 (MG)]
      ,[Vitamin B-12 (UG)]
      ,[Vitamin C (MG)]
      ,[Vitamin D (IU)]
      ,[Vitamin E (MG)]
      ,[Vitamin K (UG)]
      ,[Calcium (MG)]
      ,[Iron (MG)]
      ,[Potassium (MG)])
SELECT [fdc_id]
      ,[Food]
      ,'Protein Foods'
      ,[Calories (kCal)]
      ,[Total Fat (G)]
      ,[Saturated Fat (G)]
      ,[Trans Fat (G)]
      ,[Polyunsaturated Fat (G)]
      ,[Monosaturated Fat (G)]
      ,[Cholesterol (MG)]
      ,[Sodium (MG)]
      ,[Total Carbohydrate (G)]
      ,[Dietary Fiber (G)]
      ,[Total Sugars (G)]
      ,[Protein (G)]
      ,[Vitamin A (UG)]
      ,[Vitamin B-6 (MG)]
      ,[Vitamin B-12 (UG)]
      ,[Vitamin C (MG)]
      ,[Vitamin D (IU)]
      ,[Vitamin E (MG)]
      ,[Vitamin K (UG)]
      ,[Calcium (MG)]
      ,[Iron (MG)]
      ,[Potassium (MG)]
FROM dbo.foundationA
WHERE Category= 'Legumes and Legume Products' AND fdc_id NOT IN (1104705, 1104766, 2257044, 175033, 1999630, 2262072, 324860, 2515376);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	The following queries correctly recategorizes samples and aggregates the Foundations food categories into these 5 main food groups: Dairy, Fruits, Grains, Protein Foods, Vegetables
*/

UPDATE dbo.foundationA
SET Category = 'Protein Foods'
WHERE Category IN ('Beef Products', 
				   'Finfish and Shellfish Products', 
				   'Nut and Seed Products', 
				   'Pork Products', 
				   'Poultry Products', 
				   'Sausages and Luncheon Meats');

UPDATE dbo.foundationA
SET Category = 'Protein Foods'
WHERE fdc_id IN (2262072, 324860, 2515376);

UPDATE dbo.foundationA
SET Category = 'Protein Foods'
WHERE Food LIKE '%egg%' AND category='Dairy and Egg Products';

UPDATE dbo.foundationA
SET Category = 'Vegetables'
WHERE Category = 'Vegetables and Vegetable Products';

UPDATE dbo.foundationA
SET Category = 'Vegetables'
WHERE Category = 'Legumes and Legume Products';

UPDATE dbo.foundationA
SET Category = 'Dairy'
WHERE Category = 'Dairy and Egg Products';

UPDATE dbo.foundationA
SET Category = 'Dairy'
WHERE fdc_id IN (2257044, 1750337, 1999630);

UPDATE dbo.foundationA
SET Category = 'Fruits'
WHERE Category = 'Fruits and Fruit Juices';

UPDATE dbo.foundationA
SET Category = 'Grains'
WHERE fdc_id IN (2346396, 2346397, 2512380, 2512381, 335240, 325871);




