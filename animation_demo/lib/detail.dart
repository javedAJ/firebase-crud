import 'package:animation_demo/main.dart';
import 'package:flutter/material.dart';

class MyDetailPage extends StatefulWidget {
  late SuperHero _superHero;
  MyDetailPage(SuperHero superHero) {
    _superHero = superHero;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_superHero);
}

class _MyDetailPageState extends State<MyDetailPage> {
  late SuperHero _superHero;

  _MyDetailPageState(SuperHero superHero) {
    _superHero = superHero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_superHero.name)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Hero(
              tag: _superHero,
              child: Image.asset(
                _superHero.image,
                height: 250,
                width: 250,
              ),
            ),
          ),
          Text(
            _superHero.description,
            style: TextStyle(
                backgroundColor: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
