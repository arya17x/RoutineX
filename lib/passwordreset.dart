import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PassReset extends StatefulWidget {
  PassReset({Key key}) : super(key: key);

  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> {
  final _emailcontroller = TextEditingController();
  final _formkey = new GlobalKey<FormState>();
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  _validateformandsave() async {
    if (_formkey.currentState.validate()) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text);
      print("Validating Successful");
    } else {
      print("Validating Form");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, top: 90),
            child: Text(
              "Happy to See You\nAgain",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 55,
              ),
            ),
          ),
          SizedBox(height: 45),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailcontroller,
                    validator: (value) =>
                        value.length != 0 && value.contains("@")
                            ? null
                            : "Enter Valid Email",
                    decoration: InputDecoration(
                        labelText: "Enter Email",
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: GestureDetector(
                onTap: () async {
                  banner();
                  _validateformandsave();
                },
                child: Material(
                  color: Colors.green,
                  elevation: 7.0,
                  shadowColor: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(50),
                  child: Center(
                      child: Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                    ),
                  )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 48,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  banner();
                  Navigator.popAndPushNamed(context, '/signin');
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      "Got Remembered Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void banner() {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text("FAILED TO loGIN"),
    ));
  }
}
