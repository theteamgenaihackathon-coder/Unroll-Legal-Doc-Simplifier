// Return a Scrollable Text to be Displayed in Simplified Page

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/network/gemini_requests.dart';
import 'content_styling.dart';

class SimplifiedDocView extends StatefulWidget {
  final File pdfFile;
  final Map<String, dynamic>? overrideDocJson;

  const SimplifiedDocView({
    super.key,
    required this.pdfFile,
    this.overrideDocJson,
  });

  @override
  State<SimplifiedDocView> createState() => _SimplifiedDocViewState();
}

class _SimplifiedDocViewState extends State<SimplifiedDocView> {
  Map<String, dynamic>? _docJson;

  @override
  Widget build(BuildContext context) {
    if (widget.overrideDocJson != null) {
      _docJson = widget.overrideDocJson;
    }

    return FutureBuilder(
      future: simplifyDocRequest(widget.pdfFile),
      builder: (context, snapshot) {
        if (_docJson == null) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final decoded = jsonDecode(snapshot.data ?? '{}');
            final simplifiedText =
                decoded["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];
            if (simplifiedText != null) {
              _docJson = jsonDecode(simplifiedText);
            }
          }
        }

        final title = _docJson?['title'] ?? 'Untitled';
        final sections = _docJson?['sections'] as List<dynamic>? ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              for (final section in sections)
                SectionWidget(section: section as Map<String, dynamic>),
            ],
          ),
        );
      },
    );

    //     final String simplifiedJsonString = """{
    //   "title": "TERMS AND CONDITIONS",
    //   "sections": [
    //     {
    //       "heading": "General Terms",
    //       "subsections": [
    //         {
    //           "subheading": "Agreement",
    //           "points": [
    //             "Governs Gen AI Exchange Hackathon.",
    //             "Participants agree to Terms and Conditions."
    //           ]
    //         },
    //         {
    //           "subheading": "Organizer Rights",
    //           "points": [
    //             "Can cancel/postpone/change event details.",
    //             "No refund for personal expenses if canceled.",
    //             "Can amend terms without notice."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Personal Information",
    //       "subsections": [
    //         {
    //           "subheading": "Data Usage",
    //           "points": [
    //             "Registration details shared for communications."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Hackathon Rules",
    //       "subsections": [
    //         {
    //           "subheading": "Submission",
    //           "points": [
    //             "Submit registration via microsite.",
    //             "Organizer not liable for lost/damaged/incomplete entries or technical issues."
    //           ]
    //         },
    //         {
    //           "subheading": "Team Composition",
    //           "points": [
    //             "Team size must meet requirements.",
    //             "Each person can only register for one team."
    //           ]
    //         },
    //         {
    //           "subheading": "Team Names",
    //           "points": [
    //             "Teams pre-select name.",
    //             "Leader submits member details."
    //           ]
    //         },
    //         {
    //           "subheading": "Participation",
    //           "points": [
    //             "Team online participation required.",
    //             "Failure to engage may lead to disqualification."
    //           ]
    //         },
    //         {
    //           "subheading": "Demonstration",
    //           "points": [
    //             "Shortlisted teams pitch ideas.",
    //             "Specified time for demo and Q&A."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Team Prizes",
    //       "subsections": [
    //         {
    //           "subheading": "Prize Details",
    //           "points": [
    //             "Check the website.",
    //             "Prizes are non-transferable; winners pay taxes.",
    //             "Organizer can change prizes anytime."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Judging Criteria",
    //       "subsections": [
    //         {
    //           "subheading": "Selection",
    //           "points": [
    //             "Judges select winners; entrants release liability.",
    //             "Organizer can amend rules without notice.",
    //             "Final decision by Organizer.",
    //             "Based on hackathon stage; parameters may be declared."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Conduct Rules",
    //       "subsections": [
    //         {
    //           "subheading": "Compliance",
    //           "points": [
    //             "Comply with Terms, laws; no unlawful content.",
    //             "No third-party content without permission.",
    //             "Organizer's decisions are final.",
    //             "Judges' decisions are final.",
    //             "Stay on communication platform."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Additional Terms",
    //       "subsections": [
    //         {
    //           "subheading": "Awards/Cash Rewards",
    //           "points": [
    //             "Prizes non-transferable.",
    //             "Cash rewards within 60 days; TDS applies."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Recording Policy",
    //       "subsections": [
    //         {
    //           "subheading": "Authorization",
    //           "points": [
    //             "Organizer can publish photos/videos.",
    //             "Valid for 10 years globally."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Code of Conduct",
    //       "subsections": [
    //         {
    //           "subheading": "Harassment",
    //           "points": [
    //             "Support appropriate behavior by participants.",
    //             "Expect attendees, sponsors, volunteers, and staff to help make the Hackathon a place that welcomes and respects all Participants, regardless of race, gender, age, sexual orientation, disability, physical appearance, national origin, ethnicity, or religion.",
    //             "Expect all Participants to follow the Code of Conduct during the Hackathon.",
    //             "Thank participants for their help in keeping the Hackathon welcoming, respectful, and friendly."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Intellectual Property",
    //       "subsections": [
    //         {
    //           "subheading": "Rights",
    //           "points": [
    //             "Participant gives organizer a first refusal for exclusive license for 6 months",
    //             "Participants authorize the organizer to publish, communicate, to expose and to disclose, divulge and represent the submitted ideas verbally, graphically or in writing",
    //             "Results must not infringe any third party intellectual rights",
    //             "Participant must represent and warrant the following by accepting a prize."
    //           ]
    //         }
    //       ]
    //     },
    //     {
    //       "heading": "Copyright",
    //       "subsections": [
    //         {
    //           "subheading": "Eligibility",
    //           "points": [
    //             "Organizer may disqualify entries in violation of third party rights, law or regulation.",
    //             "Entries must be completed and submitted as described.",
    //             "For entries under 18, they must be accompanied by a parent or guardian",
    //             "Data security will be as per the rules & regulations mentioned under the IT Act 2008."
    //           ]
    //         }
    //       ]
    //     }
    //   ]
    // }""";

    //     final Map<String, dynamic> jsonObject = jsonDecode(simplifiedJsonString);
    //     final title = jsonObject['title'] ?? 'Untitled';
    //     final sections = jsonObject['sections'] as List<dynamic>? ?? [];

    //     return SingleChildScrollView(
    //       padding: const EdgeInsets.all(16),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             title,
    //             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    //           ),
    //           const SizedBox(height: 16),
    //           for (final section in sections)
    //             SectionWidget(section: section as Map<String, dynamic>),
    //         ],
    //       ),
    //     );
    //   }
  }
}
