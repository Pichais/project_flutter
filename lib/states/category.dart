import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
          if (element['Type'] == 'Milk') {
            print(element['Name']);
            print(element['EXP']);
          } 
        });
      });

      //     .snapshots()
      //     .listen((event) {
      //   for (var snapshot in event.docs) {
      //     Map<String, dynamic> data = snapshot.data();
      //     print('map ======> $data');
      //     ProductModel productModel = ProductModel.fromMap(snapshot.data());
      //     setState(() {
      //       productModels.add(productModel);
      //     });
      //   }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Select icon Categorie',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  IconButton(
                      onPressed: () {
                        int index = 0;
                        print(productModels);
                      },
                      icon: Icon(Icons.adb_sharp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget showListview(int index) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image:  NetworkImage(productModels[index].pathimage),
  //         fit: BoxFit.cover
  //       ),

  //     ),
  //   );
  // }
}
