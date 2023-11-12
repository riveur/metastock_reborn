import 'dart:convert';

import 'package:metastock_reborn/src/models/account.dart';

Movement movementFromJson(String str) => Movement.fromJson(json.decode(str));

String movementToJson(Movement data) => json.encode(data.toJson());

class Movement {
  int id;
  int quantity;
  String comment;
  String? date;
  String type;
  Account account;

  Movement({
    required this.id,
    required this.quantity,
    required this.comment,
    this.date,
    required this.type,
    required this.account,
  });

  factory Movement.fromJson(Map<String, dynamic> json) => Movement(
        id: json["id"],
        quantity: json["quantity"],
        comment: json["comment"],
        date: json["date"],
        type: json["type"],
        account: Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "comment": comment,
        "date": date,
        "type": type,
        "account": account.toJson(),
      };
}
