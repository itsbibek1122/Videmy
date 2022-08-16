import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text("All Users"),
              leading: MaterialButton(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("Loading"));
                  }

                  if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: [
                        SliverList(
                            delegate: SliverChildListDelegate(
                          snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return ListTile(
                                  leading: const Icon(Icons.account_circle),
                                  title: Text(data['name']),
                                  subtitle: Text(data['email']),
                                  selectedTileColor: Colors.green[400],
                                  onTap: () {},
                                );
                              })
                              .toList()
                              .cast(),
                        ))
                      ],
                    );
                  }

                  return Container();
                })));
  }
}




            // body: CustomScrollView(
            //   slivers: [
            //     SliverList(
            //         delegate: (SliverChildListDelegate(
            //       [
            //         ListTile(
            //           leading: Icon(Icons.account_circle),
            //           title: Text("Codesinsider"),
            //           selectedTileColor: Colors.green[400],
            //           onTap: () {
            //             setState(() {});
            //           },
            //         ),
            //       ],
            //     )))
            //   ],
            // )));
  