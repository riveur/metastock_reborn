import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  String id;
  String firstname;
  String lastname;
  dynamic matricule;
  bool archive;
  String role;

  Account({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.matricule,
    required this.archive,
    required this.role,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        matricule: json["matricule"],
        archive: json["archive"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "matricule": matricule,
        "archive": archive,
        "role": role,
      };
}
