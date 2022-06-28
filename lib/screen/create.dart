import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/utillity/dialog.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/widgets/show_image.dart';
import 'package:project_flutter/widgets/show_title.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String? typegender;
  File? file;
  late String urlPicture, ID_Admin;
  final formKey = GlobalKey<FormState>();
  String id = '', password = '', name = '', address = '', phone = '';

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => name = value.trim(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาระบุ Name ของคุณ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Name :',
              prefixIcon: Icon(
                Icons.face,
                color: Myconstant.dark,
              ),
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

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => address = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาระบุ Address ของคุณ';
              } else {}
            },
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Address :',
              hintStyle: Myconstant().h3style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: Myconstant.dark,
                ),
              ),
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

  Row buildPhoneNumber(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => phone = value.trim(),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาระบุ PhonNumber ของคุณ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'PhoneNumber :',
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: Myconstant.dark,
              ),
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

  Container buildTitle1(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: Myconstant().h2style(),
      ),
    );
  }

  RadioListTile<String> buildMen() {
    return RadioListTile(
      value: 'Men',
      groupValue: typegender,
      onChanged: (value) {
        setState(() {
          typegender = value;
        });
      },
      title: ShowTitle(
        title: 'ผู้ชาย (Men)',
        textStyle: Myconstant().h3style(),
      ),
    );
  }

  RadioListTile<String> buildWomen() {
    return RadioListTile(
      value: 'Women',
      groupValue: typegender,
      onChanged: (value) {
        setState(() {
          typegender = value;
        });
      },
      title: ShowTitle(
        title: 'ผู้หญิง (Women)',
        textStyle: Myconstant().h3style(),
      ),
    );
  }

  ShowTitle buildSubTitle() => ShowTitle(
        title: 'เลือกรูปภาพที่คุณต้องการที่จะแสดง',
        textStyle: Myconstant().h3style(),
      );

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

  Row buildAvatar(double size) {
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
              ? ShowImage(pathImage: Myconstant.avata)
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

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => id = value.trim(),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาระบุ ID ของคุณ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'ID :',
              prefixIcon: Icon(
                Icons.person,
                color: Myconstant.dark,
              ),
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

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            onChanged: (value) => password = value.trim(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาระบุ Password ของคุณ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: Myconstant().h3style(),
              labelText: 'Password :',
              prefixIcon: Icon(
                Icons.lock_rounded,
                color: Myconstant.dark,
              ),
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

  Row buildCreateAcc(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 22),
          width: size * 0.8,
          child: ElevatedButton(
            style: Myconstant().myButtonStyle(),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                print(
                    'ID = $id,Password = $password ,Name = $name, Address = $address,Phone = $phone, Gender = $typegender');
                registerFirebase();
              } else {
                normalDialog(context, 'กรุณากรอกข้อมูลของคุณให้ครบ');
              }
            },
            child: Text('Create'),
          ),
        ),
      ],
    );
  }

  Future<Null> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('********** Firebase Initialize Success *************');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: id, password: password)
          .then((value) async {
        print('Register Success');

        Random random = Random();
        int i = random.nextInt(10000);

        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        Reference storageReference =
            firebaseStorage.ref().child('Admin/admin$i.jpg');
        UploadTask storageUploadTask = storageReference.putFile(file!);

        await storageUploadTask.whenComplete(() async {
          urlPicture = await storageUploadTask.snapshot.ref.getDownloadURL();
        });
        print('URL is = $urlPicture');
        inserValueToFireStore();

        // ignore: deprecated_member_use
        await value.user?.updateProfile(displayName: name).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                context, '/myservice', (route) => false));
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
        backgroundColor: Myconstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle1('รูปภาพ'),
                buildSubTitle(),
                buildAvatar(size),
                buildTitle1('ข้อมูลทั่วไป : '),
                buildUser(size),
                buildPassword(size),
                buildName(size),
                buildTitle1('กรุณาระบุเพศ : '),
                buildMen(),
                buildWomen(),
                buildAddress(size),
                buildPhoneNumber(size),
                buildCreateAcc(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void inserValueToFireStore() async {
    String generateRandomString(int len) {
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      var r = Random();
      return String.fromCharCodes(List.generate(
          len, (index) => _chars.codeUnitAt(r.nextInt(_chars.length))));
    }

    ID_Admin = generateRandomString(20);

    FirebaseStorage firestore = FirebaseStorage.instance;
    Map<String, dynamic> map = Map();
    map['ID'] = ID_Admin;
    map['address'] = address;
    map['gender'] = typegender;
    map['id'] = id;
    map['password'] = password;
    map['image'] = urlPicture;
    map['phone'] = phone;
    map['name'] = name;

    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(ID_Admin)
        .set(map)
        .then((value) {
      print('Insert successfull');
    });
  }
}
