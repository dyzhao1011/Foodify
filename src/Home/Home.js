import "./Home.css";
import { useNavigate } from "react-router-dom";
function Home() {
  const navigate = useNavigate();
  const handleClickFruit = () => navigate("/fruit");
  return (
    <div id="home">
      <div id="home-main">
        <div id="home-header">
          <img src="/logo.svg" alt="Logo" width="15%" />
          <div id="home-header-navbar">
            <ul>
              <li id="home-header-null">Home</li>
              <li id="home-header-null">All Food</li>
              <li id="home-header-null">Meat</li>
              <li id="home-header-null">Vegetable</li>
              <li id="home-header-fruit" onClick={handleClickFruit}>
                Fruit
              </li>
            </ul>
          </div>
        </div>

        <div id="home-welcome">
          <p id="home-welcome-heading">Predict Food Using Nutrients</p>
          <p id="home-welcome-body">
            Enter values for macro and micro nutrients on a FDA Nutrition Facts
            Label and get a prediction on the food or the type of food
          </p>
          <button id="home-welcome-getStarted">Get Started</button>
        </div>

        <div id="home-background">
          <img
            id="home-background-image"
            src="/home.jpeg"
            alt="Food"
            width="100%"
          />
        </div>

        <div id="home-info">
          <div class="home-info-section">
            <img src="/icon/ml.svg" width="8%" />
            <div class="home-info-section-text">
              <p class="home-info-section-text-heading">How Does it Work?</p>
              <p>
                Specialized machine learning classifiers are trained using an
                existing database of nutrients to make prediction on given
                values.
              </p>
            </div>
          </div>

          <div class="home-info-section">
            <img src="/icon/data.svg" width="8%" />
            <div class="home-info-section-text">
              <p class="home-info-section-text-heading">What Data is Used?</p>
              <p>
                Models are trained using data from USDA Foodcentral's Foundation
                Foods and SR Legacy Food dataset.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Home;
