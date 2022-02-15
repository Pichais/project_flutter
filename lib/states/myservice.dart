import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/widgets/add_list_product.dart';
import 'package:project_flutter/widgets/show_list_product.dart';

class Myservice extends StatefulWidget {
  const Myservice({Key? key}) : super(key: key);

  @override
  _MyserviceState createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  String? name, email;
  Widget currentWidget = ShowListProduct();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fineNameAnEmail();
  }

  changePage(int index) {
    setState(() {});
  }

  Future<Null> fineNameAnEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event!.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Myconstant.primary,
        title: Text('WELLCOME TO FARM MART'),
      ),
      body: currentWidget,
      drawer: builddrawer(),
    );
  }

  Drawer builddrawer() {
    return Drawer(
      child: Stack(
        children: [
          showlist(),
          buildSignout(),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader show_name_email() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/BG01.jpg'), fit: BoxFit.cover),
      ),
      accountName: Text(
        name ?? 'Name',
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        email ?? 'email',
        style: TextStyle(color: Colors.white),
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
      leading: Icon(
        Icons.list,
        size: 30,
      ),
      title: Text('List Product'),
      subtitle: Text('Show all Product'),
      onTap: () {
        setState(() {
          currentWidget = ShowListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAddproduc() {
    return ListTile(
      leading: Icon(
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

  Widget showlist() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          show_name_email(),
          showlistproduc(),
          showAddproduc(),
        ],
      ),
    );
  }
}
