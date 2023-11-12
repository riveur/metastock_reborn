import 'package:flutter/material.dart';
import 'package:metastock_reborn/src/models/movement.dart';

class MovementItem extends StatelessWidget {
  const MovementItem({super.key, required this.movement});

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movement.type == "ENTRY"
          ? const Icon(Icons.add_circle_outline, size: 32)
          : const Icon(Icons.remove_circle_outline, size: 32),
      title: Text(
          "${movement.type == "ENTRY" ? "Entrée" : "Sortie"} (par ${movement.account.firstname})"),
      subtitle: Text(movement.comment),
      trailing: Text(
        "${movement.quantity}",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
