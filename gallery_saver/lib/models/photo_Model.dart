import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoModel{

  String docID;
  DateTime date;
  List<String> urlList;

  PhotoModel({
    required this.docID,
    required this.date,
    required this.urlList,
  });

  factory PhotoModel.fromDocument(DocumentSnapshot doc){

    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['date'] as Timestamp;
    final dateTime = timestamp.toDate();

    return PhotoModel(
      docID: data['docID'],
      date: dateTime,
      urlList: List<String>.from(data['urlList']),
    );
  }
}