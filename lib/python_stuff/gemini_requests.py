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

blankFillJsonSchema ={
  "name": "MissingFieldsResponse",
  "schema": {
    "type": "object",
    "properties": {
      "missing_fields": {
        "type": "array",
        "description": "List of fields that are missing and should be filled",
        "items": {
          "type": "object",
          "properties": {
            "example": {
              "type": "string",
              "description": "An example value for the missing field"
            },
            "field": {
                "type": "string",
                "description": "Kind of variable being used. Eg: Contact name, Phone no., Date of Birth, etc.",
            },
            "location": {
              "type": "string",
              "description": "A short, user-friendly explanation of where this missing field / blank is with respect to the structure of the document"
            },
            "reason": {
              "type": "string",
              "description": "Why this field is important or what it represents"
            }
          },
          "required": ["example", "field"]
        }
      }
    },
    "required": ["missing_fields"]
  }
}




client = genai.Client(http_options=HttpOptions(api_version="v1"),project=PROJECT_NAME,location=PROJECT_REGION)

temp_simplified_response = {}
temp_docs = []

@app.post("/simplify")
async def simplify(file: UploadFile = File(...)):
    # Step 1: Extract text from PDF
    data = await file.read()
    doc = fitz.open(stream=data, filetype="pdf")
    temp_docs.append(doc)

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
            max_output_tokens=600
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
            max_output_tokens=600,
        ),
    )

    temp_simplified_response["response"] = response.parsed
    return response


    
@app.post("/fill")
async def fill():
    # Step 1: Extract text from PDF
    # data = await file.read()
    # doc = fitz.open(stream=data, filetype="pdf")
    doc = temp_docs[-1]

    extracted_text = ""
    for page in doc:
        extracted_text += page.get_text("text")

    # Step 2: Auto language simplification
    system_instruction = ("""
        You are an assistant that analyzes input files and identifies missing fields. Find fill in the blanks in the given file and return example,field, location of the blank with respect to the structure of document for a general user and reason why the given example is suitable in the blank with respect to the document flow
"""
    )

    response = client.models.generate_content(
        model="gemini-2.0-flash-001",
        contents=[extracted_text],
        config=GenerateContentConfig(
            response_mime_type="application/json",
            response_json_schema=blankFillJsonSchema,
            system_instruction=system_instruction,
            temperature=0.3,
            max_output_tokens=600
        ),
    )
    print(response)

    temp_simplified_response["response"] = response.parsed
    # return {"simplified_doc": response.parsed}
    return response