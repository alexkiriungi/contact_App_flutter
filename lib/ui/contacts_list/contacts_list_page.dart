import 'package:contact_app/ui/contacts_list/widget/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../contact/contact_create_page.dart';
import '../model/contacts_model.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            // ignore: prefer_const_constructors
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: model.contacts.length,
              itemBuilder: (context, index) {
                return ContactTile(
                  contactIndex: index,
                  contact: null,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // ignore: prefer_const_constructors
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactCreatePage()),
          );
        },
      ),
    );
  }
}
