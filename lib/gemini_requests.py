from fastapi import FastAPI, File, UploadFile
from google import genai
from google.genai.types import HttpOptions, GenerateContentConfig, SafetySetting, Part

import os
import mimetypes

app = FastAPI()

PROJECT_NAME = "unroll-genai-hackathon-app"
PROJECT_REGION = "asia-south1"

os.environ["GOOGLE_GENAI_USE_VERTEXAI"] = "true"
os.environ["GOOGLE_CLOUD_PROJECT"] = PROJECT_NAME
os.environ["GOOGLE_CLOUD_LOCATION"] = PROJECT_REGION

simplifiedDocJsonSchema = {
  "type": "object",
  "title": "Document Structure Schema",
  "required": ["title", "sections"],
  "properties": {
    "title": {
      "type": "string",
      "description": "Main title of the document"
    },
    "sections": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["heading", "subsections"],
        "properties": {
          "heading": {
            "type": "string",
            "title": "Section Heading"
          },
          "subsections": {
            "type": "array",
            "items": {
              "type": "object",
              "required": ["subheading", "points"],
              "properties": {
                "subheading": {
                  "type": "string",
                  "title": "Subheading"
                },
                "points": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "title": "Bullet Points"
                }
              }
            }
          }
        }
      }
    }
  }
}

client = genai.Client(http_options=HttpOptions(api_version="v1"),project=PROJECT_NAME,location=PROJECT_REGION)

temp_simplified_response = {}

@app.post("/simplify")
async def simplify(file: UploadFile = File(...)):
    data = await file.read()
    file = Part.from_bytes(data=data,mime_type='application/pdf')

    prompts = [file,"Simplify the document"]

    response = client.models.generate_content(
        model='gemini-2.0-flash-001',
        contents=prompts,
        
        config=GenerateContentConfig(
            response_mime_type='application/json',response_json_schema=simplifiedDocJsonSchema,                           system_instruction="Simplify the given document into headings and bullet points considering the max output tokens. Stick to the information in the document. Be concise and avoid verbose. The total output tokens should be less than 500"),
    )

    return response

    print(response.parsed)

    temp_simplified_response["response"] = response

@app.get("/get_simplified")
def get_result():
    if "response" in temp_simplified_response:
        return temp_simplified_response["response"]
    return {"error": "No result available yet"}