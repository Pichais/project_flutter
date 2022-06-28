// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:project_flutter/screen/myservice.dart';
import 'package:project_flutter/screen/page_category.dart';
import 'package:project_flutter/utillity/my_constant.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String Milk = 'Milk',
      Egg = 'Egg',
      Vegetable = "vegetable",
      AnimalFeed = 'AnimalFeed',
      Meat = 'Meat',
      Other = "other";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Myservice()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 116, 115, 113),
        child: const Icon(Icons.home),
      ),
      body: ListView(
        children: [
          BuildCardMilk(),
          BuildCardEgg(),
          BuildCardVegetable(),
          BuildCardAnumalFeed(),
          BuildCardMeat(),
          BuildCardOther(),
        ],
      ),
    );
  }

  Widget BuildCardMilk() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(Myconstant.catMilk),
            height: 200,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageCategory(
                              valueFromCate: Milk,
                            )));
              },
            ),
          ),
          const Text(
            ' Milk',
            style: TextStyle(
                fontSize: 48,
                backgroundColor: Colors.black12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }

  Widget BuildCardEgg() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(Myconstant.catEgg),
            height: 200,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageCategory(
                              valueFromCate: Egg,
                            )));
              },
            ),
          ),
          const Text(
            ' Egg',
            style: TextStyle(
                fontSize: 48,
                backgroundColor: Colors.black12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }

  Widget BuildCardVegetable() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(Myconstant.catVeg),
            height: 200,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageCategory(
                              valueFromCate: Vegetable,
                            )));
              },
            ),
          ),
          const Text(
            ' Vegetable',
            style: TextStyle(
                fontSize: 48,
                backgroundColor: Colors.black12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }

  Widget BuildCardAnumalFeed() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(Myconstant.catAniFeed),
            height: 200,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageCategory(
                              valueFromCate: AnimalFeed,
                            )));
              },
            ),
          ),
          const Text(
            ' Animal Feed',
            style: TextStyle(
                fontSize: 48,
                backgroundColor: Colors.black12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }

  Widget BuildCardMeat() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(Myconstant.catMeat),
            height: 200,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageCategory(
                              valueFromCate: Meat,
                            )));
              },
            ),
          ),
          const Text(
            ' Meat',
            style: TextStyle(
                fontSize: 48,
                backgroundColor: Colors.black12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }

  Widget BuildCardOther() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(Myconstant.catOther),
            height: 200,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageCategory(
                              valueFromCate: Other,
                            )));
              },
            ),
          ),
          const Text(
            ' Other ',
            style: TextStyle(
                fontSize: 48,
                backgroundColor: Colors.black12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }
}
