import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreference/homeScreen.dart';
import 'package:sharedpreference/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FlatButton(
          child: Text(
            "Proceed",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.lightBlue,
          onPressed: () async {
            bool visitingFlag = await getVisitingFlag();
            setVisitingFlag();

            if (visitingFlag == true) {
              // it is the case when the user is visiting for not first
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            } else {
              //it is the case user visitng for the first time/
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            }
          },
        ),
      ),
    );
  }
}

setVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("alreadyVisited", true);
}

getVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool alreadyVisted = preferences.getBool("alreadyVisited") ?? false;
  return alreadyVisted;
}
