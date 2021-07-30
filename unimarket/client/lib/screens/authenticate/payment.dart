import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../wrapper.dart';

class Payment extends StatefulWidget {
  final String value;
  Payment({Key? key, required this.value}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState(value);
}

class _PaymentState extends State<Payment> {
  String value;
  _PaymentState(this.value);

  String cardNumber = '';
  String cardHolderName = '';
  String cvvNumber = '';
  String expiryDate = '';
  bool showBackView = false;

  void onCreditCardModel(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      cardHolderName = creditCardModel.cardHolderName;
      expiryDate = creditCardModel.expiryDate;
      cvvNumber = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('sellitems').doc(value);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              height: 210,
              cardHolderName: cardHolderName,
              cvvCode: cvvNumber,
              showBackView: showBackView,
              cardBgColor: Colors.greenAccent,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              animationDuration: Duration(milliseconds: 1200),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onCreditCardModel,
                  cursorColor: Colors.red,
                  themeColor: Colors.black,
                  cardHolderName: '',
                  cardNumber: '',
                  cvvCode: '',
                  expiryDate: '',
                  formKey: null,
                ),
              ),
            ),
            SizedBox(
              width: 250,
              child: RaisedButton(
                  color: Color(0xFF29BF12),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                          transaction.delete(documentReference);
                        })
                        .then((value) => print("Deleted Listing"))
                        .catchError((error) => print("Failed delete listing"));

                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Wrapper()));
                  },
                  child: Text("Pay",
                      style:
                          TextStyle(color: Color(0xFFFFFFFF), fontSize: 17))),
            ),
          ],
        ),
      ),
    );
  }
}
