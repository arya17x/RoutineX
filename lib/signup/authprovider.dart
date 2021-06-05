import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth instance;
  AuthenticationProvider(this.firebaseAuth);
  //Constuctor to initalize the FirebaseAuth instance

  //Using Stream to listen to Authentication State
  Stream<User> get authState => firebaseAuth.idTokenChanges();

  Future registerIn(
      String _emailcontroller, String password, String _name) async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
              email: _emailcontroller, password: password))
          .user;
      if (user != null) {
        await user.updateProfile(
          displayName: _name,
        );
        await FirebaseAuth.instance.currentUser
            .updateProfile(displayName: user.displayName);
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }

        await FirebaseAuth.instance.currentUser
            .updateProfile(displayName: user.displayName);
        await user.reload();
     //   final user1 = _auth.currentUser;

        /*   Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return MYHomePage(user: user1);
        }));*/
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

  Future siginwithemail(String _email, String _password) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _email, password: _password))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      // User is signed in.
      //   final user2 = _auth.currentUser;

      // var name = user2.displayName;

      /*Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MainPage(user: user2);
      }));*/
    } catch (e) {
      print(e);
      /*setState(() {
        _error = e.message;
        circular = !circular;
      });*/
      //  _scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
      //    content: Text(
      //      "FAILED TO loGIN",
      //       style: TextStyle(color: Colors.black),
      //   ),
      //  ));
      //  print(e.message);
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
