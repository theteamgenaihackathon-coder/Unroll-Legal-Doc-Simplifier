import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/network/gemini_requests.dart';
import 'package:legal_doc_simplifier/views/homepage/home_providers.dart';

void showDoubtDialog(BuildContext context, WidgetRef ref) {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Ask anything about the document...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Type your question here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () async {
                    final doubt = controller.text.trim();
                    Navigator.pop(ctx);

                    // Store in provider
                    ref.read(doubtProvider.notifier).state = doubt;

                    // Send to backend
                    try {
                      final response = await sendDoubtRequest(doubt);
                      print(response);
                      print("Gemini answered: $response");

                      // Optionally store response in another provider
                      // ref.read(doubtAnswerProvider.notifier).state = response;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Answer: $response")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Error: $e")));
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}
