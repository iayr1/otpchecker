import 'package:flutter/material.dart';
import 'package:otp/loginpage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        color: Colors.yellow, 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'HomeScreen',
                style: TextStyle(fontSize: 24.0, color: Colors.black), 
              ),
              const SizedBox(height: 20.0), 
              ElevatedButton(
                onPressed: () {
                
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()), 
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.yellow, 
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), 
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18.0), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
