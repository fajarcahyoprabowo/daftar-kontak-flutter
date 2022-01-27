import 'package:assestment_telkom_fajar/models/contact.dart';
import 'package:assestment_telkom_fajar/screens/form_contact_screen/form_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class FormContactScreen extends StatefulWidget {
  final Contact? contact;

  const FormContactScreen({
    Key? key,
    this.contact,
  }) : super(key: key);

  @override
  _FormContactScreenState createState() => _FormContactScreenState();
}

class _FormContactScreenState extends State<FormContactScreen> {
  final FormContactController formContactController =
      Get.put(FormContactController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      formContactController.initScreen(
        contact: widget.contact,
        formKey: _formKey,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.contact == null ? "Tambah Kontak" : "Edit Kontak",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(
                  labelText: "Nama",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    context,
                    errorText: "Nama harus diisi",
                  ),
                  FormBuilderValidators.minLength(
                    context,
                    3,
                    errorText: "Nama harus lebih dari 3 huruf",
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(
                  labelText: "Email",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    context,
                    errorText: "Nama harus diisi",
                  ),
                  FormBuilderValidators.email(
                    context,
                    errorText: "Email yang dimasukkan tidak valid",
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'phoneNumber',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "No. Telepon",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    context,
                    errorText: "No Telepon harus diisi",
                  ),
                  FormBuilderValidators.numeric(
                    context,
                    errorText: "No Telepon harus berupa angka",
                  ),
                  FormBuilderValidators.minLength(
                    context,
                    8,
                    errorText: "No Telepon minimal harus 8 angka",
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'notes',
                maxLines: 5,
                minLines: 1,
                decoration: InputDecoration(
                  labelText: "Catatan",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    context,
                    errorText: "Catatan harus diisi",
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderCheckboxGroup(
                name: 'labels',
                validator: (selected) {
                  if (selected == null || selected.isEmpty) {
                    return "Label harus diisi";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Label",
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                options: [
                  FormBuilderFieldOption(
                    value: "Teman Kantor",
                  ),
                  FormBuilderFieldOption(
                    value: "Teman Kecil",
                  ),
                  FormBuilderFieldOption(
                    value: "Teman SMA",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  formContactController.onSubmit(
                    formKey: _formKey,
                    isEdit: widget.contact == null ? false : true,
                  );
                },
                child: Text(
                  widget.contact == null ? "Tambah Kontak" : "Edit Kontak",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
