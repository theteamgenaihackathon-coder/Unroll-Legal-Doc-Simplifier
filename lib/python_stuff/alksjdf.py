from google import genai
from google.genai.types import HttpOptions, GenerateContentConfig, SafetySetting, Part
import os
from pathlib import Path
import mimetypes

PROJECT_NAME = "unroll-genai-hackathon-app"
PROJECT_REGION = "global"

os.environ["GOOGLE_GENAI_USE_VERTEXAI"] = "true"
os.environ["GOOGLE_CLOUD_PROJECT"] = PROJECT_NAME
os.environ["GOOGLE_CLOUD_LOCATION"] = PROJECT_REGION

prompts = ["Just reply the word 'Hello' only"]

client = genai.Client(http_options=HttpOptions(api_version="v1"),project=PROJECT_NAME,location=PROJECT_REGION)

response = client.models.generate_content(
    model='gemini-2.0-flash-001',
    contents=prompts,
)

print(response.text)