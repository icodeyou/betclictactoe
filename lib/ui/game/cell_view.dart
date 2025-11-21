import 'package:flutter/material.dart';

class CellView extends StatelessWidget {
  const CellView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(child: Text('X')),
    );
  }
}
