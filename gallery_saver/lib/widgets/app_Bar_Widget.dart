// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:gallery_saver/imports.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final int color;

  final import = Imports();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: import.phoneWidth,
      height: import.phoneHeight*0.12,
      color: Color(color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
            child: SizedBox(
                width: import.phoneWidth*0.23,
                height: import.phoneHeight*0.12,
                child: Transform.scale(scale: 1.5, child: const Icon(Icons.arrow_back, color: Colors.white,))),
            onTap: ()=>Get.back(),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(text,style: const TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'AllianceMedium',),),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Transform.scale(scale: 1.5, child: const Icon(Icons.camera_alt_outlined, color: Colors.white,)),
              ),
            ],
          ),

        ],
      ),

    );
  }
}