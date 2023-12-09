import 'package:get/get.dart';

class MainController extends GetxController {

  RxList photoModelList = [].obs;
  RxList photoModelBenchList = [].obs;

  DateTime startDate = DateTime(2023);
  DateTime endDate = DateTime.now();
}