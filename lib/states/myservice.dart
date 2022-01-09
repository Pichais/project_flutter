import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/utillity/my_constant.dart';

class Myservice extends StatefulWidget {
  const Myservice({Key? key}) : super(key: key);

  @override
  _MyserviceState createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  String? name, email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fineNameAnEmail();
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
        title: Text('WELLCOME TO Farm mall'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/BG01.jpg'), fit: BoxFit.contain),
              ),
              accountName: Text( 
                name ?? 'Name',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                email ?? 'email',
                style: TextStyle(color: Colors.white),
              ),
            ),
            buildSignout(),
          ],
        ),
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
}
