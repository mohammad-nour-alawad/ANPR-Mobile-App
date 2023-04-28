import 'package:client/api.dart';
import 'package:client/homepage.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  final Api api = Api();
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isAuth = false;

  var kPrimaryColor = const Color(0xFF6F35A5);
  var kPrimaryLightColor = const Color(0xFFF1E6FF);
  static const double defaultPadding = 16.0;

  _login() {
    widget.api
        .checkUser(userController.text, passController.text)
        .then((value) => {
              if (value.username.isEmpty && value.username.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Worng Username or Password!"))),
                }
              else
                {
                  setState(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Syrian ALPR Detections Dashboard"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 10),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 350,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          decoration: const InputDecoration(
                            hintText: "Your username",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.person),
                            ),
                          ),
                          validator: (email) {
                            if (email!.isEmpty ||
                                !RegExp(r'^[a-zA-Z_]+$').hasMatch(email)) {
                              return "Not A Valid Username!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: TextFormField(
                            controller: passController,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            cursorColor: kPrimaryColor,
                            decoration: const InputDecoration(
                              hintText: "Your password",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.lock),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Hero(
                          tag: "login_btn",
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _login();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Not OK!")));
                              }
                            },
                            child: Text(
                              "Login".toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*
Widget _formLogin() {
  return Column(
    children: [
      TextField(
        decoration: InputDecoration(
          hintText: 'Enter email or Phone number',
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      const SizedBox(height: 30),
      TextField(
        decoration: InputDecoration(
          hintText: 'Password',
          counterText: 'Forgot password?',
          suffixIcon: const Icon(
            Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      const SizedBox(height: 40),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.orange,
              spreadRadius: 10,
              blurRadius: 20,
            ),
          ],
        ),
        child: ElevatedButton(
          child: Container(
              width: double.infinity,
              height: 50,
              child: Center(child: Text("Sign In"))),
          onPressed: () => print("it's pressed"),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
      const SizedBox(height: 40),
    ],
  );
}
*/