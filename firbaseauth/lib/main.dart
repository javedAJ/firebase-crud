// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // taskConroler its a textfield controler for inserting the data
  final TextEditingController _taskController = TextEditingController();

  final db = FirebaseFirestore.instance;

  late String task;

  //Inserting code with firebase

  void showdialog() {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text("Add todo"),
            content: Form(
              key: formkey,
              child: TextField(
                controller: _taskController,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task",
                ),
              ),
            ),
            actions: <Widget>[
              OutlineButton(
                onPressed: () {
                  // db
                  // .collection('task1')
                  // .add({'javed': "task"}).then((value) => print("object"));
                  db
                      .collection('task')
                      .add({'task': _taskController.text}).then((value) {
                    print("User Added");
                  }).catchError((er) {
                    print('er');
                  });

                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          );
        });
  }
  // inseting code completed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: showdialog,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.amber.shade800,
          title: Text("FIRESTORE WITH CRUD"),
        ),

        //Reteriving the data from the firebase

        body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('task').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Container(
                    child: ListTile(
                      title: Text(ds['task']),

                      //Delete from firebase

                      onLongPress: () {
                        // print(ds['task']); for printing task id
                        db.collection('task').doc(ds.id).delete()
                          ..then((value) => print("User Deleted")).catchError(
                              (error) =>
                                  print("Failed to delete user: $error"));
                      },

                      //update in firebase

                      onTap: () {
                        //Update
                        db
                            .collection('task')
                            .doc(ds.id)
                            .update({'task': "New Value"});
                        // showdialog(true, ds);
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return CircularProgressIndicator();
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
