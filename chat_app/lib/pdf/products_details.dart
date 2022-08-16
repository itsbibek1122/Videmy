import 'package:chat_app/pdf/View.dart';
import 'package:flutter/material.dart';

class ProductsDetailsPage extends StatefulWidget {
  static const id = 'productsdetail';

  @override
  State<ProductsDetailsPage> createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  // var isFavorite;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    var name = data['productname'];
    var category = data['productcategory'];

    var pdf = data['productpdf'];
    var description = data['productdescription'];
    var uploaddate = data['productuploaddate'];

    var productid = data['productid'];

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   title: Text(name),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/detailsphoto.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 400,
                        child: Flexible(
                          child: Text(name,
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    size: 35,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ]),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(15.0),
              child: Column(children: [
                Text(description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    )),
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // onPressed: (() {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: ((context) => View(
        //             file: pdf,
        //           )),
        //     ),
        //   );
        // }),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => View(file: pdf)),
          );
        },

        label: const Text('Read'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
