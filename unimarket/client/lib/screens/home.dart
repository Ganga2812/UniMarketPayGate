import 'package:client/screens/sellitem.dart';
import 'package:client/services/auth.dart';
import 'package:client/shared/appbar.dart';
import 'package:client/shared/drawer.dart';
import 'package:client/shared/itemlist.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);
  // Create instant object _auth
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        title: Text(''),
        appBar: AppBar(),
        onpress: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SellItem()));
        },
        label: Text("Sell an Item"),
        icon: Icon(Icons.sell),
      ),
      drawer: DrawerCommon(),
      body: ItemList(),
    );
  }
}
