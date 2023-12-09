// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gallery_saver/imports.dart';
import 'package:gallery_saver/models/photo_Model.dart';
import 'package:gallery_saver/pages/photo_Add_Page.dart';
import 'package:gallery_saver/services/photo_service.dart';
import 'package:gallery_saver/services/time_Service.dart';
import 'package:gallery_saver/widgets/app_Bar_Widget.dart';
import 'package:gallery_saver/widgets/circular_Indicator.dart';
import 'package:get/get.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {

  final import = Imports();
  final photoService = PhotoService();
  final timeService = TimeService();

  bool loading = true;

  void getPhotos()async{
    await photoService.firebaseToPhotoModel();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(import.colors.backgroundColor),
        body: loading == false
            ? Stack(
          children: [
            Column(
              children: [
                AppBarWidget(text: "Fotoğraf Lİstesi", color: 0xff2961BF,),

                Expanded(
                  child: Obx(() => SizedBox(
                    width: import.phoneWidth*0.9,
                    child: Column(
                      children: [

                        //Tarih aralığı seçmek için kullanılan widget
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: ()async{
                              import.mainController.startDate = DateTime.now();
                              await timeService.selectDateAndTime(context);
                            },
                            child: Container(
                              width: import.phoneWidth * 0.9,
                              height: import.phoneHeight * 0.07,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: SizedBox(
                                      width: import.phoneWidth * 0.65,
                                      height: import.phoneHeight * 0.032,
                                      //color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${import.mainController.startDate.day}.${import.mainController.startDate.month}.${import.mainController.startDate.year} - ${import.mainController.startDate.hour}:${import.mainController.startDate.minute}", style: const TextStyle(color:Color(0xff8A939b), fontSize: 12),),
                                          Text("${import.mainController.endDate.day}.${import.mainController.endDate.month}.${import.mainController.endDate.year} - ${import.mainController.endDate.hour}:${import.mainController.endDate.minute}", style: const TextStyle(color:Color(0xff8A939b), fontSize: 12),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text("Tarih aralığı gir", style: TextStyle(color: Color(import.colors.darkBlue).withOpacity(0.7),fontSize: 16,fontFamily: "AllianceMedium"),)
                                ],
                              ),
                            ),
                          ),
                        ),

                        //Seçilen tarih aralığını uygulamak için kullanılan widget.
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: (){
                              import.mainController.photoModelList.clear();
                              for(PhotoModel photoModel in import.mainController.photoModelBenchList){
                                if(photoModel.date.isAfter(import.mainController.startDate) && photoModel.date.isBefore(import.mainController.endDate.add(const Duration(microseconds: 1)))){
                                  import.mainController.photoModelList.add(photoModel);
                                }
                              }

                            },
                            child: Container(
                              width: import.phoneWidth * 0.9,
                              height: import.phoneHeight * 0.07,
                              color: Colors.white,
                              child: const Center(child: Text("Tarih aralığı ara", style: TextStyle(color: Color(0XFF8A939B),fontSize: 20,fontFamily: "AllianceMedium"),)),
                            ),
                          ),
                        ),

                        //Fotoğrafları listeleyen widget.
                        SizedBox(
                          width: import.phoneWidth*0.9,
                          height: import.phoneHeight*0.6,
                          child: ListView.builder(
                            itemCount: import.mainController.photoModelList.length,
                            itemBuilder: (context, index) {
                              return import.showPhotoWidget.buildPhotoContainer(import.mainController.photoModelList[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),),
                ),

              ],
            ),

            //Fotoğraf ekleme sayfasına gitmek için kullanılan widget.
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 19, bottom: 19),
                child: InkWell(
                  onTap: ()=>Get.to(()=>const PhotoAddPage()),
                  child: Container(
                    width: import.phoneWidth*0.24,
                    height: import.phoneWidth*0.24,
                    color: Color(import.colors.green),
                    child: Transform.scale(scale: 3,child: const Icon(Icons.add, color: Colors.white,)),
                  ),
                ),
              ),
            ),

          ],
        )
            : CircularIndicatorWidget(),
      ),

    );
  }


}

