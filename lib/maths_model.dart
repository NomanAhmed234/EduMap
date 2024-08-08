import 'dart:convert';

class NumberFact {
  final int number;
  final String text;
  final String type;

  NumberFact({required this.number, required this.text, required this.type});

  // Factory constructor for creating a new NumberFact instance from a map
  factory NumberFact.fromMap(Map<String, dynamic> map) {
    return NumberFact(
      number: map['number'] ?? 0,
      text: map['text'] ?? '',
      type: map['type'] ?? '',
    );
  }

  // Factory constructor for creating a new NumberFact instance from a JSON string
  factory NumberFact.fromJson(String source) => NumberFact.fromMap(json.decode(source));

  // Method for converting a NumberFact instance to a map
  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'text': text,
      'type': type,
    };
  }

  // Method for converting a NumberFact instance to a JSON string
  String toJson() => json.encode(toMap());
}
