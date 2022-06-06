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
  String Milk = 'Milk', Egg = 'Egg', Vegetable = "vegetable", Other = "other";

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
        backgroundColor: Color.fromARGB(255, 116, 115, 113),
        child: const Icon(Icons.home),
      ),
      body: ListView(
        children: [
          BuildCardMilk(),
          BuildCardEgg(),
          BuildCardVegetable(),
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
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 9, 45, 56)),
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
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 9, 45, 56)),
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
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 9, 45, 56)),
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
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 9, 45, 56)),
          )
        ],
      ),
    );
  }
}
