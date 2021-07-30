import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  // const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      child: Center(
        child: SpinKitWave(
          color: Color(0xFF29BF12),
          size: 50,
        ),
      ),
    );
  }
}
