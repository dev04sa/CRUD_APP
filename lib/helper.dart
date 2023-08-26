import 'package:flutter/material.dart';

class ShowData extends StatelessWidget {
  final String type;
  final bool isHeading;
  const ShowData({super.key, required this.type, this.isHeading = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        type,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: isHeading ? FontWeight.bold : FontWeight.w500,
            color: isHeading ? Colors.black : Colors.deepPurple,
            fontSize: 20),
      ),
    );
  }
}
