
import json
import os
# from google import genai
# from google.genai.types import HttpOptions, GenerateContentConfig, SafetySetting, Part
# import os
# from pathlib import Path
# import mimetypes

# filePath = Path(r"D:\nithe\Documents\Personal\Hackathons\Hack2Skill GenAIHackathon\legal_doc_simplifier\lib\term.pdf")

# fileData = filePath.read_bytes()
# mimeType = mimetypes.guess_type(filePath)[0]
# file = Part.from_bytes(data=fileData,mime_type=mimeType)

# os.environ["GOOGLE_CLOUD_PROJECT"] = "unroll-genai-hackathon-app"
# os.environ["GOOGLE_CLOUD_LOCATION"] = "global"

# PROJECT_NAME = "unroll-genai-hackathon-app"
# PROJECT_REGION = "global"

# simplifiedDocJsonSchema = {
#   "type": "object",
#   "title": "Document Structure Schema",
#   "required": ["title", "sections"],
#   "properties": {
#     "title": {
#       "type": "string",
#       "description": "Main title of the document"
#     },
#     "sections": {
#       "type": "array",
#       "items": {
#         "type": "object",
#         "required": ["heading", "subsections"],
#         "properties": {
#           "heading": {
#             "type": "string",
#             "title": "Section Heading"
#           },
#           "subsections": {
#             "type": "array",
#             "items": {
#               "type": "object",
#               "required": ["subheading", "points"],
#               "properties": {
#                 "subheading": {
#                   "type": "string",
#                   "title": "Subheading"
#                 },
#                 "points": {
#                   "type": "array",
#                   "items": {
#                     "type": "string"
#                   },
#                   "title": "Bullet Points"
#                 }
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }

# prompts = [file,"Simplify the document"]

# client = genai.Client(http_options=HttpOptions(api_version="v1"),project=PROJECT_NAME,location=PROJECT_REGION)

# response = client.models.generate_content(
#     model='gemini-2.0-flash-001',
#     contents=prompts,
    
#     config=GenerateContentConfig(
#         response_mime_type='application/json',response_json_schema=simplifiedDocJsonSchema,                           system_instruction="Simplify the given document into headings and bullet points considering the max output tokens. Stick to the information in the document. Be concise and avoid verbose "),
# )

