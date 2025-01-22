-- Create table
CREATE TABLE weather_forecast (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    temperatureC INT NOT NULL,
    summary VARCHAR(255) NOT NULL
);

-- Insert sample data
INSERT INTO weather_forecast (date, temperatureC, summary)
VALUES ('2024-01-03', -2, 'Cold and Snowy');

-- Verify the data
SELECT * FROM weather_forecast;