import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class AppDataBase {
  //The only available instance of the AppDatabase is stored in private field
  static final AppDataBase _singleton = AppDataBase._();

  // This instance get-only property is how other claasess can access the single AppDatabase object.
  static AppDataBase get instance => _singleton;

  Completer<Database>? _dbOpenCompleter;
  //This is a singleton- invoking a private constructor- only a single instance
  AppDataBase._();

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDataBase();
    }
    return _dbOpenCompleter!.future;
  }

  Future _openDataBase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'contacts.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter?.complete(database);
  }
}
