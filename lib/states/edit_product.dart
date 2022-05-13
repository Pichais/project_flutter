import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/states/myservice.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/utillity/product_model.dart';
import 'package:project_flutter/widgets/show_image.dart';
import 'package:project_flutter/widgets/show_title.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  const EditProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ProductModel? productModel;
  TextEditingController nameController =
      TextEditingController(); //ใช้กับ TextFormField เท่านั้น
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  bool checkDate = false;
  String formattedDate = '';
  DateTime _dateTime = DateTime.now();

  File? file;
  late String urlPicture;
  final formKey = GlobalKey<FormState>();
  late String? typeproduct = productModel!.type;
  List<String> listtype = ["Milk", "Egg", "vegetable", "other"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productModel = widget.productModel;
    nameController.text = productModel!.name;
    priceController.text = productModel!.price;
    stockController.text = productModel!.stock;
    detailController.text = productModel!.detail;
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Myconstant.primary,
        title: Text('Edit ${productModel!.name}'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                buildTitle('Edit Product :'),
                buildEditName(size),
                buildEditType(size),
                buildEditPrice(size),
                buildEditStock(size),
                buildEditEXP(size),
                buildEditDetail(size),
                buildTitle('Edit Product Image :'),
                buildEditImage(size),
                buildconfirmEdit(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTitle(String title) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: ShowTitle(title: title, textStyle: Myconstant().h2style()),
      )
    ]);
  }

  buildEditName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plese Fill Name in Blank';
              }
            },
            controller: nameController,
            onChanged: (value) => {},
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Name : ',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.light),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }

  buildEditType(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.65,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Myconstant.dark, width: 1.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButton(
                hint: Text(
                  productModel!.type,
                  style: TextStyle(fontSize: 16),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Myconstant.dark,
                ),
                iconSize: 36,
                isExpanded: true,
                underline: SizedBox(),
                value: typeproduct,
                onChanged: (String? newValue) {
                  setState(() {
                    typeproduct = newValue;
                  });
                },
                items: listtype.map((value) {
                  return DropdownMenuItem(
                    child: Text(
                      value,
                      style: TextStyle(),
                    ),
                    value: value,
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildEditPrice(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plese Fill Price in Blank';
              }
            },
            keyboardType: TextInputType.number,
            controller: priceController,
            onChanged: (value) => {},
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Price : ',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.light),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }

  buildEditStock(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plese Fill Price in Blank';
              }
            },
            keyboardType: TextInputType.number,
            controller: stockController,
            onChanged: (value) => {},
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Stock/Pack ',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.light),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildEditEXP(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 16,
            left: 80,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CheckDate(checkDate),
              Container(
                margin: EdgeInsets.only(left: 40),
                child: ElevatedButton(
                  style: Myconstant().myButtonStyle(),
                  onPressed: () async {
                    DateTime? _newDate = await showDatePicker(
                      context: context,
                      initialDate: _dateTime,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(3000),
                    );
                    if (_newDate != null) {
                      setState(() {
                        checkDate = true;
                        _dateTime = _newDate;
                        formattedDate =
                            DateFormat('dd-MM-yyyy').format(_dateTime);
                      });
                    }
                  },
                  child: const Text('Get Date'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  CheckDate(bool checkDate) {
    if (checkDate == false) {
      return Text(
        "EXP : ${productModel!.exp}",
        style: TextStyle(fontSize: 17),
      );
    } else {
      return Text(
        'EXP : ${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
        style: TextStyle(fontSize: 17),
      );
    }
  }

  buildEditDetail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plese Fill Detail in Blank';
              }
            },
            maxLines: 3,
            controller: detailController,
            onChanged: (value) => {},
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Detail : ',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.light),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      // ignore: deprecated_member_use
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  buildEditImage(double size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.5,
          child: file == null
              ? Image.network(productModel!.pathimage)
              : Image.file(file!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => chooseImage(ImageSource.camera),
              icon: Icon(Icons.add_a_photo_rounded),
            ),
            IconButton(
              onPressed: () => chooseImage(ImageSource.gallery),
              icon: Icon(Icons.add_photo_alternate_rounded),
            ),
          ],
        ),
      ],
    );
  }

  Row buildconfirmEdit(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          width: size * 0.6,
          child: ElevatedButton(
            style: Myconstant().myButtonStyle(),
            onPressed: () => processEdit(),
            child: Text('Confirm Edit Product'),
          ),
        ),
      ],
    );
  }

  processEdit() async {
    print('ProcessEdit');
    if (formKey.currentState!.validate()) {
      String name = nameController.text;
      String price = priceController.text;
      String stock = stockController.text;
      String detail = detailController.text;

      print(
          '==> Name = $name, Type = $typeproduct Price = $price, stock/pack = $stock Detail = $detail');
      print(typeproduct);
      print('File ====<${file}>====');

      Random random = Random();
      int i = random.nextInt(10000);

      if (file == null) {
        FirebaseStorage firestore = FirebaseStorage.instance;
        Map<String, dynamic> map = Map();
        map['Name'] = name;
        map['Type'] = typeproduct;
        map['Price'] = price;
        map['Stock'] = stock;
        map['EXP'] = formattedDate;
        map['Detail'] = detail;

        await FirebaseFirestore.instance
            .collection('Product')
            .doc(productModel!.id)
            .update(map)
            .then((value) {
          print('UpDate Successfull');
          MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => Myservice(),
          );
          Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
        });
      } else {
        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        Reference storageReference =
            firebaseStorage.ref().child('Product/product$i.jpg');
        UploadTask storageUploadTask = storageReference.putFile(file!);
        await storageUploadTask.whenComplete(() async {
          urlPicture = await storageUploadTask.snapshot.ref.getDownloadURL();
        });
        FirebaseStorage.instance.refFromURL(productModel!.pathimage).delete();

        FirebaseStorage firestore = FirebaseStorage.instance;
        Map<String, dynamic> map = Map();
        map['image'] = urlPicture;
        map['Name'] = name;
        map['Type'] = typeproduct;
        map['Price'] = price;
        map['Stock'] = stock;
        map['EXP'] = formattedDate;
        map['Detail'] = detail;

        await FirebaseFirestore.instance
            .collection('Product')
            .doc(productModel!.id)
            .update(map)
            .then((value) {
          print('UpDate Successfull');
          MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => Myservice(),
          );
          Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
        });
      }
    }
  }
}
