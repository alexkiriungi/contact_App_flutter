import 'dart:io';

import 'package:meta/meta.dart' show required;

class Contact {
  late int id;
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;

  Contact({
    @required required this.name,
    @required required this.email,
    @required required this.phoneNumber,
    this.isFavorite = false, File? imageFile,
  });

  get imageFile => null;

}
