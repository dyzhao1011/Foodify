/*
	NOTES:
	1) American Indian/Alaska Native Foods: contains foods belonging to various categories and contains foods that don't belong in any categories
	2) Baked Products: almost all are apart of grains food groups
	3) Beverages: contains a handful of milk and fruit juices. Need to filter out most which are alcholoic drinks
	4) Breakfast cereals are part of the grain
	5) Cereal Grains and Pasta: need to filter out flour
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes the following foundation food categories because they do not belong in any food group.
*/

DELETE FROM dbo.sr_legacyA
WHERE Category IN ('Baby Foods', 'Beverages','Fast Foods', 'Fats and Oils', 'Meals, Entrees, and Side Dishes', 'Restaurant Foods', 'Snacks', 'Soups, Sauces, and Gravies', 'Spices and Herbs', 'Sweets');

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes samples that does not belong in any food group.
	1) Pork fat
	2) Beef fat
	3) Lamb, Veal, and Game fat
	4) Poultry Skin
	5) Egg Substitute
	6) Eggnog
	7) Coconut water
	8) Soy sauce
	9) Soy protein
	10) Creamer
	11) Falafel
	12) Hummus
	13) Soy meal
	14) Yokan
*/

DELETE FROM dbo.sr_legacyA
WHERE fdc_id IN (167811, 167813, 169179, 168605, 167861, 170193, 171728, 171729, 171730, 171731, 173083, 173091, 173967, 173968, 172572, 172657, 172511, 173849,
				 174309, 174434, 174435, 174882, 174884, 174892, 171482, 172855, 172866, 172873, 174502, 171258, 173429, 173462, 170174, 172473, 172474, 174277, 
				 175266, 174278, 174279, 174301, 174302, 173782, 175231, 175232, 175231, 175232, 172455, 174289, 172454, 172445, 173730);
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes the raw ingredient flour because it does not belong in any food group and isn't consumed in its raw form.
*/

DELETE FROM dbo.sr_legacyA
WHERE Food LIKE '%flour%' AND Category IN ('Legumes and Legume Products', 'Cereal Grains and Pasta', 'Nut and Seed Products')

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes any grain-based deserts as defined by the USDA
*/

DELETE FROM dbo.sr_legacyA
WHERE Category = 'Baked Products' AND (Food LIKE '%cookie%' 
									OR Food LIKE '%cake, %' 
									OR Food LIKE '%pie, %' 
								    OR Food LIKE '%cream%' 
								    OR Food LIKE '%doughnuts%' 
									OR Food LIKE '%pastr%' 
									OR Food LIKE '%leavening%' 
									OR Food LIKE '%roll%' 
									OR Food LIKE '%sweet%' 
									OR Food LIKE '%graham%'
									OR Food LIKE '%dry%'
									OR fdc_id IN (175078, 167940, 168002, 168003, 167922,175079));

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes any non grain breakfast cereals as defined by the USDA
*/

DELETE FROM dbo.sr_legacyA
WHERE Category = 'Breakfast Cereals' AND [Total Sugars (G)] >= 21.2;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes non-dairy foods in the Dairy and Egg Products category as defined by the USDA
*/

DELETE FROM dbo.sr_legacyA
WHERE Category = 'Dairy and Egg Products' AND (Food LIKE '%butter,%' 
											OR Food LIKE '%cream%'
											OR Food LIKE '%whip%' 
											OR Food LIKE '%dessert%'
											OR Food LIKE '%supple%' 
											OR Food LIKE '%beverage%'
											OR fdc_id IN (170885, 171272, 171273, 171282, 171302, 173454, 173461, 173412));

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The below query deletes any form of cooked and dried foods.
*/
DELETE FROM sr_legacyA
WHERE fdc_id IN (SELECT fdc_id FROM sr_legacyA
				WHERE Food LIKE '% cooked%' 
				   OR Food LIKE '%canned%' 
				   OR Food LIKE '%roast%' 
				   OR Food LIKE '%dried%' 
				   OR Food LIKE '%broil%' 
				   OR Food LIKE '%dehydrated%' 
				   OR Food LIKE '%boil%' 
				   OR Food LIKE '%cured%' 
				   OR Food LIKE '%microwave%'
				   OR Food LIKE '%smoked%'
				   OR Food LIKE '%fried%'
				   OR Food LIKE '%heated%'
				   OR Food LIKE '%glazed%'
				   OR Food LIKE '%scrambled%'
				   OR Food LIKE '%pickled%'
				   OR Food LIKE '%rotisserie%'
				   OR Food LIKE '% diluted%'
				   OR Food LIKE '%smoothie%'
				   OR (Food LIKE '%baked%' AND Category = 'Fruits and Fruit Juices')
				   OR (Food LIKE '%toasted%' AND Category = 'Nut and Seed Products')
				   OR (Food LIKE '%prepared%' AND Category = 'Breakfast Cereals'));

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The following query duplicates certain foods that are categorized as 'Legumes and Legume Products' since the USDA categorizes this categorize as 'Protein Food' and 'Vegetable'
*/

