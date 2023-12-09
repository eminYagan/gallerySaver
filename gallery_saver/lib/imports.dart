import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/constants/colors.dart';
import 'package:gallery_saver/controllers/main_Controller.dart';
import 'package:gallery_saver/widgets/show_Photos_Widget.dart';
import 'package:get/get.dart';


class Imports{

  final colors = AppColors();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final mainController = Get.put(MainController());
  final showPhotoWidget = ShowPhotosWidget();

  double phoneWidth = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  double phoneHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  static const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));


}