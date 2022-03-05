
import 'package:flutter/material.dart';

class AppState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void setState(VoidCallback voidCallback) {
    if (mounted) {
      super.setState(voidCallback);
    }
  }
}
