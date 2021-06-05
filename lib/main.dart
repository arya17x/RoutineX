import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vishalcheck/mainhomepage.dart';
import 'package:vishalcheck/mainscreen/Time_Table/frontProvider.dart';
import 'package:vishalcheck/mainscreen/Time_Table/full_routine.dart';
import 'package:vishalcheck/mainscreen/Time_Table/time_table_provider.dart';
import 'package:vishalcheck/mainscreen/mainpageapp.dart';
import 'package:vishalcheck/mainscreen/provider/todo.dart';
import 'package:vishalcheck/passwordreset.dart';
import 'package:vishalcheck/signup/authprovider.dart';
import 'package:vishalcheck/signup/emailandpassword.dart';
import 'package:vishalcheck/signup/nameandage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vishalcheck/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Constants.prefs = await SharedPreferences.getInstance();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodosProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoutineProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FrontProvider(),
        ),
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        )
      ],
      child: MaterialApp(
        title: 'Firebase Authentication',
        home: Authenticate(),
        debugShowCheckedModeBanner: false,
        routes: {
          //  '/': (context) => MYHomePage(),
          '/signup': (context) => SignUppage(),
          '/signin': (context) => MYHomePage(),
          '/emailpass': (context) => EmailsetPage(),
          '/signinpage': (context) => MainPage(),
          '/reset': (context) => PassReset(),
          '/routinepage': (context) => FullRoutine(),
        },
      ),
    );

/*return new MaterialApp(
      title: 'arya',
      home: MYHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        //  '/': (context) => MYHomePage(),
        '/signup': (context) => SignUppage(),
        '/signin': (context) => MYHomePage(),
        '/emailpass': (context) => EmailsetPage(),
        '/signinpage': (context) => MainPage(),
        '/reset': (context) => PassReset(),
      },
    );*/
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return MainPage();
    }
    return MYHomePage();
  }
}
