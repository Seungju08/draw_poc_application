import 'package:flutter/material.dart';

class CustomColorButton extends StatelessWidget {
  final Color color;
  final Function() onTap;
  final bool isSelected;

  const CustomColorButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: isSelected ? 2 : 0.001, color: Colors.white),
        ),
      ),
    );
  }
}
