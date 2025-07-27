# Student Performance Prediction API

## Overview
This FastAPI-based REST API provides machine learning predictions for student academic performance based on various study-related factors. The API uses a trained linear regression model to predict a student's performance index based on their study habits, previous scores, and lifestyle factors.

## Model Description
The API employs a **multivariate linear regression model** trained on student performance data to predict academic outcomes. The model considers five key input features:

### Input Features
1. **Hours Studied** - Number of hours the student studies per day/week
2. **Previous Scores** - Student's previous academic scores (0-100)
3. **Extracurricular Activities** - Participation in activities (0 = No, 1 = Yes)
4. **Sleep Hours** - Average hours of sleep per night
5. **Sample Question Papers Practiced** - Number of practice papers completed

### Output
- **Performance Index** - Predicted academic performance score (0-100 scale)

## Features
- ✅ RESTful API endpoints for predictions
- ✅ Input validation using Pydantic models
- ✅ CORS support for cross-origin requests
- ✅ Pre-trained model with feature scaling
- ✅ JSON response format
- ✅ Error handling and validation

## API Endpoints

### Root Endpoint
- **GET** `/` - Welcome message and API status

### Prediction Endpoint
- **POST** `/predict` - Make student performance predictions

**Request Body:**
```json
{
  "HoursStudied": 7,
  "PreviousScores": 85,
  "ExtracurricularActivities": 1,
  "SleepHours": 8,
  "SampleQuestionPapersPracticed": 5
}
```

**Response:**
```json
{
  "prediction": 78.5
}
```

## Installation & Setup

### Prerequisites
- Python 3.7+
- pip package manager

### Install Dependencies
```bash
pip install -r requirements.txt
```

### Required Files
Ensure these model files are present in the API directory:
- `studentperfomance.joblib` - Trained linear regression model
- `scaler.joblib` - Feature scaler for input normalization

## Running the API

### Development Server
```bash
uvicorn app:app --reload --host 0.0.0.0 --port 8000
```

### Production Server
```bash
uvicorn app:app --host 0.0.0.0 --port 8000
```

The API will be available at:
- Local: `http://localhost:8000`
- Network: `http://your-ip:8000`
- API Documentation: `http://localhost:8000/docs` (Swagger UI)

## Usage Examples

### Using cURL
```bash
curl -X POST "http://localhost:8000/predict" \
     -H "Content-Type: application/json" \
     -d '{
       "HoursStudied": 7,
       "PreviousScores": 85,
       "ExtracurricularActivities": 1,
       "SleepHours": 8,
       "SampleQuestionPapersPracticed": 5
     }'
```

### Using Python Requests
```python
import requests

url = "http://localhost:8000/predict"
data = {
    "HoursStudied": 7,
    "PreviousScores": 85,
    "ExtracurricularActivities": 1,
    "SleepHours": 8,
    "SampleQuestionPapersPracticed": 5
}

response = requests.post(url, json=data)
print(response.json())
```

## Model Performance
The linear regression model was trained on a comprehensive dataset of student performance metrics and provides reliable predictions for academic outcomes based on study patterns and lifestyle factors.

## Technology Stack
- **FastAPI** - Modern, fast web framework for building APIs
- **Pydantic** - Data validation using Python type annotations
- **Scikit-learn** - Machine learning model and preprocessing
- **NumPy** - Numerical computing support
- **Joblib** - Model serialization and loading

## API Documentation
Once the server is running, visit `http://localhost:8000/docs` for interactive API documentation powered by Swagger UI.
