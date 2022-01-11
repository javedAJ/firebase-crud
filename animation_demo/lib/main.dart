// ignore_for_file: unnecessary_new

import 'package:animation_demo/detail.dart';
import 'package:flutter/material.dart';
import 'detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Marvel Super Heros '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SuperHero {
  late String image;
  late String name;
  late String description;

  SuperHero(String image, String name, String description) {
    this.image = image;
    this.name = name;
    this.description = description;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<SuperHero> superHeros = [];

  _MyHomePageState() {
    superHeros.add(new SuperHero("assets/captain.png", "Captain America",
        "Captain America is the alter ego of Steve Rogers, a frail young artist enhanced to the peak of human perfection by an experimental super-soldier serum after joining the military to aid the United States government's efforts in World War II."));
    superHeros.add(new SuperHero("assets/hulk.jpg", "Hulk",
        "The Hulk is typically seen as a hulking man with green skin, hair, and eyes, wearing only a pair of torn purple pants that survive his physical transformation as the character progressed."));
    superHeros.add(new SuperHero("assets/ironman.jpg", "Iron Man",
        " Genius level intellect Proficient scientist and engineer Powered armor suit: Superhuman strength, speed, durability, agility, reflexes, and senses Supersonic flight Energy repulsor and missile projection Regenerative life support"));

    superHeros.add(new SuperHero("assets/thanos.png", "Thanos",
        "Superhuman strength, speed, stamina, durability, and agility Superhuman physiology of Eternals Skilled hand-to-hand combatant Genius-level tactician Plasma energy projection Immortality Nigh-invulnerability Possessed access to nearly all powerful mystical artifacts and weapons"));
  }

  Widget MySuperCell(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyDetailPage(superHeros[index])));
      },
      child: Card(
        margin: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Hero(
                tag: superHeros[index],
                child: Image.asset(
                  superHeros[index].image,
                  height: 88,
                  width: 88,
                ),
              ),

              // ignore: prefer_const_constructors
              SizedBox(
                width: 20,
              ),
              Text(superHeros[index].name),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: superHeros.length,
          itemBuilder: (context, index) => MySuperCell(context, index),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
