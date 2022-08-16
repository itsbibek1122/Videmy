import 'dart:io';

import 'package:chat_app/pdf/PDF.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/data_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  DataController controller = Get.put(DataController());

  var _pdfFile;

  var categoryC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> productData = {
    "p_name": "",
    "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    "p_product_description": "",
  };

  void _pickedPDF(File url) {
    _pdfFile = url;

    print("we got $_pdfFile");
  }

  addProduct() {
    if (_pdfFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Insert Failed'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Insert Successful'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ));
    }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Insert Successful'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ));

      print('Data for new product $productData');

      controller.addNewProduct(productData, _pdfFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Product Name Required';
                  }
                  return null;
                },
                onSaved: (value) {
                  productData['p_name'] = value!;
                },
              ),
              SizedBox(
                child: TextFormField(
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Description Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_description'] = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              PDF(_pickedPDF),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addProduct,
        label: const Text('Submit'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
