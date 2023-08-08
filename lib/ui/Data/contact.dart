// ignore: unused_import
import 'dart:io';
// ignore: unused_import
import 'package:meta/meta.dart' show required;

class Contact {
  late int id;
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  File imageFile;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    required this.imageFile,
  });
//Map literals are created with curly brackets{}
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isFavorite': isFavorite ? 1 : 0,
      'imageFilePath': imageFile.path,
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
        name: map['name'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        isFavorite: map['isFavorite'] == 1 ? true : false,
        imageFile: File(map['imageFilePath']));
  }
}
