import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp/homscreen.dart';
import 'package:otp/signuppage.dart';
import 'otp_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
 {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPhoneNumberFocused = false;
  bool _isPasswordFocused = false;
  bool _isPhoneNumberValid = true;
  bool _isPasswordValid = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/registration.png',
                    height: screenHeight * 0.3,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone, // Change to phone type
                          decoration: InputDecoration(
                            hintText: 'Phone Number', // Change hint text
                            errorText: _isPhoneNumberFocused && !_isPhoneNumberValid ? 'Enter a valid phone number' : null, // Update error text
                            prefixIcon: const Icon(Icons.phone, color: Colors.black,), // Change icon
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isPhoneNumberValid = value.isNotEmpty; // Update validation
                            });
                          },
                          onTap: () {
                            setState(() {
                              _isPhoneNumberFocused = true;
                              _isPasswordFocused = false;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            errorText: _isPasswordFocused && !_isPasswordValid ? 'Password must be at least 6 characters' : null,
                            prefixIcon: const Icon(Icons.lock, color: Colors.black,),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isPasswordValid = value.length >= 6;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _isPasswordFocused = true;
                              _isPhoneNumberFocused = false;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const OtpScreen()),
                                );
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) { // Validate the form
                                  if (_isPhoneNumberValid && _isPasswordValid) {
                                    try {
                                      // Sign in with phone number
                                      await _auth.signInWithEmailAndPassword(
                                        email: '${_phoneNumberController.text}@example.com', // Use phone number as email
                                        password: _passwordController.text,
                                      );
                                      // Navigate to home screen upon successful login
                                      Navigator.pushReplacement( // Replace current screen with home screen
                                        context,
                                        MaterialPageRoute(builder: (_) => const HomeScreen()), // Navigate to home screen
                                      );
                                    } catch (e) {
                                      // Error handling
                                      print('Error logging in: $e');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Failed to log in. Please check your credentials.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter valid phone number and password.'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const SignupScreen()), // Navigate to signup screen
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
