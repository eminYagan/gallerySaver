import 'package:flutter/material.dart';
import 'package:gallery_saver/imports.dart';

class CircularIndicatorWidget extends StatelessWidget {
  CircularIndicatorWidget({super.key});

  final import = Imports();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Color(import.colors.darkBlue),),
    );
  }
}
