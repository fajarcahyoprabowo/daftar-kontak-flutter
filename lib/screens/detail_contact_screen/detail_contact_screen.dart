import 'package:assestment_telkom_fajar/models/contact.dart';
import 'package:flutter/material.dart';

class DetailContactScreen extends StatelessWidget {
  final Contact contact;
  const DetailContactScreen({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Kontak",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama: ${contact.name}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Email: ${contact.email}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "No Telepon: ${contact.phoneNumber}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Catatan: ${contact.notes}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Label: ${contact.labels.toString()}"
                  .replaceAll("[", "")
                  .replaceAll("]", ""),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
