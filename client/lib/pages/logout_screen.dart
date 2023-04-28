import 'package:flutter/material.dart';
import 'login_screen.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALPR Dashboard: Logout"),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 400,
          child: Column(
            children: [
              const Text(
                "If you logged out you will need to login again!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  child: const Text('Log Out Here'),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
