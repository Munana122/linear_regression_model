from pathlib import Path
import joblib
from fastapi import FastAPI
from pydantic import BaseModel
# 1. Import CORSMiddleware
from fastapi.middleware.cors import CORSMiddleware 

MODEL_PATH = Path(__file__).resolve().parent / "best_model.pkl"
model = joblib.load(MODEL_PATH)

app = FastAPI(title="Gender Wage Gap Prediction API")

# 2. Add the CORS Middleware block
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins (essential for Flutter)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class PredictionInput(BaseModel):
    year: int

@app.get("/")
def home():
    return {"message": "Gender Wage Gap Prediction API is active!"}

@app.post("/predict")
def predict_wage_gap(data: PredictionInput):
    # If your model was trained on scaled data, you'd scale data.year here
    prediction = model.predict([[data.year]])
    return {
        "year": data.year,
        "predicted_gap_percentage": round(float(prediction[0]), 2),
    }