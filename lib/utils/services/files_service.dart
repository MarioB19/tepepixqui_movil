import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class FilesService {
  static Future<List<String>> uploadFiles(List<File> files) async {
    List<String> urls = [];
    for (var file in files) {
      try {
        String url = await _uploadFile(file);
        urls.add(url);
      } catch (e) {
        print('Error uploading file: $e');
      }
    }
    return urls;
  }

  static Future<String> _uploadFile(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('imagesIncendios/$fileName');
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() => print('File uploaded: $fileName'));
      String fileURL = await storageReference.getDownloadURL();
      return fileURL;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
