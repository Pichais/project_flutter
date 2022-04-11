import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/states/page_category.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/utillity/product_model.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ProductModel> productModels = [];

  @override
  void initState() {
    readAllData();
    super.initState();
  }

  Future<Null> readAllData() async {
    if (productModels != 0) {
      productModels.clear();
    } else {}

    await Firebase.initializeApp().then((value) async {
      print('**Categories***');
      await FirebaseFirestore.instance
          .collection('Product')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print(element['Name']);
          print(element['Type'].runtimeType);
          String T = element['Type'];
          print(T);
          if (T == "Milk") {
            print(element['Name'] + ' *Name ');
            print(element['EXP'] + ' *EXP');
            print("OK");
          } else {
            print("Hello");
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPicture(),
    );
  }

  ListView buildPicture() {
    return ListView(
      children: [
        Expanded(
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              onTap: () {
                debugPrint('You click Card..!');
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageCategory()));
                });
              },
              child: SizedBox(
                width: 250,
                height: 170,
                child: Image(
                    image: AssetImage(Myconstant.catMilk),
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              onTap: () {
                debugPrint('You click Card..!');
              },
              child: SizedBox(
                width: 250,
                height: 170,
                child: Image(
                    image: AssetImage(Myconstant.catEgg), fit: BoxFit.fitWidth),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              onTap: () {
                debugPrint('You click Card..!');
              },
              child: SizedBox(
                width: 250,
                height: 170,
                child: Image(
                    image: AssetImage(Myconstant.catVeg), fit: BoxFit.fitWidth),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              onTap: () {
                debugPrint('You click Card..!');
              },
              child: SizedBox(
                width: 250,
                height: 170,
                child: Image(
                    image: AssetImage(Myconstant.catVeg), fit: BoxFit.fitWidth),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              onTap: () {
                debugPrint('You click Card..!');
              },
              child: SizedBox(
                width: 250,
                height: 170,
                child: Image(
                    image: AssetImage(Myconstant.catVeg), fit: BoxFit.fitWidth),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
