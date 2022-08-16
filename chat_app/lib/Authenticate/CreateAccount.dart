import 'package:chat_app/Authenticate/LoginScree.dart';
import 'package:chat_app/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screens/MhomeScreen.dart';
import 'Methods.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _key = GlobalKey<FormState>();

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  late bool _sucess;
  late String _userEmail;
  bool _passwordVisible = false;

//For dropdown
  String dropdownValue = 'Student';

  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text))
        .user;

    if (user != null) {
      _sucess = true;
      _userEmail = user.email!;
    } else {
      setState(() {
        _sucess = false;
      });
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: const Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: const Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )
              ],
            ),
            Form(
              key: _key,
              child: Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextFormField(
                      controller: _email,
                      validator: validateEmail,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: _password,
                      validator: validatePassword,
                      decoration: const InputDecoration(
                          labelText: 'Password ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),

//DropDown Code

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.supervised_user_circle_rounded),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 3,
                  color: Colors.green,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Teacher', 'Student']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            //Dropdown Code Ends

            const SizedBox(height: 50.0),
            SizedBox(
              height: 40.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  if (_name.text.isNotEmpty &&
                      _email.text.isNotEmpty &&
                      _password.text.isNotEmpty) {
                    createAccount(
                      _name.text,
                      _email.text,
                      _password.text,
                      dropdownValue,
                    ).then((user) {
                      if (user != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => (LoginScreen())));
                        print("Account Created Sucessfull");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Login Failed'),
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
                        print("Login Failed");
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Please Enter Fields'),
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
                    print("Please Enter Fields");
                  }
                },
                child: const Text('Signup'),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 40.0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text('Go Back',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required.';
  }

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  return null;
}
