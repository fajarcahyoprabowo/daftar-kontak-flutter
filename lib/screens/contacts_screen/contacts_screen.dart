import 'package:assestment_telkom_fajar/commons/common_widgets/horizontal_divider.dart';
import 'package:assestment_telkom_fajar/commons/pallets.dart';
import 'package:assestment_telkom_fajar/models/contact.dart';
import 'package:assestment_telkom_fajar/screens/contacts_screen/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _searchFieldController = TextEditingController();
  late ContactsController _contactsController;

  @override
  void initState() {
    _contactsController = Get.put(ContactsController());
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _contactsController.fetchContactResponse();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Daftar Kontak",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _contactsController.openAddContact();
        },
        child: const Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            _SearchField(
              contactsController: _contactsController,
              searchFieldController: _searchFieldController,
            ),
            Expanded(
              child: _ContactList(
                contactsController: _contactsController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController searchFieldController;
  final ContactsController contactsController;

  const _SearchField({
    Key? key,
    required this.searchFieldController,
    required this.contactsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchFieldController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 13,
                    ),
                    hintText: "Cari...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IntrinsicHeight(
                child: ElevatedButton(
                  onPressed: () {
                    contactsController.onSearchContact(
                      textSearch: searchFieldController.text.trim(),
                    );
                  },
                  child: Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
        HorizontalDivider(color: Pallets.scorpion),
      ],
    );
  }
}

class _ContactList extends StatelessWidget {
  final ContactsController contactsController;

  const _ContactList({
    Key? key,
    required this.contactsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var contacts = contactsController.contactResponse.value.data;
        if (contacts?.length != null && contacts!.isNotEmpty) {
          return ListView.separated(
            itemCount: contacts.length,
            separatorBuilder: (_, __) {
              return const HorizontalDivider();
            },
            itemBuilder: (_, index) {
              return _ContactItem(
                contact: contacts[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(
              "Belum Ada Kontak",
              style: TextStyle(
                fontSize: 16,
                color: Pallets.scorpion,
              ),
            ),
          );
        }
      },
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Function()? onTap;
  final Contact contact;

  const _ContactItem({
    Key? key,
    this.onTap,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactsController contactsController = Get.find();

    return InkWell(
      onTap: () {
        contactsController.onItemTap(context: context, contact: contact);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.name ?? "-",
              style: TextStyle(
                fontSize: 16,
                color: Pallets.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              contact.labels.toString().replaceAll("[", "").replaceAll("]", ""),
              style: TextStyle(
                fontSize: 14,
                color: Pallets.scorpion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
