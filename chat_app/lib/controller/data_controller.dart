import 'dart:io';

import 'package:chat_app/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var productid;
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {'fullName': '', 'email': ''};

  List<Product> allProduct = [];

  @override
  void onReady() {
    super.onReady();
    getAllProduct();
  }

// Method for get User profile

  //uploading products in firebase
  Future<void> addNewProduct(Map productdata, File url) async {
    var pathpdf = url.toString();
    var temper = pathpdf.lastIndexOf('/');
    var res = pathpdf.substring(temper + 1);

    print(res);

    final refer =
        FirebaseStorage.instance.ref().child('product_pdf').child(res);
    var pdfFile = await refer.putFile(url);
    print("Updated $pdfFile");
    var pickedurl = await refer.getDownloadURL();

    try {
      // CommanDialog.showLoading();
      var response =
          await FirebaseFirestore.instance.collection('productlist').add({
        'product_name': productdata['p_name'],
        "product_upload_date": productdata['p_upload_date'],
        "product_description": productdata['p_description'],
        'product_pdf': pickedurl,
        "product_id": productid,
      });
      productid = response.id;
      print(productid);
      // CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      // CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }

  Future<void> getAllProduct() async {
    allProduct = [];
    print("allProduct YEs $allProduct");
    try {
      // CommanDialog.showLoading();
      final List<Product> lodadedProduct = [];
      var response = await firebaseInstance.collection('productlist').get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
            print(result.data());
            lodadedProduct.add(
              Product(
                productpdf: result['product_pdf'],
                productname: result['product_name'],
                productuploaddate: result['product_upload_date'].toString(),
                productdescription: result['product_description'],
                productid: result['product_id'],
              ),
            );
          }
      }
      allProduct.addAll(lodadedProduct);
      update();
      // CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      // CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      // CommanDialog.hideLoading();
      print("error $error");
    }
  }
}
