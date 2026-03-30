# Gender Wage Gap Predictor

## Mission
A persistent gender wage gap limits the financial independence of women and young mothers, making it difficult to afford quality education and childcare.
This project uses regression analysis on OECD wage gap data to predict future economic trends and inform targeted empowerment strategies.

---

## Public API Endpoint

**Base URL:** `https://linear-regression-model-fz89.onrender.com`

| Endpoint | Method | Description |
|---|---|---|
| `/` | GET | Health check |
| `/predict` | POST | Returns predicted wage gap for a given year |

**Test via Swagger UI:** `https://linear-regression-model-fz89.onrender.com/docs`

**Example request:**
```json
{
  "year": 2035
}
```

**Example response:**
```json
{
  "year": 2035,
  "predicted_gap_percentage": 12.45
}
```

---

## Video Demo

🎥 [Watch the demo on YouTube](https://youtu.be/X8Z5JHlRNkI)

---

## Run the Mobile App (Flutter)

1. Open terminal in `summative/FlutterApp`
2. Install packages:
```bash
flutter pub get
```
3. Run the app:
```bash
flutter run
```

The app connects to the live API at `https://linear-regression-model-fz89.onrender.com/predict`.
No local server needed.

---

## Models Implemented

| Model | MSE |
|---|---|
| Linear Regression (SGD) | 6.49 |
| Decision Tree Regressor | 7.00 |
| Random Forest Regressor | 6.95 |

The **Linear Regression (SGD)** model was selected as the best performer and saved as `best_model.pkl`.

---

## Repository Structure

```
linear_regression_model/
├── README.md
├── summative/
│   ├── API/
│   │   ├── main.py
│   │   ├── best_model.pkl
│   │   └── requirements.txt
│   ├── FlutterApp/
│   │   ├── pubspec.yaml
│   │   └── lib/
│   │       └── main.dart
│   └── linear_regression/
│       └── multivariate.ipynb
```
