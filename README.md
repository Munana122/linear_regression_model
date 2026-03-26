# Economic Empowerment for Women & Young Mothers — Gender Wage Gap Predictor

## Mission

Breaking the cycle of poverty among women and young mothers through education and economic empowerment.

A persistent gender wage gap limits the financial independence of young mothers, making it difficult to afford quality education and childcare. This project uses regression analysis to study historical wage gap trends and predict future economic parity — providing data-driven insights to inform targeted empowerment strategies.

---

## Project Overview

This repository applies Machine Learning to predict the Gender Wage Gap over time. By modeling how the gap evolves, we can project when economic equality might be reached and highlight the urgency for educational interventions supporting young mothers.

**Data Source:** Gender Wage Gap Dataset (OECD / World Bank statistics)

---

## Feature Engineering & Preparation

- **Location Filtering:** Dataset filtered to a specific region (e.g., Australia) for localized economic accuracy.
- **Column Selection:** Dropped noise columns (`Frequency`, `Measure`, `Subject`), retaining `Time` (Year) and `Value` (Wage Gap %).
- **Standardization:** Features scaled with `StandardScaler` to ensure efficient Gradient Descent convergence.

---

## Models Implemented

| Model | Description |
|---|---|
| Linear Regression (SGD) | Baseline model to identify the general wage gap trend |
| Decision Tree Regressor | Captures non-linear fluctuations in economic data |
| Random Forest Regressor | Ensemble method for improved prediction stability |

---

## Key Visualizations

- **Loss Curve** — Shows MSE reduction over iterations during Gradient Descent training.
- **Before & After Plot** — Scatter plot comparing original data points against the model's predicted regression line.

---

## How to Use

The best-performing model is saved as `best_model.pkl`. To run a prediction:

```python
import pickle

with open("best_model.pkl", "rb") as f:
    model = pickle.load(f)

# Predict the wage gap for a future year
year = [[2035]]
prediction = model.predict(year)
print(f"Predicted wage gap in 2035: {prediction[0]:.2f}%")
```

---

## Repository Structure

```
linear_regression_model/
├── best_model.pkl
├── notebook.ipynb
├── README.md
├── summative/
│   ├── API/
│   │   ├── best_model.pkl
│   │   ├── main.py
│   │   └── requirements.txt
│   ├── FlutterApp/
│   │   ├── pubspec.yaml
│   │   └── lib/
│   │       └── main.dart
│   └── linear_regression/
│       ├── best_model.pkl
│       └── multivariate.ipynb
```

---

## Final Submission Checklist

- `README.md` ✅ Mission statement and project description
- `notebook.ipynb` ✅ Full model workflow notebook
- `best_model.pkl` ✅ Best-performing saved model
- `summative/API/main.py` ✅ FastAPI backend for prediction
- `app_demo.mp4` ⏳ Record and add your 2-minute app demo video

---

## Run the Backend (FastAPI)

1. Open terminal in `summative/API`
2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Start API server:

```bash
uvicorn main:app --reload
```

4. Test in browser: `http://127.0.0.1:8000`

5. Optional smoke test (while API is running):

```bash
python smoke_test.py --year 2035
```

---

## Run the Mobile App (Flutter)

1. Open terminal in `summative/FlutterApp`
2. If needed, initialize project shell files:

```bash
flutter create .
```

3. Install packages:

```bash
flutter pub get
```

4. Run app:

```bash
flutter run
```

The app calls the API endpoint at `http://10.0.2.2:8000/predict`.

---

## One-Command Demo (Windows PowerShell)

From the repository root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\run_demo.ps1
```

This opens FastAPI in a new PowerShell window, then starts the Flutter app.
