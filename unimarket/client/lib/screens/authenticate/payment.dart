import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';



import '../wrapper.dart';

class Payment extends StatefulWidget {
  final String id;
  final String price;
  Payment({Key? key, required this.id, required this.price }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState(id, price);
}

class _PaymentState extends State<Payment> {
  String id;
  String price;
  _PaymentState(this.id, this.price);

  String cardNumber = '';
  String cardHolderName = '';
  String cvvNumber = '';
  String expiryDate = '';
  bool showBackView = false;
  String accountNumber = '';
  String routingNumber = '';
  String address = '';
  String paypal = '';
  var documentID = FirebaseAuth.instance.currentUser!.uid;
  



  void getUserNameAndUID(documentId) {
    print(price);
    print(documentID);
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => accountNumber = documentSnapshot.get('accountNumber'));
      print(accountNumber);
    });
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => routingNumber = documentSnapshot.get('routingNumber'));
      print(routingNumber);
    });
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => address = documentSnapshot.get('address'));
      print(address);
    });
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => paypal = documentSnapshot.get('paypal'));
      print(paypal);
    });
  }

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
        FirebaseFirestore.instance.collection('sellitems').doc(id);
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
            getUserNameAndUID(documentID);
            var request = BraintreeDropInRequest(
              tokenizationKey: 'sandbox_pg2xg5z3_s4b9d87p23cnwc3k',
              paypalRequest: BraintreePayPalRequest(
                amount: price,
                displayName: 'UniMarket'
              ),
              cardEnabled: true
            );
            BraintreeDropInResult? result = await BraintreeDropIn.start(request);
            if (result != null) {
              print(result.paymentMethodNonce.description);
              print(result.paymentMethodNonce.nonce);
              
            }

              if((paypal != '' && address != '') || (routingNumber != '' && accountNumber != '')) {
               Future.delayed(const Duration(milliseconds: 5000), () {
                  setState(() async {
                    await FirebaseFirestore.instance
                  .runTransaction((transaction) async {
                    transaction.delete(documentReference);
                  })
                  .then((id) => print("Deleted Listing"))
                  .catchError((error) => print("Failed delete listing"));
                    alert(context);
                  });

                }); 
              } else {
                alert2(context);
              }
          },
        ),
      )
    );
  }
  alert(context) {
    return showDialog(
      context: context,
      builder: (BuildContext bc) {
        return AlertDialog(
          title: Text(
            'Payment has been sent to seller!',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF29BF12),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                context, MaterialPageRoute(builder: (_) => Wrapper()));
              },
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFe76f51),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  alert2(context) {
    return showDialog(
      context: context,
      builder: (BuildContext bc) {
        return AlertDialog(
          title: Text(
            'Payment could not process, seller does not have the correct information',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF29BF12),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                context, MaterialPageRoute(builder: (_) => Wrapper()));
              },
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFe76f51),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
