from pathlib import Path

import joblib
from fastapi import FastAPI
from pydantic import BaseModel

MODEL_PATH = Path(__file__).resolve().parent / "best_model.pkl"
model = joblib.load(MODEL_PATH)

app = FastAPI(title="Gender Wage Gap Prediction API")


class PredictionInput(BaseModel):
    year: int


@app.get("/")
def home():
    return {"message": "Gender Wage Gap Prediction API is active!"}


@app.post("/predict")
def predict_wage_gap(data: PredictionInput):
    prediction = model.predict([[data.year]])
    return {
        "year": data.year,
        "predicted_gap_percentage": round(float(prediction[0]), 2),
    }
