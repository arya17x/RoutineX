import 'package:flutter/material.dart';

class SignUppage extends StatefulWidget {
  SignUppage({Key key}) : super(key: key);

  @override
  _SignUppageState createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final formkey = new GlobalKey<FormState>();
  validateForm() {
    print("Validate form...");
    if (formkey.currentState.validate()) {
      print("validation successful");
      Navigator.pushReplacementNamed(context, '/emailpass');
    } else {
      print("validation Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 70, left: 20),
                  child: Text(
                    'Welcome\nQmate',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 110, 15, 0),
                child: Form(
                    key: formkey,
                    child: Column(children: [
                      TextFormField(
                        controller: _namecontroller,
                        validator: (value) =>
                            value.length == 0 ? "Enter Name" : null,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      TextFormField(
                        controller: _agecontroller,
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value.length == 0 ? "Enter Your Age " : null,
                        decoration: InputDecoration(
                            labelText: 'Age',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      )
                    ])),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                height: 50,
                child: Center(
                  child: Material(
                    borderRadius: BorderRadius.circular(55),
                    color: Colors.green,
                    shadowColor: Colors.greenAccent,
                    elevation: 7.0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          validateForm();
                        },
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45),
              Container(
                padding: EdgeInsets.only(left: 60),
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        'Already Have a Account!',
                        style: TextStyle(
                            fontFamily: 'Monteserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(context, '/signin');
                        },
                        child: Text(
                          "Signin",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
