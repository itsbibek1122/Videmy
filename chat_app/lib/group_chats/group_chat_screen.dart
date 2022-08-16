import 'package:chat_app/group_chats/create_group/add_members.dart';
import 'package:chat_app/group_chats/group_chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({Key? key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser;
  var userRole;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  List groupList = [];

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
    getCurrentUserDetails();
  }

  Future getCurrentUserDetails() async {
    setState(() {
      isLoading = true;
    });

    var details = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get();

    // print("User Details" "$userDetails[email]");
    var userInfo = details.data();
    setState(() {
      isLoading = false;
      userRole = userInfo!["user_role"];
    });
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: isLoading
          ? Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: groupList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GroupChatRoom(
                        groupName: groupList[index]['name'],
                        groupChatId: groupList[index]['id'],
                      ),
                    ),
                  ),
                  leading: const Icon(Icons.group),
                  title: Text(groupList[index]['name']),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: userRole == "Student"
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddMembersInGroup()),
                  );
                },
          child: userRole == "Teacher"
              ? const Icon(
                  Icons.person_add_alt,
                  color: Colors.white,
                )
              : Icon(
                  Icons.person_add_alt,
                  color: Colors.black12,
                )),
    );
  }
}
