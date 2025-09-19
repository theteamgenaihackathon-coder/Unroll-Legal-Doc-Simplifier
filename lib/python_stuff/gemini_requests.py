from fastapi import FastAPI, File, Query, UploadFile
from google import genai
from google.genai.types import HttpOptions, GenerateContentConfig, SafetySetting, Part
import fitz
import os
import mimetypes

app = FastAPI()

PROJECT_NAME = "unroll-genai-hackathon-app"
PROJECT_REGION = "global"

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
    # Step 1: Extract text from PDF
    data = await file.read()
    doc = fitz.open(stream=data, filetype="pdf")

    extracted_text = ""
    for page in doc:
        extracted_text += page.get_text("text")

    # Step 2: Auto language simplification
    system_instruction = (
        "Simplify the given document into headings and bullet points. "
        "Always produce the output in the SAME LANGUAGE as the original document. "
        "Be concise and avoid verbose. Limit total output tokens to less than 500."
    )

    response = client.models.generate_content(
        model="gemini-2.0-flash-001",
        contents=[extracted_text],
        config=GenerateContentConfig(
            response_mime_type="application/json",
            response_json_schema=simplifiedDocJsonSchema,
            system_instruction=system_instruction,
        ),
    )

    temp_simplified_response["response"] = response.parsed
    # return {"simplified_doc": response.parsed}
    return response

  
@app.post("/translate_simplified")
def translate_simplified(target_lang: str = Query(..., enum=["hindi", "english", "tamil", "telugu", "malayalam", "kannada"])):
    if "response" not in temp_simplified_response:
        return {"error": "No simplified document found. Please run /simplify first."}

    simplified_doc = temp_simplified_response["response"]

    system_instruction = (
        f"Translate the given JSON document into {target_lang}. "
        f"Do not change the structure. Only translate values of title, headings, subheadings, and bullet points."
    )

    response = client.models.generate_content(
        model="gemini-2.0-flash-001",
        contents=[str(simplified_doc)],
        config=GenerateContentConfig(
            response_mime_type="application/json",
            response_json_schema=simplifiedDocJsonSchema,
            system_instruction=system_instruction,
        ),
    )

    temp_simplified_response["response"] = response.parsed
    # return {"simplified_doc_translated": response.parsed}
    return response


    
