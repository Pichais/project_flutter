import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/states/myservice.dart';
import 'package:project_flutter/utillity/dialog.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/widgets/show_image.dart';

class AddListProduct extends StatefulWidget {
  const AddListProduct({Key? key}) : super(key: key);

  @override
  _AddListProductState createState() => _AddListProductState();
}

class _AddListProductState extends State<AddListProduct> {
  File? file;
  late String productname, productprice, productdetail, urlPicture;

  //Field

  //Method
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
    } catch (e) {}
  }

  Row buildProductImage(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 36,
            color: Myconstant.dark,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.5,
          child: file == null
              ? ShowImage(pathImage: Myconstant.photo)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36,
            color: Myconstant.dark,
          ),
        ),
      ],
    );
  }

  Row buildProductName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => productname = value.trim(),
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Product Name :',
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

  Row buildProductPrice(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => productprice = value.trim(),
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Product Price :',
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

  Row buildProductDetail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => productdetail = value,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Detail :',
              hintStyle: Myconstant().h3style(),
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

  Row buildUploadData(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 22),
          width: size * 0.6,
          child: ElevatedButton(
            style: Myconstant().myButtonStyle(),
            onPressed: () {
              print('You cilk button');
              if (file == null) {
                normalDialog(context, 'กรุณาระบุรูปภาพ \n Please chose Image');
              } else if (productname == null || productname.isEmpty) {
                normalDialog(context, 'กรุณาระบุชื่อสินค้า ');
              } else if (productprice == null || productprice.isEmpty) {
                normalDialog(context, 'กรุณาระบุราคาสินค้า ');
              } else {
                uploadPitureToStorage();
              }

              print(
                  'Name = $productname Price = $productprice Detail = $productdetail');
              print('Image = $file');
            },
            child: Text('Upload Data to Firebase'),
          ),
        ),
      ],
    );
  }

  Future<void> uploadPitureToStorage() async {
    Random random = Random();
    int i = random.nextInt(10000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storageReference =
        firebaseStorage.ref().child('Product/product$i.jpg');
    UploadTask storageUploadTask = storageReference.putFile(file!);

    await storageUploadTask.whenComplete(() async {
      urlPicture = await storageUploadTask.snapshot.ref.getDownloadURL();
    });
    print('URL is = $urlPicture');
    inserValueToFireStore();
  }

  Future<void> inserValueToFireStore() async {
    FirebaseStorage firestore = FirebaseStorage.instance;

    Map<String, dynamic> map = Map();
    map['image'] = urlPicture;
    map['Name'] = productname;
    map['Price'] = productprice;
    map['Detail'] = productdetail;

    await FirebaseFirestore.instance
        .collection('Product')
        .doc()
        .set(map)
        .then((value) {
      print('Insert successfull');
      MaterialPageRoute route = MaterialPageRoute(
        builder: (value) => Myservice(),
      );
      Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              buildProductImage(size),
              buildProductName(size),
              buildProductPrice(size),
              buildProductDetail(size),
              buildUploadData(size),
            ],
          ),
        ),
      ),
    );
  }
}

class viod {}
