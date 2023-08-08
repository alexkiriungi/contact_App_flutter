import 'package:contact_app/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

import '../../../Data/contact.dart';

// ignore: use_key_in_widget_constructors
class ContactEditPage extends StatelessWidget {
  final Contact editedContact;

  // ignore: prefer_const_constructors_in_immutables
  ContactEditPage({Key? key, required this.editedContact}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Edit'),
      ),
      body: ContactForm(
        editedContact: editedContact,
      ),
    );
  }
}
