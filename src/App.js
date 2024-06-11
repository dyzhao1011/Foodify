import "./App.css";
import NutritionLabel from "./Nutrition Label/NutritionLabel";
import Home from "./Home/Home";
import { BrowserRouter, Routes, Route } from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/fruit" element={<NutritionLabel />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
