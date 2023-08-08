import 'package:contact_app/Data/db/contact_dao.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../ui/Data/contact.dart';

class ContactsModel extends Model {
  final ContactDao _contactDao = ContactDao();
  // ignore: prefer_final_fields
  late List<Contact> _contacts;

  List<Contact> get contacts => _contacts;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future loadContacts() async {
    _isLoading = true;
    notifyListeners();

    _contacts = (await _contactDao.getAllInSortedOrder()).cast<Contact>();
    _isLoading = false;
    notifyListeners();
  }

  Future addContact(Contact contact) async {
    _contactDao.insert;
    await loadContacts();
    notifyListeners();
  }

  Future updateContact(Contact contact) async {
    _contactDao.update;
    await loadContacts();
    notifyListeners();
  }

  Future deleteContact(Contact contact) async {
    _contactDao.delete;
    await loadContacts();
    notifyListeners();
  }

  Future changeFavoriteStatus(Contact contact) async {
    contact.isFavorite = !contact.isFavorite;
    _contactDao.update;
    _contacts = (await _contactDao.getAllInSortedOrder()).cast<Contact>();
    notifyListeners();
  }
}
