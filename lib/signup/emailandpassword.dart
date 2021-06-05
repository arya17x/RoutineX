import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:vishalcheck/mainhomepage.dart';

class EmailsetPage extends StatefulWidget {
  EmailsetPage({Key key}) : super(key: key);

  @override
  _EmailsetPageState createState() => _EmailsetPageState();
}

class _EmailsetPageState extends State<EmailsetPage> {
  final databaseReference = FirebaseFirestore.instance;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character'),
  ]);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  final password2 = TextEditingController();
  final password1 = TextEditingController();
  final _name = TextEditingController();
  bool ishidden = true;

  final formKey2 = new GlobalKey<FormState>();
  String password;
  validateformandsave() async {
    print("Validating form");
    if (formKey2.currentState.validate()) {
      registerIn();

      print("Validating form");
    } else {
      print("FORM ERROR");
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
                  'Tell \nAbout You',
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
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Form(
                  key: formKey2,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _name,
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
                        controller: _emailcontroller,
                        validator: (value) =>
                            value.contains('@') ? null : "Enter a valid Email",
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        obscureText: ishidden,
                        onChanged: (value) => password = value,
                        controller: password1,
                        validator: passwordValidator,
                        decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.security),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _togglevisibility();
                              },
                              child: Icon(ishidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            // child: Icon(Icons.visibility),

                            labelText: 'Choose password',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: password2,
                        validator: (val) =>
                            MatchValidator(errorText: 'passwords do not match')
                                .validateMatch(val, password),
                        decoration: InputDecoration(
                            labelText: 'Confirm password',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 75,
              padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
              child: Material(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green,
                shadowColor: Colors.greenAccent,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () async {
                    validateformandsave();
                  },
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),

            // Container(
            //   child: Column(
            //     children: [
            //       Form(child: )
            //     ],
            //   ),

            // )
          ],
        ),
      ),
    );
  }

  void registerIn() async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
              email: _emailcontroller.text, password: password1.text))
          .user;
      if (user != null) {
        await user.updateProfile(
          displayName: _name.text,
        );
        await FirebaseAuth.instance.currentUser
            .updateProfile(displayName: user.displayName);
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        FirebaseFirestore.instance
            .collection('users')
            .doc()
            .set({'userid': user.uid, 'name': _name.text});

        await FirebaseAuth.instance.currentUser
            .updateProfile(displayName: user.displayName);
        await user.reload();
        final user1 = _auth.currentUser;
        // userSetup(_name.text)

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return MYHomePage(user: user1);
        }));
        //Navigator.pushReplacementNamed(context, '/signin',);
      }

      //await FirebaseAuth.instance.currentUser.updateProfile(displayName:name);

      return Future.value(true);
    } catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          print('serror');
      }
    }
  }

  Future saveInfo(User user) async {}

  _togglevisibility() {
    print("loading");
    // if (ishidden == true) {
    //    ishidden = false;
    //   } else {
    //     ishidden = true;
    //   }
    ishidden = !ishidden;
    setState(() {});
  }
}
