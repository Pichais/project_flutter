import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/utillity/product_model.dart';

class ShowListProduct extends StatefulWidget {
  const ShowListProduct({Key? key}) : super(key: key);

  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  List<ProductModel> productModels = [];

  @override
  void initState() {
    readAllData();
    super.initState();
  }

  Future<Null> readAllData() async {
    await Firebase.initializeApp().then((value) async {
      print('**initialize Success***');
      await FirebaseFirestore.instance
          .collection('Product')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print('map = $map');

          ProductModel productModel = ProductModel.fromMap(snapshot.data());
          setState(() {
            productModels.add(productModel);
          });
        }
      });
    });
  }

  Widget showName(int index) {
    return Row(
      children: [
        Text(
          productModels[index].name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget showPrice(int index) {
    return Row(
      children: [Text('฿' + productModels[index].price)],
    );
  }

  Widget showDetail(int index) {
    return Row(
      children: [Text(productModels[index].detail)],
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 0.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showName(index),
          showDetail(index),
          showPrice(index),
        ],
      ),
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage(productModels[index].pathimage),
                fit: BoxFit.cover)),
      ),
    );
  }

  //โชว์ รายละเอียดต่างๆจาก Firebase
  Widget showListview(int index) {
    return Row(
      children: <Widget>[
        showImage(index),
        showText(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return showListview(index);
        },
      ),
    );
  }
}
