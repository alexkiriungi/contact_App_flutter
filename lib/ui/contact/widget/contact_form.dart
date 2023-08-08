import 'dart:io';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../Data/contact.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class ContactForm extends StatefulWidget {
  final Contact? editedContact;

  // ignore: prefer_const_constructors_in_immutables
  ContactForm({Key key = const Key("any_key"), this.editedContact})
      : super(key: key);
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
// ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  late String _name;
  // ignore: unused_field
  late String _email;
  // ignore: unused_field
  late String _phoneNumber;

  File? _contactImageFile;

  // ignore: unnecessary_null_comparison
  bool get isEditMode => widget.editedContact != null;
  // ignore: unnecessary_null_comparison
  bool get hasSelectedCustomImage => _contactImageFile != null;

  @override
  void initState() {
    super.initState();
    _contactImageFile = widget.editedContact?.imageFile;
  }

  get color => null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        const SizedBox(height: 15),
        _buildContactPicture(),
        const SizedBox(height: 15),
        TextFormField(
          validator: _validateName,
          initialValue: widget.editedContact?.name,
          onSaved: (value) => _name = value!,
          decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
        const SizedBox(height: 15),
        TextFormField(
          validator: _validateEmail,
          initialValue: widget.editedContact?.email,
          onSaved: (value) => _email = value!,
          decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
        const SizedBox(height: 15),
        TextFormField(
          validator: _validatePhoneNumber,
          initialValue: widget.editedContact?.phoneNumber,
          onSaved: (value) => _phoneNumber = value!,
          decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: _onSaveContactButtonPressed,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('SAVE'),
              Icon(
                Icons.person,
                size: 18,
                color: Colors.white,
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 2;
    return Hero(
      tag: widget.editedContact.hashCode,
      child: GestureDetector(
        onTap: _onContactPictureTapped,
        child: CircleAvatar(
          radius: halfScreenDiameter / 2,
          child: _buildCircleAvatarContent(halfScreenDiameter),
        ),
      ),
    );
  }

  void _onContactPictureTapped() async {
    // ignore: unused_local_variable
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
      _contactImageFile ;
    });
    // ignore: avoid_print
  }

  Widget _buildCircleAvatarContent(double halfScreenDiameter) {
    if (isEditMode || hasSelectedCustomImage) {
      // ignore: unnecessary_null_comparison
      return _buildEditModeCircleAvatarContent(halfScreenDiameter);
    } else {
      return Icon(Icons.person, size: halfScreenDiameter / 2);
    }
  }

  Widget _buildEditModeCircleAvatarContent(double halfScreenDiameter) {
    // ignore: unnecessary_null_comparison
    if (_contactImageFile == null) {
      return Text(widget.editedContact!.name[0],
          style: TextStyle(fontSize: halfScreenDiameter / 2));
    } else {
      return ClipOval(
          child: AspectRatio(
        aspectRatio: 1,
        child: Image.file(
          _contactImageFile!,
          fit: BoxFit.cover,
        ),
      ));
    }
  }

  // ignore: unused_element
  static String? _validateName(String? value) {
    if (value!.isEmpty) {
      return 'Enter a name';
    }
    return null;
  }

  static String? _validateEmail(String? value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
    if (value!.isEmpty) {
      return 'Enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? _validatePhoneNumber(String? value) {
    final emailRegex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-)]');
    if (value!.isEmpty) {
      return 'Enter a Phone Number';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid Phone Number';
    }
    return null;
  }

  void _onSaveContactButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var newContact = Contact(
        name: _name,
        email: _email,
        phoneNumber: _phoneNumber,
        //elvis operator?. returns null if editedContact is null
        //Null coalescing opeartor(??)
        //If the left side is null, it returns the right side
        isFavorite: widget.editedContact?.isFavorite ?? true,
        imageFile: _contactImageFile,
      );
      // ignore: unnecessary_null_comparison
      if (isEditMode) {
        newContact = widget.editedContact?.id as Contact;
        ScopedModel.of<ContactsModel>(context).updateContact(newContact);
      } else {
        ScopedModel.of<ContactsModel>(context).addContact(newContact);
      }
      Navigator.of(context).pop();
    }
  }
}