# print(response.parsed)
response = {'title': 'TERMS AND CONDITIONS', 'sections': [{'heading': 'Terms and Conditions', 'subsections': [{'subheading': 'General', 'points': ['Governs Gen Al Exchange Hackathon by (Client Name) & Hack2skill.', 'Participants agree to abide by the Terms and Conditions by registering.']}, {'subheading': 'Organizer Rights', 'points': ['Reserves the right to cancel, postpone, or change the Hackathon.', 'No refund for personal expenses if canceled.', 'Reserves the right to amend Terms and Conditions without notification.']}]}, {'heading': 'Personally Identifiable Information', 'subsections': [{'subheading': 'Data Sharing', 'points': ['Registration details shared with Gen Al Exchange Hackathon organizers for communication.']}]}, {'heading': 'Hackathon Mechanism', 'subsections': [{'subheading': 'Submission and Responsibility', 'points': ['Submit registration via microsite only.', 'Organizer not responsible for late, lost, damaged entries or technical malfunctions.']}, {'subheading': 'Team Composition', 'points': ['Must consist of a minimum and maximum team size.', 'Each individual can only register for one team.']}, {'subheading': 'Team Details', 'points': ['Pre-select team names.', 'Team leader submits member participation details.']}, {'subheading': 'Participation', 'points': ['All team members must appear in person online.', 'Engage on the website/communication platforms.', 'Failure may result in disqualification.']}, {'subheading': 'Team Presentation', 'points': ['Shortlisted teams pitch ideas/prototypes.', 'Specified time for demonstration and Q&A.']}, {'subheading': 'Communication', 'points': ['Agree to receive emails and messages for registered events.']}]}, {'heading': 'Team Prizes', 'subsections': [{'subheading': 'Prizes', 'points': ['Exciting prizes (check website).', 'Prizes are non-transferable.', 'Winners responsible for applicable taxes.', 'Organizer can change prizes without notice.']}]}, {'heading': 'Winner Selection/Judging Criteria', 'subsections': [{'subheading': 'Judging', 'points': ['Winners selected by judges.', 'Entrants release Organizer from liability.', 'Organizer can amend rules/criteria without notice.', 'Final decision rests with the Organizer.', 'Teams judged based on evaluation parameters at different stages.']}]}, {'heading': 'Rules of Conduct', 'subsections': [{'subheading': 'Compliance', 'points': ['Comply with Terms, legal requirements.', 'Refrain from unlawful/objectionable content.', 'No third-party protected content.', "Organizer's decisions are final.", "Judges' decisions are final.", 'Participants must stay online, or risk disqualification.']}, {'subheading': 'Awards', 'points': ['Prizes are non-transferable.', 'Prize recipient responsible for taxes.']}]}, {'heading': 'Cash Rewards', 'subsections': [{'subheading': 'Payment and Deductions', 'points': ['Paid within 60 days.', 'Subject to TDS deductions.']}]}, {'heading': 'Photographic and Video Recordings', 'subsections': [{'subheading': 'Authorization', 'points': ['Organizer can publish photos/videos with participant likeness.', 'Valid for 10 years, globally.']}]}, {'heading': 'Code of Conduct', 'subsections': [{'subheading': 'General', 'points': ['Supports appropriate behavior by participants.', 'Welcomes/respects all participants.', 'No harassment tolerated.']}, {'subheading': 'Examples of Harassment', 'points': ['Offensive comments, threats, sexualised images.', 'Intimidation, stalking, disruption, unwelcome contact.']}, {'subheading': 'Expectations', 'points': ['Participants, speakers, sponsors, volunteers follow Code of Conduct.', 'Stop harassing behavior immediately.']}, {'subheading': 'Appreciation', 'points': ['Thank participants for keeping hackathon welcoming.']}]}, {'heading': 'Anti-Harassment', 'subsections': [{'subheading': 'Policy', 'points': ['Harassment-free experience.', 'Includes offensive comments, intimidation, stalking, etc.', 'Inappropriate language/imagery not appropriate.']}, {'subheading': 'Photography', 'points': ['Encouraged, but respect refusals.', 'No photos in private contexts.']}, {'subheading': 'Hack2skill Policy', 'points': ['Subject to anti-harassment policy.']}, {'subheading': 'Reporting Harassment', 'points': ['Stop immediately if asked.', 'Report concerns to organizing committee.', 'Organizer will help contact law enforcement.', 'Sanctions/expulsion for violations.', 'Report incidents to organizing committee.']}]}, {'heading': 'Intellectual Property Rights', 'subsections': [{'subheading': 'Ownership', 'points': ['Organizer has first refusal for exclusive license of materials.', 'Participant cannot sell/transfer IP without offering to Organizer first.', 'Organizer can publish/communicate submitted ideas.', 'Results cannot infringe third-party rights.', 'Participant indemnifies Organizer against claims.']}]}, {'heading': 'Protection of Intellectual Property', 'subsections': [{'subheading': 'Warranties', 'points': ['By submitting an entry/accepting prize, participants must not submit copyrighted content, falsehoods, unlawful content, or advertisements.', 'Organizer not obligated to pay compensation.', 'Content must not contain viruses.', 'Hackathon grants rights to use content for marketing purposes.']}]}, {'heading': 'Copyright', 'subsections': [{'subheading': 'Ownership', 'points': ['Participant is sole author/copyright owner.', 'Submission is original work.', 'Free of malware.']}]}, {'heading': 'General Eligibility', 'subsections': [{'subheading': 'Disqualification', 'points': ['Organizer determines eligibility, disqualifies entrtries violating rights/laws, using inappropriate language, or inconsistent with brand image.']}, {'subheading': 'Entry Requirements', 'points': ['Only completed/compliant entries are accepted.', 'Entries from minors (14-18) require parental consent/waiver.']}, {'subheading': 'Participation', 'points': ['Hackathon open to eligible participants.', 'Data Security as per IT Act 2008.', 'Terms and Conditions prevail over other materials.']}]}]}
with open("temp.json", "w", encoding="utf-8") as f:
    json.dump(response, f, indent=4, ensure_ascii=False)
print(os.getcwd())