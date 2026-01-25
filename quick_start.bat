@echo off
REM Quick Start Script for Symptom Checker
REM Run this to start all 3 components

echo.
echo ========================================
echo   AI Symptom Checker - Quick Start
echo ========================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Node.js not found. Please install Node.js 18+
    exit /b 1
)

REM Check if Python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Python not found. Please install Python 3.8+
    exit /b 1
)

REM Check if Flutter is installed
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Flutter not found. Please install Flutter
    exit /b 1
)

echo ✓ All prerequisites found
echo.
echo Starting components in separate terminal windows...
echo.

REM Start Backend
echo [1/3] Starting Backend (Express)...
start cmd /k "cd backend && npm install && npm start"
timeout /t 3 /nobreak

REM Start ML API
echo [2/3] Starting ML API (Flask)...
start cmd /k "cd ml && pip install -r requirements.txt && python train.py && python app.py"
timeout /t 3 /nobreak

REM Start Frontend
echo [3/3] Starting Frontend (Flutter)...
start cmd /k "cd frontend && flutter pub get && flutter emulator --launch Pixel_9_Pro && flutter run"

echo.
echo ========================================
echo Components starting...
echo 
echo Backend:  http://localhost:5000
echo ML API:   http://localhost:5001
echo 
echo Wait 30 seconds for all services to start
echo ========================================
echo.
pause
