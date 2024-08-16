# Foodify

## Summary

Different types of foods have unique amounts of macro and micro nutrients. They can be classified into 5 main food groups: fruits, vegetables, grains, protein foods, and dairy. This project aims to develop a machine learning model to classify foods based on their chemical composition that will be used to create a dietary tool where users can find a type of food that fits their best needs.

<details>
  <summary>Updates</summary>
  <ul>
    <details>
      <summary>August 15th, 2024</summary>

  - The foundations food datasets have been cleaned, organized, and combined into 1

  <br> The foundation’s food data only contains 1 sample per food. This sample may be composed of sub samples. Upon examining the foundation's food data, some foods have incomplete data and missing essential nutrients that are present. This proves problematic because it would misguide the model and produce inaccurate results. As a solution, the decision to incorporate the SR Legacy dataset is decided upon.
    </details>
    <details>
      <summary>August 10th, 2024</summary>
      
  - Developments for other food groups is being planned and developed
  * Migrating data collection from API calls to download files
      
  <br> The developments for other food group calls for a rebranding from Fruitify to Foodify. The decision to migrate the data to a database will prove to increase the stability of the data.
    </details>
    <details>
      <summary>June 11th, 2024</summary>
      
  - Created a design draft for the home page using Figma
  * Created the home page using the draft
    
  <br>The design of the home page is relatively complete with the exlusion of some buttons. The only functional button, for now, is the "Fruit" button on the navigation bar which was the original project. The navigation bar serves as a quick way to access the tools for users that are already familiar with them. The "Get Started" button serves as a beginner's guide to select from the array of tools. The next step is to redesign the fruit tool such that it matches the current style of the website and to design and integrate, but without functionality, the "Get Started" Page.
    </details>
    <details>
      <summary> June 6th, 2024 </summary>
      
  - Updated the size of the value input boxes to match the size of the average input
  * Increased the size of the percent input boxes
    
  <br>The function for the fruit tool is mostly complete. The UI can be improved with the addition of buttons and the model can be improved through further optimization and analaysis. To increase the usefullness of this tool, we can broaden the fruit types. We can build a similar food predictor for all types of food including meats, dairy, vegetable, etc. The next step is to build a functional website that houses these tools.
  </details>
  
  </ul>

</details>
<details>
  <summary>Introduction</summary>
  Most foods can be classified into 5 main food groups: fruits, vegetables, grains, protein foods, and dairy. These food groups are differentiable from each other and possess unique compositions of nutrients. For example, fruits typically have potassium, dietary fiber, vitamin C and no cholestrol. On the other hand, dairy food have calicum, potassium, and no dietary fiber.
</details>

<details>
  <summary>Purpose</summary>

   This project aims to help people that want to get their food intake that suits their nutritional needs down to the digits. It can also serve as an educational tool for students to better undestand the composition of different types of food. The practical portion of this project is a US FDA Nutrition label where users can input values for certain nutrients.
</details>

<details>
  <summary>Model</summary>
  FOR THE FRUIT MODEL: By analyzing the results of certain techniques of handling missing data, feature selection, and sample selection, a random forest model was developed at a 79.33% accuracy with the following hypter parameters: max_depth=5, max_features='log2', n_estimators=175, random_state=11.
</details>


For more information on the details on the development of this project, please refer to "Fruitify Report".
