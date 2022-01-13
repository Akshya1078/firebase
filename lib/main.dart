import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // cameras = await availableCameras();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context,snapshot){
      if (snapshot.hasData){
        /// User is logged in
        return HomePage();
      }else{
        return SignInScreen(
          providerConfigs:const [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(clientId: '780431298568-ia2686vkkimcr04p2hfk5tcghues0mhg.apps.googleusercontent.com'),
            PhoneProviderConfiguration(),
            FacebookProviderConfiguration(clientId: '304834473459095',
              redirectUri: 'https://fir-auth-87916.firebaseapp.com/__/auth/handler'
            )
          ],
          headerBuilder: (context,constraints,_){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130,vertical: 20),
              child: Container(
                height: 50,
                width: 100,
                child: const Text("Welcome to Our Region"),
              ),
            );
          },
          footerBuilder: (context,_)=>const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text("By Signing in,you agree to our terms and conditions"),
          ),
        );

      }

    },
  );

}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Home"),
            Spacer(),
            GestureDetector(
              onTap: (){

                FirebaseAuth.instance.signOut();
              },
                child: Icon(Icons.logout))
          ],
        ),
      ),
      body: Container(
        child: const Center(
          child: Text("Welcome Logged In!"),
        ),
      ),
    );
  }
}
