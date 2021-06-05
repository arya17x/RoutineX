import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vishalcheck/utils/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'mainscreen/mainpageapp.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  // final _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool ishidden = true;
  String _error;
  bool circular = false;
  validateAndForm() async {
    print("Validating Form....");
    if (formKey.currentState.validate()) {
      _siginwithemail();

      print("validation successful");
    } else {
      print("validation Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Container(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 100.0, 0.0, 0.0),
                      child: Container(
                        child: RichText(
                            text: TextSpan(
                                text: "Hello\nThere",
                                style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                text: ".",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //     showAlert(),
            SizedBox(
              height: _error != null ? 16 : 80,
            ),
            showAlert(),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 18),
              child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val.length == 0 ? "Enter Email" : null,
                          decoration: InputDecoration(
                              //  hintText: "Enter Your Email",
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _password,
                          validator: (value) =>
                              value.length == 0 ? "Enter password" : null,
                          obscureText: ishidden,
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
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        )
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(top: 20, right: 10),
              alignment: Alignment(1, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/reset');
                },
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              height: 50,
              child: Material(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green,
                shadowColor: Colors.greenAccent,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      circular = !circular;
                    });

                    validateAndForm();

                    //
                  },
                  child: Center(
                      child: circular == false
                          ? Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            )
                          : CircularProgressIndicator()),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 48,
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Colors.transparent,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset(
                      'assets/fbg.png',
                      fit: BoxFit.cover,
                      width: 25,
                      height: 25,
                    )),
                    SizedBox(
                      width: 10.0,
                    ),
                    Center(
                        child: Text(
                      "Login With Facebook",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 100),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      'New to Qcamp?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/emailpass");
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _siginwithemail() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _email.text, password: _password.text))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      // User is signed in.
      final user2 = _auth.currentUser;

      // var name = user2.displayName;
      Constants.prefs.setBool("login", true);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MainPage(user: user2);
      }));
    } catch (e) {
      print(e);
      setState(() {
        _error = e.message;
        circular = !circular;
      });
      //  _scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
      //    content: Text(
      //      "FAILED TO loGIN",
      //       style: TextStyle(color: Colors.black),
      //   ),
      //  ));
      //  print(e.message);
    }
  }

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

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  void showCircular() {}
}
