import 'package:flutter/material.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final Function onpress;
  final Icon icon;
  final Text label;

  const AppBarCommon(
      {required this.title,
      required this.appBar,
      required this.onpress,
      required this.icon,
      required this.label});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Color(0xFF29BF12),
      elevation: 0.0,
      actions: [
        FlatButton.icon(
          textColor: Color(0xFFFFFFFF),
          onPressed: () async {
            onpress();
          },
          icon: icon,
          label: label,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
