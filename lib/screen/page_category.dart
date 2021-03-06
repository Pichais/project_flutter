import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/screen/edit_product.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/utillity/product_model.dart';

import '../widgets/show_title.dart';

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
    nameCate = widget.valueFromCate.toString();

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
          itemBuilder: (BuildContext buildContext, int index) {
            //แปลง Datetime to String
            Timestamp stempDate = productModels[index].exp;
            var formattedDate =
                DateFormat('dd-MM-yyyy').format(stempDate.toDate());
            return Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 15, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.4,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          productModels[index].pathimage),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Detail:   ${productModels[index].detail}",
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  textdetail(index, formattedDate),
                ],
              ),
            );
          },
        ));
  }

  Expanded textdetail(int index, String formattedDate) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(productModels[index].name),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("EXP: $formattedDate"),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(productModels[index].price.toString()),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child:
                        Text("stock: ${productModels[index].stock.toString()}"),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Container(
              child: Text(productModels[index].type),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Row(
              children: [
                //Edit
                Expanded(
                  flex: 4,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProduct(
                                    productModel: productModels[index]),
                              ));
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                      )),
                ),
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
                      size: 20,
                    )),
              ],
            ),
          ],
        ),
      ),
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
                setState(() {
                  readAllData(nameCate);
                });
              });

              print("Delete success");
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
