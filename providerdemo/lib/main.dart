// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'items_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Managment',
      //here is ChangeNotiferProvider declartion for the allocating ItemsProvider.dart amd HomePage()

      home: ChangeNotifierProvider.value(
        value: ItemsProvider(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Build Mehtod");
    final itemProvider = Provider.of<ItemsProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
            child: Text(
          "Provider State Managment",
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          padding: EdgeInsets.only(
            top: 30.0,
            left: 40,
            right: 40,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.blue,
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Name',
                ),
                controller: _textEditingController,
              ),
              OutlineButton(
                child: Text(
                  "Add Items",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                highlightedBorderColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  if (_textEditingController.text.isNotEmpty) {
                    itemProvider.addItems(_textEditingController.text);
                  }
                },
              ),
              Consumer<ItemsProvider>(
                builder: (context, value, child) => Expanded(
                  child: ListView.builder(
                    itemCount: value.getItemData.length,
                    itemBuilder: (_, index) => ListTile(
                      onTap: () {
                        value.incrementCount(index);
                      },
                      title: Text('${value.getItemData[index]['title']}'),
                      trailing: CircleAvatar(
                        child: Text('${value.getItemData[index]['count']}'),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
