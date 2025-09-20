class MissingField {
  final String location;
  final String example;
  final String reason;
  final String field;

  MissingField({
    required this.location,
    required this.example,
    required this.reason,
    required this.field,
  });

  factory MissingField.fromJson(Map<String, dynamic> json) {
    print(json);
    return MissingField(
      example: json['example'] ?? '',
      location: json['location'] ?? '',
      reason: json['reason'] ?? '',
      field: json['field'] ?? '',
    );
  }
}

class MissingFieldsResponse {
  final List<MissingField> missingFields;

  MissingFieldsResponse({required this.missingFields});

  factory MissingFieldsResponse.fromJson(List<dynamic> json) {
    var list = json as List? ?? [];
    List<MissingField> fields = list
        .map((item) => MissingField.fromJson(item))
        .toList();

    return MissingFieldsResponse(missingFields: fields);
  }
}
