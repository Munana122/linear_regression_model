from pathlib import Path
import joblib
from fastapi import FastAPI
from pydantic import BaseModel
# --- ADD THIS IMPORT ---
from fastapi.middleware.cors import CORSMiddleware 

MODEL_PATH = Path(__file__).resolve().parent / "best_model.pkl"
model = joblib.load(MODEL_PATH)

app = FastAPI(title="Gender Wage Gap Prediction API")

# --- ADD THIS BLOCK (Mandatory for Rubric) ---
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows your Flutter app to connect from anywhere
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
    # Note: If you scaled your data in the notebook, 
    # you technically need to scale 'data.year' here too!
    prediction = model.predict([[data.year]])
    return {
        "year": data.year,
        "predicted_gap_percentage": round(float(prediction[0]), 2),
    }