# Foodify

## Summary

Different types of foods have unique amounts of macro and micro nutrients. They can be classified into 5 main food groups: fruits, vegetables, grains, protein foods, and dairy. This project aims to develop a machine learning model to classify foods based on their chemical composition that will be used to create a dietary tool where users can find a type of food that fits their best needs.

<details>
  <summary>Updates</summary>
  <ul>  
    <details>
      <summary>December 23th, 2024</summary>

  - Cleaned the SR_Legacy Table
  <br>
The SR_Legacy was especially messy and required a lot of work to re categorize/remove samples that do not fit in the 5 food groups. 
    </details>
    <details>
      <summary>December 20th, 2024</summary>

  - Initiated the cleaning process for the SR_Leagacy table
  <br>
Initial screening of the SR_Legacy Food table found it messier than the Foundations Food table. For example, for the American Indian/Alaska Native Foods category, it comprises food belonging to more than 1 food category. There are also much more irrelevant samples. 
    </details>
    <details>
      <summary>October 15th, 2024</summary>

  - Deleted duplicate samples and irrelevant samples from the Foundation Food table
  * Duplicated samples (legumes are categorized as both a vegetable and a protein, according to the FDA) in the Foundation Food table
  + Recategorized samples into the 5 main food groups in the Foundation Food table


  <br> Some duplicate samples are exact, some differ slightly for some nutrients, and some have missing values while its duplicate doesn’t. For the last case, duplicates are compared with each other from the order Calories (kcal) to Potassium (MG). Samples that have a more completed nutritional information are prioritized while its duplicate are dropped.

The previous decision to filter out cooked food is being reconsidered. It is a challenge to decide either to use uncooked foods only or most-consumed-type of foods only because cooking food alters the nutrient composition of foods. The former method is a more standardized approach because it uses the natural form of foods. This method makes an exception to Grains because grains aren’t consumed in its natural form. This method excludes dried foods. This method may be misleading because it doesn’t reflect the nutrient profile of how people usually consume that food. The latter method better reflects real life, but a large portion of the Foundations Food samples are only in its raw form. This calls for the project to branch into 2 paths for these methods. The project will currently focus on uncooked foods going forwards and will revisit the other method later on.
    </details>
    <details>
      <summary>October 14th, 2024</summary>

  - Joined the Survey Food datasets into 1 table


  <br> It is necessary to include the Survey Food dataset because they may contain food that aren’t in the Foundation Food or SR_Legacy Food. The Survey Food dataset has many categories that need to be sorted into the 5 main food groups. Upon examination of the Survey Food table, they have no data collected on its trans fat. The next steps would be cleaning of the 3 tables to remove/group foods.
    </details>
    <details>
      <summary>September 16th, 2024</summary>

  - Edited the final Foundations Food table so that it represents the raw, unfiltered data
  * Joined the SR_Legacy Food datasets into 1 table


  <br> Further examination of the data found that some foods such as meats have 2 versions: cooked and uncooked. Since all data is measured in 100 grams, the cooked food usually has more nutrients since it is more dense due to the water loss during cooking. This is problematic because it may mislead the model. To standardize, the cooked foods are filtered out and the raw forms are used to better represent what people usually see on a nutritional label. The next steps would be future data inspection and cleaning.
    </details>
    <details>
      <summary>August 15th, 2024</summary>

  - Joined the Foundation Food datasets into 1 table

  <br> The Foundation Food table only contains 1 sample per food. Examination of the joined Foundation Food Table yieled messy and disorganized data. There is a total of 358 samples before cleaning the table. It is insufficient to train a model. The next step would be to incorporate the SR_Legacy datasets into the database.
    </details>
    <details>
      <summary>August 10th, 2024</summary>
      
  - Planned developments for other food groups
  * Migrated data collection from API calls to download files
      
  <br> The developments for other food group calls for a rebranding from Fruitify to Foodify. The decision to migrate data collection from API calls to a database will prove to increase the efficiency and stability of the data.
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

This project is the successor to a previous project called Fruitify. For more information on the details on the development of it, please refer to "Fruitify Report".
The application of this project can be founder at https://mikeyz.pythonanywhere.com. Please note that the website has limited functionality as it is under development.
