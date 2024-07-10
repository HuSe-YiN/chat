import 'package:flutter/material.dart';

extension NumExt on num {
  SizedBox get width => SizedBox(
        width: toDouble(),
      );
  SizedBox get height => SizedBox(
        height: toDouble(),
      );
}

extension ContextExt on BuildContext {
  void push(Widget widget) => Navigator.push(this, MaterialPageRoute(builder: (context) => widget));
  void pushAndRemoveUntil(Widget widget) => Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (context) => widget), (route) => false);
}
