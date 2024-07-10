import 'package:flutter/material.dart';

class TextBouble extends StatelessWidget {
  final String message;
  final bool isSender ;
  const TextBouble({super.key, required this.message,  this.isSender = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.grey.shade400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: isSender ? Colors.blue : Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message, style: TextStyle(color: isSender ? Colors.white : Colors.black),),
      ),
    );
  }
}
