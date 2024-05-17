from flask import Flask, request, jsonify
from flask_cors import CORS
import pandas as pd
import requests
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
import numpy as np
import json


app = Flask(__name__)
CORS(app)

attributes = ["Fruit", 
              "Energy", #957
              "Total lipid (fat)", #204
              "Fatty acids, total saturated", #606
              "Fatty acids, total trans",
              "Fatty acids, total polyunsaturated", #646
              "Fatty acids, total monounsaturated", #645
              "Sodium, Na", #307
              "Carbohydrate, by difference", #205
              "Fiber, total dietary", #291
              "Total Sugars", #269
              "Protein", #203
              "Vitamin A, RAE", #320
              "Vitamin B-6", #415
              "Vitamin C, total ascorbic acid", #571 
              "Vitamin D (D2 + D3), International Units",
              "Vitamin E (alpha-tocopherol)", #323
              "Vitamin K (phylloquinone)", #430
              "Calcium, Ca", #301
              "Iron, Fe", #303
              "Potassium, K", #306
             ]
typeOfFruit = ['Multiple', #Abiyuch
        'Drupe', #Acerola
        'Pome', #Apple (Fuji)
        'Pome', #Apple (Gala)
        'Pome', #Apple (Red Delicious)
        'Drupe', #Apricots
        'Berry', #Avocados (California)
        'Berry', #Avocados (Florida)
        'Berry', #Bananas 
        'Aggregate', #Blackberries
        'Berry', #BlueBerry
        'Aggregate', #BoysenBerries
        'Multiple', #Breadfruit
        'Aggregate', #Cherimoya
        'Drupe', #Cherries
        'Citrus', #Clementines
        'Aggregate', #CloudBerry
        'Pome', #Crabapple
        'Berry',  #Cranberries
        'Berry', #Currant (European)
        'Berry', #Currant (Red and White)
        'Drupe', #Durian
        'Berry', #ElderBerry
        'Berry', #Feijoa
        'Multiple', #Fig
        'Berry', #GooseBerry
        'Berry', #Grapes
        'Citrus', #Grapefruit (white)
        'Citrus', #Grapefruit (red)
        'Berry', #Groundcherry
        'Berry', #Guava (Common)
        'Berry', #Guava (Strawberry)
        'Multiple', #Jackfruit
        'Drupe', #Java plum
        'Drupe', #Jujube
        'Melon', #Horned Melon
        'Berry', #Kiwifruit (Green)
        'Berry', #Kiwifruit (ZESPRI)
        'Citrus', #kumquats
        'Citrus', #Lemons
        'Citrus', #Limes
        'Aggregate', #Loganberry
        'Drupe', #Longangs
        'Pome', #Loquat
        'Drupe', #Lychee
        'Drupe', #Mango
        'Melon', # Melon (Cantolouope)
        'Melon', # Melon (Casaba)
        'Melon', # Melon (Honeydew)
        'Melon', # Melon (Watermelon)
        'Multiple', #MulBerry
        'Drupe', #Nance
        'Drupe', #Nectarines
        'Berry', #Oheloberry
        'Citrus', #Oranges (California)
        'Citrus', #Oranges (Florida)
        'Citrus', #Oranges (Navel)
        'Citrus', #Tangerines
        'Berry', #Papayas
        'Melon', #Passionfruit (Grandilla)
        'Drupe', #Peaches
        'Pome', #Pear
        'Pome', #Pear (Red Anjou)
        'Pome', #Pear (Bartlett)
        'Pome', #Pear (Bosc)
        'Pome', #Pear (Green Anjou)
        'Pome', #Pear (Asian)
        'Drupe', #Pear (Prickly)
        'Berry', #Persimmons (Japanese)
        'Berry', #Persimmons (Native)
        'Berry', #Plantains (Green)
        'Berry', #Plantains (Yellow)
        'Drupe', #Plum
        'Multiple', #Pineapple
        'Berry', #Pomegrantes
        'Citrus', #Pummelo
        'Pome', #Quince
        'Aggregate', #Raspberry
        'Berry', #Rose Apple
        'Multiple', #Roselle
        'Drupe', #Rowal
        'Berry', #Sapodilla
        'Berry', #Sapote
        'Aggregate', #Soursop
        'Aggregate', #Strawberry
        'Aggregate', #Sugar Apple
        'Berry', #Pitanga
        ]
def builtFruitInfo(fruitJson):
    fruitList = []
    for fruit in fruitJson:
        fruitDict = {}
        fruitDict["Fruit"] = fruit.get("description")
        for nutrient in fruit.get("foodNutrients"):
            fruitDict[nutrient.get("nutrient").get("name")] = nutrient.get("amount")
        fruitList.append(fruitDict)
    return fruitList

def loadFruitJson():
    with open('fruits.json', 'r') as fruits_json:
        data = json.load(fruits_json)
    return data

fruitsJson = loadFruitJson()
fruitList = builtFruitInfo(fruitsJson)

# Modify the dataframe
fruitDF = pd.DataFrame(fruitList)
fruitDF = fruitDF[attributes]
fruitDF["Energy"] = (fruitDF["Energy"] / 4.184).round()
fruitDF.drop("Fruit", axis= 1, inplace= True)
fruitDF.drop("Fatty acids, total trans", axis=1, inplace=True)
fruitDF.drop("Vitamin D (D2 + D3), International Units", axis=1, inplace=True)
fruitDF['Type'] = typeOfFruit

fruit_groups = fruitDF.groupby('Type')
# Replace NaN with averages
for col in fruitDF.columns:
    if col != 'Type':  # Skip 'Class' column
        for fruit_type, group in fruit_groups:
            avg = fruit_groups.mean().loc[fruit_type, col]
            fruitDF.loc[group.index, col] = group[col].fillna(avg)

# Data for training 
X = fruitDF.iloc[:, [14 ,13 , 9 , 4, 12,  2, 16, 8 , 3 ,11, 15,  6 ,17, 10,  7,  0 , 5]]
LE = LabelEncoder()
Y_encoded = LE.fit_transform(fruitDF.iloc[:,18])    

print(X.columns)

# Model (Random Forest)
rf_classifier = RandomForestClassifier(criterion='entropy', max_depth=5, max_features='log2',
                    n_estimators=175, random_state=11)

# Train the model
rf_classifier.fit(X, Y_encoded)


@app.route('/fruitify', methods=['POST'])
def frutify():
    data = request.get_json()
    # Convert values from strings to numbers
    for key, value in data.items():
        data[key] = float(value)
    
    
    # Predict the category of fruit using the model
    mDict = {key : [value] for key, value in data.items()}
    mDataFrame = pd.DataFrame(mDict)
    prediction = rf_classifier.predict(mDataFrame)
    predictedFruitType = LE.inverse_transform(prediction)
    

    return jsonify({'type': predictedFruitType[0]})


if __name__ == '__main__':
    app.run(debug = True)