import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maristcommerce/screen_pages/home_screen.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        width: 20000,
        height: 20000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/logo.png'),
              fit: BoxFit.cover,
              opacity: 0.3),
        ),
        child: Column(children: [
          Padding(padding: EdgeInsets.fromLTRB(5, 120, 5, 20)),
          Image.asset(
            'images/logo.png',
            height: 350,
          ),
          SizedBox(
            height: 100,
          ),
          Button(
            onpressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignUp()));
            },
            text: 'SIGN UP',
          ),
          SizedBox(height: 45),
          Button(
            onpressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignIn()));
            },
            text: 'SIGN IN',
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          )
        ]),
      ),
    ));
  }
}

class Button extends StatelessWidget {
  String text;
  final void Function() onpressed;
  Button({
    super.key,
    required this.text,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7ED957),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 22),
          )),
    );
  }
}
