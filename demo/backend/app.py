from flask import Flask, jsonify
from flask_cors import CORS
import psycopg2
import os

app = Flask(__name__)
CORS(app)  # Habilita CORS para todas las rutas

# Función para conectar a la base de datos
def get_db_connection():
    try:
        connection = psycopg2.connect(
            host=os.getenv("DB_HOST", "localhost"),
            database=os.getenv("DB_NAME", "postgres"),
            user=os.getenv("DB_USER", "postgres"),
            password=os.getenv("DB_PASSWORD", "password"),
            port=os.getenv("DB_PORT", "5432"),
        )
        return connection
    except Exception as e:
        print(f"Error connecting to the database: {e}")
        raise e

@app.route("/")
def home():
    return jsonify({"message": "Hello, World!"}), 200

@app.route("/health")
def health():
    return jsonify({"status": "alive"}), 200

@app.route("/WeatherForecast")
def weather_forecast():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT date, temperatureC, summary FROM weather_forecast;")
        forecasts = [
            {"date": row[0], "temperatureC": row[1], "summary": row[2]} for row in cursor.fetchall()
        ]
        cursor.close()
        conn.close()
        return jsonify(forecasts), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
@app.route("/DummyWeatherForecast")
def dummy_weather_forecast():
    # Servicio independiente para valores dummy
    dummy_forecasts = [
        {"date": "2025-01-21", "temperatureC": 20, "summary": "Sunny"},
        {"date": "2025-01-22", "temperatureC": 18, "summary": "Cloudy"},
        {"date": "2025-01-23", "temperatureC": 15, "summary": "Rainy"},
    ]
    return jsonify(dummy_forecasts), 200

@app.route("/environment")
def environment_variables():
    env_vars = {
        "DB_HOST": os.getenv("DB_HOST"),
        "DB_NAME": os.getenv("DB_NAME"),
        "DB_USER": os.getenv("DB_USER"),
        "DB_PASSWORD": os.getenv("DB_PASSWORD"),
        "DB_PORT": os.getenv("DB_PORT"),
    }
    return jsonify(env_vars), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
