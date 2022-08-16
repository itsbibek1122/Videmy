import 'package:chat_app/controller/data_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'add-product.dart';
import 'products_details.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser;
  var userRole;

  final DataController controller = Get.put(DataController());
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    getCurrentUserDetails();
    super.initState();
    // TODO: implement initState

    // currentUser = _collectionRef.doc(_auth.currentUser?.uid).get();

    print(currentUser);
  }

  Future getCurrentUserDetails() async {
    var details = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get();
    // print("User Details" "$userDetails[email]");
    var userInfo = details.data();
    setState(() {
      userRole = userInfo!["user_role"];
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getAllProduct();
    });
    return Scaffold(
      body: StreamBuilder(
          stream: db.collection('productlist').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(msg: "error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final values = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 140.0,
              ),
              itemCount: values.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Card(
                      //   child: SizedBox(
                      //     width: 300,
                      //     height: 200,
                      //     child: Center(
                      //         child: Text(
                      //       values[index]['product_name'],
                      //     )),
                      //   ),
                      // ),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.book),
                              title: Text(
                                values[index]['product_name'],
                              ),
                              subtitle: Text(
                                values[index]['product_description'],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('Read'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      ProductsDetailsPage.id,
                                      arguments: {
                                        "productname": values[index]
                                            ['product_name'],
                                        "productpdf": values[index]
                                            ['product_pdf'],
                                        "productdescription": values[index]
                                            ['product_description'],
                                        "productupload": values[index]
                                            ['product_upload_date'],
                                        "productid": values[index]
                                            ["product_id"],
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // userRole == "Student"
                      //     ? GestureDetector(
                      //         onTap: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => AddProduct()),
                      //           );
                      //         },
                      //         child: Container(
                      //             decoration: BoxDecoration(
                      //               color: Colors.blue,
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             height: 70,
                      //             width: 70,
                      //             child: Center(
                      //               child: Icon(
                      //                 Icons.book,
                      //                 color: Colors.black,
                      //               ),
                      //             )),
                      //       )
                      //     : SizedBox()
                    ],
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: userRole == "Student"
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddProduct()),
                  );
                },
          child: userRole == "Teacher"
              ? const Icon(
                  Icons.book,
                  color: Colors.white,
                )
              : Icon(
                  Icons.book,
                  color: Colors.black12,
                )),
    );
  }
}
