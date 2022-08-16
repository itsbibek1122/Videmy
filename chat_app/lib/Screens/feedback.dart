import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final Stream<QuerySnapshot> user =
      FirebaseFirestore.instance.collection('feedback').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Write feedback',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            MyCustomForm()
          ],
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  var name = '';
  var description = '';
  CollectionReference feedback =
      FirebaseFirestore.instance.collection('feedback');
  Future getAllData() async {
    var data = feedback.doc().snapshots();
    print(data);
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'what\'s your name?',
              labelText: 'Name',
            ),
            onChanged: (value) {
              name = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.article),
              hintText: 'what\'s your feedback?',
              labelText: 'Description',
            ),
            onChanged: (value) {
              description = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('sending data to cloud firestore'),
                    ),
                  );
                  feedback
                      .add({'name': name, 'description': description})
                      .then((value) => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("success"),
                              content: const Text('feedback successfully submitted '),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('ok'))
                              ],
                            );
                          }))
                      .catchError((error) => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("failed"),
                              content: const Text('failed to submit feedback'),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('ok'))
                              ],
                            );
                          }));
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
