import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/states/create.dart';
import 'package:project_flutter/states/edit_product.dart';
import 'package:project_flutter/utillity/account_model.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/utillity/product_model.dart';
import 'package:project_flutter/widgets/add_list_product.dart';
import 'package:project_flutter/widgets/show_title.dart';

import '../main.dart';

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
    if (productModels != 0) {
      productModels.clear();
    } else {}

    await Firebase.initializeApp().then((value) async {
      print('**initialize Success***');
      await FirebaseFirestore.instance
          .collection('Product')
          .snapshots()
          .listen((event) {
        //print('snapshot = ${event.docs}');
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

  Widget showType(int index) {
    return Row(
      children: [Text('ประเภท : ' + productModels[index].type)],
    );
  }

  // Widget showEXP(int index) {
  //   return Row(
  //     children: [Text('EXP : ${productModels[index].exp}')],
  //   );
  // }

  Widget showDetail(int index) {
    return Row(
      children: [Text(productModels[index].detail)],
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          showName(index),
          showDetail(index),
          showType(index),
          showPrice(index),
          buildEditAndDelete(index),
          Column(),
        ],
      ),
    );
  }

  Row buildEditAndDelete(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Edit
        IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProduct(productModel: productModels[index]),
                    ));
              });
            },
            icon: const Icon(
              Icons.edit,
              size: 25,
            )),
        //DELETE
        IconButton(
            onPressed: () {
              setState(() {
                confirmDialogDelete(productModels[index]);
              });
            },
            icon: Icon(
              Icons.delete_rounded,
              color: Colors.red[900],
              size: 25,
            )),
      ],
    );
  }

  Future<void> confirmDialogDelete(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.network(
            productModel.pathimage,
          ),
          title: ShowTitle(
              title: 'Delete ${productModel.name} ? ',
              textStyle: Myconstant().h2style()),
          subtitle: ShowTitle(
            title: productModel.detail,
            textStyle: Myconstant().h3style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancle'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseStorage.instance
                  .refFromURL(productModel.pathimage)
                  .delete();
              await FirebaseFirestore.instance
                  .collection('Product')
                  .doc(
                    productModel.id,
                  )
                  .delete()
                  .then((value) {
                Navigator.pop(context);
                readAllData();
              });

              print("Delete success");
            },
            child: Text('Delete'),
          ),
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
                fit: BoxFit.fitHeight)),
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
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return showListview(index);
      },
    );
  }
}
