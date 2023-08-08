import 'package:contact_app/Data/contact.dart';
import 'package:contact_app/ui/contact/widget/contact_edit_page.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.contactIndex,
    required contact,
  }) : super(key: key);

  final int contactIndex;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
      // ignore: unused_local_variable
      final displayedcontact = model.contacts[contactIndex];
      return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => model.deleteContact(displayedcontact),
              icon: Icons.delete,
              label: 'Delete',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            )
          ],
        ),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) =>
                  _callPhoneNumber(context, displayedcontact.phoneNumber),
              icon: Icons.phone,
              label: 'Call',
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            SlidableAction(
              onPressed: (context) =>
                  _writeEmail(context, displayedcontact.email),
              icon: Icons.phone,
              label: 'Email',
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            )
          ],
        ),
        child: _buildContent(displayedcontact, model, context),
      );
    });
  }
}


 

Future _callPhoneNumber(BuildContext context, String number) async {
  final url = 'tel:$number';
  if (await url_launcher.canLaunchUrl(url as Uri)) {
    await url_launcher.launchUrl(url as Uri);
  } else {
    // ignore: prefer_const_constructors, unused_local_variable
    final snackbar = SnackBar(
      content: const Text('Cannot make a call'),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}


Future _writeEmail(BuildContext context, String emailAddress) async {
  final url = 'mailto:$emailAddress';
  if (await url_launcher.canLaunchUrl(url as Uri)) {
    await url_launcher.launchUrl(url as Uri);
  } else {
    // ignore: prefer_const_constructors, unused_local_variable
    final snackbar = SnackBar(
      content: const Text('Cannot write an email'),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

ListTile _buildContent(
    Contact displayedcontact, ContactsModel model, BuildContext context) {
  return ListTile(
    title: Text(displayedcontact.name),
    subtitle: Text(displayedcontact.email),
    leading: _buildCircleAvatar(displayedcontact),
    trailing: IconButton(
        icon:
            Icon(displayedcontact.isFavorite ? Icons.star : Icons.star_border),
        color: displayedcontact.isFavorite ? Colors.amber : Colors.grey,
        onPressed: () {
          model.changeFavoriteStatus(displayedcontact);
        }),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ContactEditPage(editedContact: displayedcontact)));
    },
  );
}

Hero _buildCircleAvatar(Contact displayedcontact) => Hero(
    tag: displayedcontact.hashCode,
    child: CircleAvatar(child: _buildCircleAvatarContent(displayedcontact)));

Widget _buildCircleAvatarContent(Contact displayedcontact) {
  if (displayedcontact.imageFile == null) {
    return Text(displayedcontact.name[0]);
  } else {
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.file(
          displayedcontact.imageFile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

iconsSlideAction(
    {required String caption,
    required MaterialColor color,
    required Map onTap}) {}
