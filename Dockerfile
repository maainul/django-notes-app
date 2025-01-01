FROM python:3.9-slim

WORKDIR /app

# Copy application files
COPY requirements.txt /app
COPY app.py /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000
EXPOSE 8000

# Start the application
CMD ["python", "app.py"]
