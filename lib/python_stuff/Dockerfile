# Use official Python 3.12.8 slim image
FROM python:3.12.8-slim

# Set working directory
WORKDIR /app

# Install system dependencies (optional but safe for future builds)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your app code
COPY . .

# Set environment variables for Google Cloud
ENV GOOGLE_GENAI_USE_VERTEXAI=true \
    GOOGLE_CLOUD_PROJECT=unroll-genai-hackathon-app \
    GOOGLE_CLOUD_LOCATION=global

# Expose FastAPI port
EXPOSE 8000

# Run the FastAPI app using Uvicorn
CMD ["uvicorn", "gemini_requests:app", "--host", "0.0.0.0", "--port", "8000"]
