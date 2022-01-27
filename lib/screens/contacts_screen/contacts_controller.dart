import 'package:assestment_telkom_fajar/commons/common_widgets/horizontal_divider.dart';
import 'package:assestment_telkom_fajar/models/contact.dart';
import 'package:assestment_telkom_fajar/models/get_contact_response.dart';
import 'package:assestment_telkom_fajar/repository/contact_repo.dart';
import 'package:assestment_telkom_fajar/screens/detail_contact_screen/detail_contact_screen.dart';
import 'package:assestment_telkom_fajar/screens/form_contact_screen/form_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  Rx<GetContactResponse> contactResponse = GetContactResponse().obs;

  fetchContactResponse({
    String search = "",
  }) async {
    try {
      contactResponse.value = await ContactRepo.getContact(search: search);
    } catch (e) {
      // print error
      print("Error: $e");
    }
  }

  openAddContact() async {
    var contact = await Get.to(() => const FormContactScreen());
    if (contact != null && contact is Contact) fetchContactResponse();
  }

  openEditContact({
    required Contact contact,
  }) async {
    var res = await Get.to(() => FormContactScreen(contact: contact));
    if (res != null) {
      var editedContact = res as Contact;
      if (editedContact != contact) fetchContactResponse();
    }
  }

  onDeleteContact({
    required Contact contact,
  }) async {
    try {
      var success = await ContactRepo.deleteContact(contact: contact);
      if (success) fetchContactResponse();
    } catch (e) {
      // print error
    }
  }

  onSearchContact({String textSearch = ""}) {
    fetchContactResponse(search: textSearch);
  }

  onItemTap({
    required BuildContext context,
    required Contact contact,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(modalContext);
                Get.to(() => DetailContactScreen(contact: contact));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Lihat Detail",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            InkWell(
              onTap: () {
                Navigator.pop(modalContext);
                openEditContact(contact: contact);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Edit Kontak",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            InkWell(
              onTap: () {
                Navigator.pop(modalContext);
                onDeleteContact(contact: contact);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Hapus Kontak",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