INSERT INTO dbo.sr_legacyA([fdc_id]
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
FROM dbo.sr_legacyA
WHERE Category= 'Legumes and Legume Products' AND (Food LIKE '%tofu%' OR Food LIKE '%peanut%' OR Food LIKE '%meatless%') AND fdc_id NOT IN (174268, 172447, 174276, 174287, 172423, 169068, 169888,  174283,174281);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	The following queries correctly recategorizes samples and aggregates the SR_legacy food categories into these 5 main food groups: Dairy, Fruits, Grains, Protein Foods, Vegetables
*/

UPDATE dbo.sr_legacyA
SET Category = 'Protein Foods'
WHERE Category IN ('Beef Products', 
				   'Finfish and Shellfish Products', 
				   'Lamb, Veal, and Game Products',
				   'Nut and Seed Products', 
				   'Pork Products', 
				   'Poultry Products', 
				   'Sausages and Luncheon Meats');
UPDATE dbo.sr_legacyA
SET Category = 'Protein Foods'
WHERE Category = 'Legumes and Legume Products' AND (Food LIKE '%tofu%' OR Food LIKE '%peanut%' OR Food LIKE '%meatless%' OR fdc_id IN (174287, 172423, 169068, 169888,  174283,174281));

UPDATE dbo.sr_legacyA
SET Category = 'Protein Foods'
WHERE Food LIKE '%egg%' AND category = 'Dairy and Egg Products';


UPDATE dbo.sr_legacyA
SET Category = 'Dairy'
WHERE Category = 'Legumes and Legume Products' AND (Food LIKE '%unfortified%' OR Food LIKE '%soymilk%' OR Food LIKE '%soy yogurt%');

UPDATE dbo.sr_legacyA
SET Category = 'Dairy'
WHERE Category = 'Dairy and Egg Products';

UPDATE dbo.sr_legacyA
SET Category = 'Vegetables'
WHERE Category = 'Legumes and Legume Products';

UPDATE dbo.sr_legacyA
SET Category = 'Vegetables'
WHERE Category = 'Vegetables and Vegetable Products';

UPDATE dbo.sr_legacyA
SET Category = 'Grains'
WHERE Category = 'Baked Products';

UPDATE dbo.sr_legacyA
SET Category = 'Grains'
WHERE Category = 'Cereal Grains and Pasta' AND (Food LIKE '%noodles%'
											 OR Food LIKE '%pasta%'
											 OR Food LIKE '%rice%'
											 OR Food LIKE '%quinoa%'
											 OR Food LIKE '%spaghetti%');
UPDATE dbo.sr_legacyA
SET Category = 'Grains'
WHERE Category = 'Breakfast Cereals';

DELETE FROM dbo.sr_legacyA
WHERE Category = 'Cereal Grains and Pasta';

UPDATE dbo.sr_legacyA
SET Category = 'Fruits'
WHERE Category = 'Fruits and Fruit Juices';

/*
	The following queries correctly recategorizes the 'American Indian/Alaska Native Foods' foods into the 5 main food groups
*/

UPDATE dbo.sr_legacyA
SET Category = 'Protein Foods'
WHERE fdc_id IN (169793, 169794, 168050, 168983, 168985, 169803, 167622, 167617, 168056, 168033, 167616, 167647, 167646, 168045, 168023, 167648, 168034, 167626,
				 167643, 168047, 167639, 168046, 168021, 169809, 169810, 169806, 168989, 167638, 168987, 169798, 169827, 167607, 168019, 167612, 167613, 167618, 
				 169002, 169001, 169000, 169003, 169824, 168053, 167610, 168026, 168025, 167619, 168031, 168030, 168029, 169796, 168979, 168980, 169797);

UPDATE dbo.sr_legacyA
SET Category = 'Fruits'
WHERE fdc_id IN (168982, 169799, 167640, 168999, 168058, 169802, 169804, 169805, 167629, 169820, 169816, 168997, 168048);

UPDATE dbo.sr_legacyA
SET Category = 'Grains'
WHERE fdc_id IN (169830, 167633, 169004, 169811, 169829, 168041);

UPDATE dbo.sr_legacyA
SET Category = 'Vegetables'
WHERE fdc_id IN (168037, 167608, 168995, 168022, 168040, 169819);

DELETE FROM dbo.sr_legacyA
WHERE Category = 'American Indian/Alaska Native Foods';
