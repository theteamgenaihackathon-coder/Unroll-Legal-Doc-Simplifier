from google import genai
from google.genai.types import HttpOptions, GenerateContentConfig, SafetySetting, Part
import os
from pathlib import Path
import mimetypes

filePath = Path(r"./lib/term.pdf")

# fileData = filePath.read_bytes()
mimeType = mimetypes.guess_type(filePath)[0]
# file = Part.from_bytes(data=fileData,mime_type=mimeType)
print(mimeType)

# os.environ["GOOGLE_CLOUD_PROJECT"] = "unroll-genai-hackathon-app"
# os.environ["GOOGLE_CLOUD_LOCATION"] = "global"
# PROJECT_NAME = "unroll-genai-hackathon-app"
# PROJECT_REGION = "global"

# # prompts = [file,"Simplify the document"]

# client = genai.Client(http_options=HttpOptions(api_version="v1"),project=PROJECT_NAME,location=PROJECT_REGION)
# # response = client.models.generate_content(
# #     model="gemini-2.0-flash",
# #     contents=prompts,
# #     config=GenerateContentConfig(
# #         system_instruction="Simplify the given document into headings and bullet points considering the max output tokens. Stick to the information in the document. Be concise and avoid verbose ",
# #         safety_settings = [
# #             {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_LOW_AND_ABOVE"},
# #             {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_LOW_AND_ABOVE"},
# #             {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_LOW_AND_ABOVE"},
# #             {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_LOW_AND_ABOVE"},
# #             ],
# #         temperature=0,
# #         max_output_tokens=1000))

# # print(response.text)
# # # Example response:
# # # Okay, let's break down how AI works. It's a broad field, so I'll focus on the ...
# # #
# # # Here's a simplified overview:
# # # ...

# def get_current_weather(location: str) -> str:
#     """Returns the current weather.

#     Args:
#       location: The city and state, e.g. San Francisco, CA
#     """

#     return "weather"


# response = client.models.generate_content(
#     model='gemini-2.0-flash-001',
#     contents='What is the weather like in Kashmir, Drung Waterfall?',
#     config=GenerateContentConfig(tools=[get_current_weather]),
# )

# print(response.text)