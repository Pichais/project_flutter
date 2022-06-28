// ignore_for_file: await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/screen/category.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/widgets/add_list_product.dart';
import 'package:project_flutter/widgets/show_list_product.dart';
import 'package:project_flutter/widgets/sort_exp.dart';
import 'package:project_flutter/widgets/sort_stock.dart';

class Myservice extends StatefulWidget {
  const Myservice({Key? key}) : super(key: key);

  @override
  _MyserviceState createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  String? name, email;
  Widget currentWidget = const ShowListProduct();
  var urlImage;
  bool checkstate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fineNameAnEmail();
  }

  Future<void> fineNameAnEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event!.displayName;
          email = event.email;
        });
      });
      await FirebaseFirestore.instance
          .collection('Admin')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          setState(() {
            urlImage = doc['image'];
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Myconstant.primary,
        title: const Text('WELLCOME TO FARM MART'),
        actions: [
          PopupMenuButton(
            // icon: const Icon(Icons.dehaze),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    if (checkstate == false) {
                      currentWidget = const SortDate();
                      checkstate = true;
                    } else {
                      currentWidget = const ShowListProduct();
                      checkstate = false;
                    }
                  });
                },
                child: const Text('Sort EXP'),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    if (checkstate == false) {
                      currentWidget = const SortStock();
                      checkstate = true;
                    } else {
                      currentWidget = const ShowListProduct();
                      checkstate = false;
                    }
                  });
                },
                child: const Text('Sort Stock'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Container(
          child: currentWidget,
        ),
      ),
      drawer: builddrawer(),
    );
  }

  Drawer builddrawer() {
    return Drawer(
      child: Stack(
        children: [
          Drawer(
            child: ListView(
              children: <Widget>[
                show_name_email(),
                showlistproduc(),
                showCategorie(),
                showAddproduc(),
              ],
            ),
          ),
          buildSignout()
        ],
      ),
    );
  }

  UserAccountsDrawerHeader show_name_email() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/BG01.jpg'), fit: BoxFit.cover),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage('${urlImage}'),
      ),
      accountName: Text(
        name ?? 'Name',
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        email ?? 'email',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Column buildSignout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, Myconstant.routeAuthen, (route) => false));
            });
          },
          tileColor: Colors.blueGrey[300],
          leading: Icon(
            Icons.exit_to_app_rounded,
            color: Colors.red[700],
          ),
          title: Text('Exit', style: TextStyle(color: Colors.red[700])),
        ),
      ],
    );
  }

  Widget showlistproduc() {
    return ListTile(
      leading: const Icon(
        Icons.list,
        size: 30,
      ),
      title: const Text('List Product'),
      subtitle: const Text('Show all Product'),
      onTap: () {
        setState(() {
          currentWidget = const ShowListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAddproduc() {
    return ListTile(
      leading: const Icon(
        Icons.playlist_add,
        size: 30,
      ),
      title: Text('Add List List Product'),
      subtitle: Text('Add New Product to Database'),
      onTap: () {
        setState(() {
          currentWidget = AddListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showCategorie() {
    return ListTile(
      leading: Icon(Icons.category_rounded),
      title: Text('Categorie'),
      subtitle: Text('Show Product you selected'),
      onTap: () {
        setState(() {
          currentWidget = Category();
        });
        Navigator.of(context).pop();
      },
    );
  }
}
