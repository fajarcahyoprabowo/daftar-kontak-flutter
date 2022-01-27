import 'package:assestment_telkom_fajar/models/contact.dart';
import 'package:assestment_telkom_fajar/repository/contact_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class FormContactController extends GetxController {
  Contact formContact = const Contact();

  initScreen({
    required Contact? contact,
    required GlobalKey<FormBuilderState> formKey,
  }) {
    if (contact != null) {
      formContact = contact;
      formKey.currentState?.patchValue({
        'name': contact.name,
        'email': contact.email,
        'phoneNumber': contact.phoneNumber,
        'notes': contact.notes,
        'labels': contact.labels,
      });
    }
  }

  onSubmit({
    required GlobalKey<FormBuilderState> formKey,
    required bool isEdit,
  }) async {
    formKey.currentState?.save();
    if (formKey.currentState?.validate() == true) {
      formContact = formContact.copyWith(
        name: formKey.currentState?.value['name'],
        email: formKey.currentState?.value['email'],
        phoneNumber: formKey.currentState?.value['phoneNumber'],
        notes: formKey.currentState?.value['notes'],
        labels: formKey.currentState?.value['labels'] as List<String>,
      );

      if (!isEdit) {
        onAddContact(formContact);
      } else {
        onEditContact(formContact);
      }
    }
  }

  onAddContact(Contact contact) async {
    try {
      var success = await ContactRepo.addContact(contact: contact);
      if (success) {
        Get.back(result: formContact);
      }
    } catch (e) {
      // print error
    }
  }

  onEditContact(Contact contact) async {
    try {
      var success = await ContactRepo.updateContact(contact: contact);
      if (success) {
        Get.back(result: formContact);
      }
    } catch (e) {
      // print error
    }
  }
}
