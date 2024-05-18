# Fruitfy
## Summary
Fruits have similar chemical composition with unique amounts of macro and micro nutrients. They can be classified into 7 different categories of fruits that are distinctive in the numerical values of some nutrients. This project aims to develop a machine learning model to classify fruits based on their chemical composition that will be used to create a dietary tool where users can find a type of fruit that fits their best needs.

<details>
  <summary>Introduction</summary>
  There are many types of fruits and each one has a unique chemical composition of different macro and micro nutrients. These fruits can be grouped into 7 classes: aggregate, berry, citrus, drupe, melon, multiple, pome. Some groups have properties that differentiates them from others. For example, melons have the highest amount of vitamin A while drupes have the highest amount of vitamin C. Initial plans for this project was for a classification of individual fruits. However, due to the limitations of the data that is required to train the model, the plan was reduced to categories of fruits.
</details>

<details>
  <summary>Purpose</summary>
  This project aims to help people that want to get their fruit intake that suits their nutritional needs down to the digits. The practical portion of this project is a US FDA Nutrition label where users can input values for certain nutrients.
</details>

<details>
  <summary>Model</summary>
  By analyzing the results of certain techniques of handling missing data, feature selection, and sample selection, a random forest model was developed at a 79.33% accuracy with the following hypter parameters: max_depth=5, max_features='log2', n_estimators=175, random_state=11.
</details>

<details>
  <summary>Fturue Work</summary>
  This project only tested simple classifier models and future work may include testing more complex models or further optimization. The data for this project was exclusively fruits, but it can be broadened. Future research and development can scale this project to classify more broader categories of food such as dairy, meat, vegetables, etc.
</details>

For more information on the details on the development of this project, please refer to "Fruitify Report".
