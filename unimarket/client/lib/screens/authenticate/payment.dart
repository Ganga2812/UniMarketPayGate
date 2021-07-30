import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
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
      body: Center(
        child: ElevatedButton(
          child: Text('Pay Now'),
          onPressed: () async {
            var request = BraintreeDropInRequest(
              tokenizationKey: 'sandbox_pg2xg5z3_s4b9d87p23cnwc3k',
              paypalRequest: BraintreePayPalRequest(
                amount: '5.00',
                displayName: 'UniMarket'
              ),
              cardEnabled: true
            );
            BraintreeDropInResult? result = await BraintreeDropIn.start(request);
            if (result != null) {
              print(result.paymentMethodNonce.description);
              print(result.paymentMethodNonce.nonce);
              
            }
            await FirebaseFirestore.instance
                  .runTransaction((transaction) async {
                    transaction.delete(documentReference);
                  })
                  .then((value) => print("Deleted Listing"))
                  .catchError((error) => print("Failed delete listing"));

            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Wrapper()));
          },
        ),
      )
    );
  }
}
