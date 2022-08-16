import 'package:chat_app/Screens/ChatRoom.dart';
import 'package:chat_app/Screens/SearchScreen.dart';
import 'package:chat_app/Screens/MhomeScreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GreetingScreen extends StatefulWidget {
  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  bool isLoading = false;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List chatRooms = [];
  final List<UserModel> allUsers = [];
  var finalChats = [];
  @override
  void initState() {
    getAllChatRoom();
    // TODO: implement initState
  }

  Future getAllChatRoom() async {
    // CollectionReference documentReference = _collectionRef.doc('Sitaram').collection('chats');
    setState(() {
      isLoading = true;
    });
    String? userName = _auth.currentUser?.displayName;
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // var userList = querySnapshot.docs.map((doc) => doc.data());
    // print(userList[0]);
    var data = querySnapshot.docs
        .map((doc) => UserModel(
            uid: doc['uid'],
            email: doc['email'],
            name: doc['name'],
            status: doc['status']))
        .toList();
    print(data);
    //
    //userchatList.add(userList.map((e) => UserModel.fromJson(e as Map<String,dynamic>)));
    // Map<String,dynamic> value1 = userList.first as Map<String,dynamic>;
    //  print(userchatList.iterator);
    for (var i = 0; i < data.length; i++) {
      var currentUser = _auth.currentUser!.displayName;
      if (data[i].name![0].toLowerCase().codeUnits[0] >
          currentUser!.toLowerCase().codeUnits[0]) {
        chatRooms.add('${data[i].name}$currentUser');
      } else {
        chatRooms.add("$currentUser${data[i].name}");
      }
    }
    chatRooms.remove('$userName$userName');
    final CollectionReference chatRoomRef =
        FirebaseFirestore.instance.collection('chatroom');
    var chattttt = await chatRoomRef.get();
    print(chattttt);
    List chats = [];
    for (var i = 0; i < chatRooms.length; i++) {
      QuerySnapshot rooms =
          await chatRoomRef.doc(chatRooms[i]).collection("chats").get();
      // var roomList = rooms.docs.map((doc) => UserModel( uid: doc['uid'],
      //       email: doc['email'],
      //       name: doc['name'],
      //       status: doc['status'])).toList();
      chats.add(rooms.docs);
      print("before" "$chats");
    }

    for (var i = 0; i < chats.length; i++) {
      if (!chats[i].isEmpty) {
        finalChats.add(chatRooms[i]);
      }
    }
    print("after" "$chats");
    // print(chatRooms);

    // to get all user list
    var users = await FirebaseFirestore.instance.collection('users').get();
    var userData = querySnapshot.docs
        .map((doc) => UserModel(
            uid: doc['uid'],
            email: doc['email'],
            name: doc['name'],
            status: doc['status']))
        .toList();
    allUsers.addAll(userData);
    allUsers.removeWhere(((element) => element.name == userName));
    print(allUsers);
    setState(() {
      isLoading = false;
    });
  }
  // Future getChatRoom()async{

  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Videmy',
      home: Scaffold(
        body: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Chats",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        children: [
                          for (var i = 0; i < allUsers.length; i++)
                            for (var j = 0; j < finalChats.length; j++)
                              if (finalChats[j].contains(allUsers[i].name!))
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      // String roomId = chatRoomId(
                                      //     _auth.currentUser!.displayName!,
                                      //     userMap!['name']);
                                      //   print(roomId);

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ChatRoom(
                                            chatRoomId: finalChats[j],
                                            userMap: {
                                              "uid": allUsers[i].uid,
                                              "status": allUsers[i].status,
                                              "email": allUsers[i].status,
                                              "name": allUsers[i].name
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    leading: Column(children: const [
                                      Icon(Icons.account_box,
                                          color: Colors.black),
                                      // allUsers[i].status == "Online"
                                      //     ? Row(
                                      //         children: const [
                                      //           Radio(
                                      //               value: 'active',
                                      //               groupValue: 'active',
                                      //               onChanged: null),
                                      //           Text("(Online)"),
                                      //         ],
                                      //       )
                                      //     : Row(
                                      //         children: const [
                                      //           Radio(
                                      //               value: 'active',
                                      //               groupValue: 'inactive',
                                      //               onChanged: null),
                                      //           Text("(Offline)"),
                                      //         ],
                                      //       )
                                    ]),
                                    title: Text(
                                      allUsers[i].name!,
                                      //userMap!['name'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(allUsers[i].email!),
                                    trailing:
                                        Icon(Icons.chat, color: Colors.black),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? status;
  String? lastMessage;
  UserModel({this.uid, this.name, this.email, this.status, this.lastMessage});

  UserModel.fromJson(Map<String, dynamic> data) {
    uid = data['name'];
    name = data['uid'];
    email = data['email'];
    status = data['status'];
  }
}
