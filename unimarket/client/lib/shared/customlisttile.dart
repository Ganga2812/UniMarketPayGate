import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Color(0x8829BF12),
          )),
        ),
        child: ListTile(
          onTap: () {
            onTap();
          },
          leading: Icon(icon, color: Color(0xFF29BF12)),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF29BF12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
