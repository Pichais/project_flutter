import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/states/edit_product.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/utillity/product_model.dart';
import 'package:project_flutter/widgets/show_title.dart';

class PageCategory extends StatefulWidget {
  final String valueFromCate;
  const PageCategory({Key? key, required this.valueFromCate}) : super(key: key);

  @override
  State<PageCategory> createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory> {
  List<ProductModel> productModels = [];
  String nameCate = '';

  @override
  void initState() {
    print(widget.valueFromCate.toString());
    nameCate = widget.valueFromCate.toString();
    print("NameCategory ===> ${nameCate}");
    readAllData(nameCate);
    super.initState();
  }

  Future<Null> readAllData(String nameCate) async {
    await Firebase.initializeApp().then((value) async {
      print('**initialize Success***');
      await FirebaseFirestore.instance
          .collection('Product')
          .where("Type", isEqualTo: nameCate)
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print(map);
          ProductModel productModel = ProductModel.fromMap(snapshot.data());
          setState(() {
            productModels.add(productModel);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Myconstant.primary,
        title: Text(nameCate),
      ),
      body: ListView.builder(
          itemCount: productModels.length,
          itemBuilder: (context, index) {
            return showListview(index);
          }),
    );
  }

  Widget showListview(int index) {
    return Row(
      children: <Widget>[
        showImage(index),
        showText(index),
      ],
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: const EdgeInsets.all(10.0),
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

  Widget showText(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
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
        ],
      ),
    );
  }

  Widget showName(int index) {
    return Row(
      children: [
        Text(
          productModels[index].name,
          style: const TextStyle(
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

  Widget showDetail(int index) {
    return Row(
      children: [Text(productModels[index].detail)],
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
            child: const Text('Cancle'),
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
                readAllData(nameCate);
              });

              print("Delete success");
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
