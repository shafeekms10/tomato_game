import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_game/Services/auth/auth_service.dart';
import 'package:tomato_game/Screens/home.dart';

Future<String?> getUsername() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userSnapshot.data()?['name'];
  }
  return null;
}

class UsernameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUsername(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}',style: const TextStyle(fontSize: 14, color: Colors.white),);
        } else if (snapshot.data != null) {
          return Text('${snapshot.data}',style: const TextStyle(fontSize: 14, color: Colors.white),);
        } else {
          return Text('No username',style: const TextStyle(fontSize: 14, color: Colors.white),);
        }
      },
    );
  }
}

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late String email;

  @override
  void initState() {
    super.initState();
    // Initialize user details
    email = FirebaseAuth.instance.currentUser!.email ?? "";
  }

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );

  Widget buildHeader(BuildContext context) => Material(
    color: Color.fromRGBO(239, 118, 73, 1),
    child: Container(
      padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: Column(
        children: [
          UsernameWidget(),
          SizedBox(height: 10),
          Text(
            email,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(30),
    child: Wrap(
      runSpacing: 10,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.login_outlined),
          title: const Text('Log Out'),
          onTap: signOut,
        ),
      ],
    ),
  );
}
