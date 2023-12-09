import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/imports.dart';
import 'package:gallery_saver/models/photo_Model.dart';
import 'package:gallery_saver/services/photo_service.dart';
import 'package:gallery_saver/widgets/app_Bar_Widget.dart';
import 'package:gallery_saver/widgets/circular_Indicator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAddPage extends StatefulWidget {
  const PhotoAddPage({super.key});

  @override
  State<PhotoAddPage> createState() => _PhotoAddPageState();
}

class _PhotoAddPageState extends State<PhotoAddPage> {

  final import = Imports();
  final photoService = PhotoService();

  bool isSave = false;

  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(import.colors.backgroundColor),
        body: Column(
          children: [
            AppBarWidget(text: "Fotoğraf Ekle", color: 0xff2961BF,),

            Expanded(
              child: isSave == false
                  ? SizedBox(
                width: import.phoneWidth*0.9,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () async {
                          selectedImages = await photoService.pickMultipleImages();
                          setState(() {

                          });
                        },
                        child: Text('Fotoğrafları seç', style: TextStyle(color: Color(import.colors.darkBlue)),),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.file(File(selectedImages[index].path)),
                          );
                        },
                      ),
                    ),

                    //KAYDET
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child:  InkWell(
                        child: Container(
                          width: import.phoneWidth * 0.66,
                          height: import.phoneHeight * 0.1,
                          color: Color(import.colors.darkBlue),
                          child: const Center(child: Text("KAYDET", style: TextStyle(color: Colors.white, fontSize: 25),)),
                        ),
                        onTap: () => save(),
                      ),
                    ),
                  ],
                ),
              )
                  : CircularIndicatorWidget(),
            ),

          ],
        ),
      ),

    );
  }

  void save()async{
    if(selectedImages.isNotEmpty){

      setState(() {
        isSave = true;
      });

      //Döküman için rastgele bir ID oluşturur.
      String docID = import.getRandomString(10);

      DateTime dateTime = DateTime.now();

      List<String> urlList = await photoService.uploadImages(selectedImages, docID);

      await photoService.savePhotoModelinFirebase(urlList, docID, dateTime);

      PhotoModel photoModel = photoService.makePhotoModel(urlList, docID, dateTime);

      //Burda state manengment olarak kullandığımız ve GetX ile oluşturduğumuz sınıfımızdaki listeye
      //yukarıdaki photoModel nesnesini atıyoruz.
      import.mainController.photoModelList.add(photoModel);
      import.mainController.photoModelBenchList.add(photoModel);

      //Son yüklenenden ilk yüklenene doğru sıralama işlemi
      import.mainController.photoModelList.sort((a,b)=>b.date!.compareTo(a.date!));
      import.mainController.photoModelBenchList.sort((a,b)=>b.date!.compareTo(a.date!));

      Get.back();
    }
  }
}
