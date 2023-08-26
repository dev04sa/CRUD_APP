import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController controllar;
  final String FiledType;
  final String icon;
  final void Function(String)? change;

  const TextBox(
      {super.key,
      required this.FiledType,
      required this.icon,
      required this.controllar,
      this.change});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: TextFormField(
        controller: controllar,
        onChanged: change,
        decoration: InputDecoration(
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: FiledType,
            hintStyle: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Image.asset("assets/images/${icon}")),
            )),
      ),
    );
  }
}
