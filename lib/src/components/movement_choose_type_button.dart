import 'package:flutter/material.dart';

class MovementChooseTypeButton extends StatelessWidget {
  const MovementChooseTypeButton(
      {super.key, this.onPressed, required this.icon, this.selected = false});

  final VoidCallback? onPressed;
  final Icon icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: selected ? null : Theme.of(context).primaryColorLight,
      ),
      child: icon,
    );
  }
}
