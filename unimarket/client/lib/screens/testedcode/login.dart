import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 96),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/logowithtext.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text('uni market',
                        style: TextStyle(
                            fontFamily: 'DaysOne',
                            color: Color(0xff532815),
                            fontSize: 24)),
                    SizedBox(height: 75),
                    Text('A marketplace for students',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xff532815),
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 16),
                    Text('Buy and sell new/used items with',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xff532815),
                            fontSize: 16,
                            fontWeight: FontWeight.w300)),
                    Text('other students in your area.',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xff532815),
                            fontSize: 16,
                            fontWeight: FontWeight.w300)),
                    SizedBox(height: 248),
                    Row(
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 69.5, right: 69.5),
                                  child: Text('Get Started',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                      )),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xff32912A))),
                            ElevatedButton(
                                onPressed: () {},
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 86.0, right: 86.0),
                                    child: Text('Log In',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 14,
                                        ))),
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        Color(0xff32912A).withOpacity(0.65))),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
