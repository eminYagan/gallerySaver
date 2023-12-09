import 'package:flutter/material.dart';
import 'package:gallery_saver/models/photo_Model.dart';
import 'package:intl/intl.dart';

class ShowPhotosWidget {

  //Bu widget PhotoModel nesnelerinin listelendiği widget.
  Widget buildPhotoContainer(PhotoModel photo) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd.MM.yyyy - HH:mm').format(photo.date),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          buildPhotoGrid(photo.urlList),
        ],
      ),
    );
  }

  //Bu widget bir PhotoModel nesnesinin içindeki fotoğrafların listelendiği widget.
  Widget buildPhotoGrid(List<String> urlList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: urlList.length,
      itemBuilder: (context, index) {
        return Image.network(
          urlList[index],
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color(0xff2961BF),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
        );
      },
    );
  }
}