import 'package:client/screens/wrapper.dart';
import 'package:client/services/auth.dart';
import 'package:client/shared/customlisttile.dart';
import 'package:flutter/material.dart';

class DrawerCommon extends StatefulWidget {
  @override
  _DrawerCommonState createState() => _DrawerCommonState();
}

class _DrawerCommonState extends State<DrawerCommon> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          CustomListTile(Icons.backpack, 'Items', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Wrapper()));
          }),
          // CustomListTile(Icons.person, 'Profile', () {
          //   Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) => Profile()));
          // }),
          // CustomListTile(Icons.settings, 'Settings', () {
          //   Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) => Setting()));
          // }),
          CustomListTile(Icons.logout, 'Log Out', () async {
            await _auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Wrapper()));
          }),
        ],
      ),
    );
  }
}
