import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool mode;
  final void Function()? onTap;
  final int activeAlpha = 100;
  final int inactiveAlpha = 50;
  final String? title;
  final double? horizontalPad;
  const AppButton({
    super.key,
    required this.mode,
    this.onTap,
    this.title,
    this.horizontalPad,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: horizontalPad ?? 12,
        ),
        decoration: BoxDecoration(
          color:
              mode
                  ? Colors.greenAccent.withAlpha(activeAlpha)
                  : Colors.greenAccent.withAlpha(inactiveAlpha),
        ),
        child: Text(
          title ?? "",
          style: TextStyle(
            fontWeight: (mode) ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
