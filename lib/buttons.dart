import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String Btntext;
  final Color color;
  final void Function()? onclick;

  const Buttons(
      {super.key, required this.Btntext, required this.color, this.onclick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onclick,
        child: Text(
          Btntext,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
