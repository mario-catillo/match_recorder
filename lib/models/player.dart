import 'dart:convert';

import 'package:match_recorder/models/serializable.dart';

class Player implements Serializable {
  final String name;
  String number;

  Player({required this.name, required this.number});

  @override
  String toJson() {
    return jsonEncode({
      'name': name,
      'number': number,
    });
  }

  @override
  Player.fromJson(String json)
      : name = jsonDecode(json)['name'],
        number = jsonDecode(json)['number'];
}
