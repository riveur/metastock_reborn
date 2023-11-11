import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton(
      {super.key, required this.onPressed, required this.controller});

  final void Function()? onPressed;
  final ScrollController controller;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible) {
          setState(() {
            isVisible = false;
          });
        }
      } else {
        if (!isVisible) {
          setState(() {
            isVisible = true;
          });
        }
      }
    });
    super.initState();
  }

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          isExtended: isVisible,
          onPressed: widget.onPressed,
          child: const Icon(Icons.add),
        ));
  }
}
