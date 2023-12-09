import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/imports.dart';
import 'package:gallery_saver/models/photo_Model.dart';
import 'package:image_picker/image_picker.dart';

class PhotoService{

  final import = Imports();

  //Galerideki fotoğrafları seçmek için kullanılan fonksiyon.
  Future<List<XFile>> pickMultipleImages() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    return images;
  }

  //Seçtiğimiz fotoğrafları firebase'e yüklemek için kullanılan fonksiyon.
  Future<List<String>> uploadImages(List<XFile> images, String docID) async {
    List<String> imageUrls = [];

    int i = 0;

    for (var image in images) {

      //Kaydedilecek firebase uzantısı
      Reference storageReference = FirebaseStorage.instance.ref()
          .child(docID)
          .child("images/$i");

      //Firebase'e kaydetme işlemi
      UploadTask uploadTask = storageReference.putFile(File(image.path));

      //Yükleme işlemi bittiğinde kaydedilen image'ın url'ini oluşturup listeye atma işlemi
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();
        imageUrls.add(imageUrl);
      });

      i+=1;
    }

    return imageUrls;
  }

  //Oluşturulan linkleri burda PhotoModel nesnesine dönüştürüyoruz.
  PhotoModel makePhotoModel(List<String> urlList, String docID, DateTime dateTime){

    PhotoModel photoModel = PhotoModel(docID: docID, date: dateTime, urlList: urlList);

    return photoModel;
  }

  //Oluşan PhotoModel nesnesini Firebase kaydeden fonksiyon.
  Future<void> savePhotoModelinFirebase(List<String> urlList, String docID, DateTime dateTime)async{
    await import.firestore.collection("medias").doc(docID).set({
      'docID': docID,
      'date': dateTime,
      'urlList': urlList,
    });
  }


  //Firebaseden verileri çekip photoModel nesnelerine dönüştürüyoruz.
  Future<void> firebaseToPhotoModel() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("medias").get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      PhotoModel photoModel = PhotoModel.fromDocument(doc);
      import.mainController.photoModelList.add(photoModel);

      //Filtrelemede tüm verileri yedeklemek için kullanıyorum.
      import.mainController.photoModelBenchList.add(photoModel);

      //Son yüklenenden ilk yüklenene doğru sıralama işlemi
      import.mainController.photoModelList.sort((a,b)=>b.date!.compareTo(a.date!));
      import.mainController.photoModelBenchList.sort((a,b)=>b.date!.compareTo(a.date!));
    }
  }
}