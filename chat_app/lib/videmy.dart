// import 'package:chat_app/Authenticate/LoginScree.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'Screens/MhomeScreen.dart';
// import 'models/user_model.dart';

// class Videmy extends StatelessWidget {
//   Future<Widget> userSignedIn() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       DocumentSnapshot userData = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();
//       UserModel userModel = UserModel.fromJson(userData);
//       return MhomeScreen(userModel);
//     } else {
//       return LoginScreen();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: FutureBuilder(
//             future: userSignedIn(),
//             builder: (context, AsyncSnapshot<Widget> snapshot) {
//               if (snapshot.hasData) {
//                 return snapshot.data!;
//               }
//               return const Scaffold(
//                   body: Center(
//                 child: CircularProgressIndicator(),
//               ));
//             }));
//   }
// }
