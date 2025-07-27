# Student Performance Prediction System

## Demo Video


## 🎯 **Project Overview**
A comprehensive machine learning system that predicts student academic performance using multivariate linear regression. The system combines data science, mobile development, and API design to create a practical educational tool for students, educators, and parents.

## 🏗️ **System Architecture**

### **Components:**
1. **Machine Learning Model** - Multivariate Linear Regression trained on student performance data
2. **FastAPI Backend** - RESTful API server with automatic documentation
3. **Flutter Mobile App** - Cross-platform mobile application with modern UI
4. **Data Pipeline** - Complete preprocessing and feature engineering workflow

## 📊 **Machine Learning Model**

### **Model Type:** Multivariate Linear Regression
- **Dataset:** 10,000+ student performance records
- **Target Variable:** Performance Index (0-100 scale)
- **Algorithm:** Linear Regression with feature scaling

### **Input Features:**
1. **Hours Studied** - Daily/weekly study time
2. **Previous Scores** - Historical academic performance (0-100)
3. **Extracurricular Activities** - Participation (Yes=1, No=0)
4. **Sleep Hours** - Average nightly sleep duration
5. **Sample Papers Practiced** - Number of practice tests completed

### **Model Performance:**
- High R² score indicating strong predictive capability
- Low mean absolute error for reliable predictions
- Feature scaling applied for optimal performance
- Saved as `.joblib` files for production deployment

## 🔧 **Technology Stack**

### **Backend API:**
- **FastAPI** - Modern, fast web framework
- **Pydantic** - Data validation and serialization
- **Scikit-learn** - Machine learning model and preprocessing
- **Joblib** - Model persistence and loading
- **Uvicorn** - ASGI server for production deployment

### **Mobile Application:**
- **Flutter** - Cross-platform mobile development framework
- **Dart** - Programming language
- **HTTP** - API communication
- **Material Design 3** - Modern UI/UX components

### **Data Science:**
- **Pandas** - Data manipulation and analysis
- **NumPy** - Numerical computing
- **Matplotlib/Seaborn** - Data visualization
- **Jupyter Notebooks** - Interactive development environment

## 📱 **Mobile Application Features**

### **User Interface:**
- Modern gradient design with Material Design 3
- Intuitive input forms with validation
- Real-time loading states and feedback
- Color-coded prediction results
- Responsive design for all screen sizes

### **Functionality:**
- Input validation for all student data fields
- HTTP API communication with error handling
- Performance prediction with visual feedback
- Prediction history and result persistence
- Clear/reset functionality for new predictions

### **Performance Categories:**
- 🟢 **Excellent** (80%+) - High performing students
- 🟠 **Good** (60-79%) - Average performing students
- 🔴 **Needs Improvement** (<60%) - Students requiring support

## 🚀 **API Endpoints**

### **Base URL:** `https://linear-regression-s8mw.onrender.com`

### **Endpoints:**
- **GET /** - Welcome message and API status
- **POST /predict** - Student performance prediction

### **Request Format:**
```json
{
  "HoursStudied": 7,
  "PreviousScores": 85,
  "ExtracurricularActivities": 1,
  "SleepHours": 8,
  "SampleQuestionPapersPracticed": 5
}
```

### **Response Format:**
```json
{
  "prediction": 78.5
}
```

### **API Features:**
- Automatic API documentation (Swagger UI)
- Input validation and error handling
- CORS support for cross-platform access
- RESTful design principles
- Production-ready deployment

## 🎯 **Use Cases**

### **For Students:**
- Understand how study habits impact academic performance
- Identify areas for improvement in study patterns
- Make data-driven decisions about time allocation
- Track progress over time

### **For Educators:**
- Identify students who may need additional support
- Optimize teaching strategies based on performance predictors
- Monitor class performance trends
- Provide personalized guidance

### **For Parents:**
- Monitor children's study patterns and sleep habits
- Understand the relationship between lifestyle and academic success
- Support evidence-based decisions about extracurricular activities
- Track academic progress indicators

## 📈 **Business Value**

### **Educational Impact:**
- **Early Intervention** - Identify at-risk students before grades suffer
- **Resource Optimization** - Allocate support where it's most needed
- **Performance Insights** - Understand factors driving academic success
- **Data-Driven Decisions** - Replace intuition with evidence-based strategies

### **Technical Innovation:**
- **End-to-End ML Pipeline** - From raw data to production deployment
- **Modern Architecture** - Microservices with clear separation of concerns
- **Scalable Design** - Ready for thousands of concurrent users
- **Cross-Platform Access** - Mobile-first approach with API flexibility

## 🔍 **Key Insights**

### **Model Findings:**
- Study hours and previous scores are strong predictors of performance
- Sleep patterns significantly impact academic outcomes
- Extracurricular activities show interesting correlations with performance
- Practice with sample papers improves prediction accuracy

### **Technical Achievements:**
- Successfully deployed ML model to production environment
- Created intuitive mobile interface for complex ML predictions
- Implemented robust API with comprehensive error handling
- Achieved high model accuracy with interpretable results

## 🎯 **Future Enhancements**

### **Model Improvements:**
- Incorporate additional features (socioeconomic factors, learning styles)
- Implement ensemble methods for improved accuracy
- Add time-series analysis for performance trends
- Create personalized recommendation systems

### **Application Features:**
- Performance tracking over time
- Personalized study recommendations
- Integration with learning management systems
- Multi-language support for global deployment

### **Technical Upgrades:**
- Real-time model updates with new data
- Advanced analytics and reporting dashboards
- Integration with educational platforms
- Offline prediction capabilities

---

**This project demonstrates the complete journey from raw educational data to a deployed, production-ready machine learning application that provides real value to the education sector.**