import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp/forget_password.dart'; // Assuming 'otp' is your project name

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  late TextEditingController _phoneNumberController;
  late TextEditingController _otpController;
  late String verificationId = ""; // To store verification ID for phone number
  String otpStatusMessage = ''; // Variable to store OTP status message

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController(text: '+91'); // Pre-populate with country code
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _verifyPhoneNumber() async {
    String phoneNumber = _phoneNumberController.text.trim();
    if (!_formKey.currentState!.validate()) {
      return; // Prevent verification if form is invalid
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification completed. Sign the user in with the credential.
          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          final user = userCredential.user!;

          // Handle successful sign-in (e.g., navigate to a different screen)
          print('User signed in automatically with phone number verification.');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
          setState(() {
            otpStatusMessage = 'Phone number verification failed: ${e.message}';
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          print('OTP code sent: $verificationId');
          setState(() {
            otpStatusMessage = 'Code sent to your phone number.';
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
          print('Auto-retrieval timeout: $verificationId');
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      setState(() {
        otpStatusMessage = 'Error sending OTP. Please try again.';
      });
    }
  }

  void _verifyOtp(BuildContext context) async {
    String otpCode = _otpController.text.trim();
    if (!_formKey.currentState!.validate()) {
      return; // Prevent verification if form is invalid
    }

    try {
      // Sign in the user with the verification ID and entered OTP code
      final phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      final user = userCredential.user!;

      // Handle successful sign-in (e.g., navigate to a different screen)
      print('User signed in with OTP verification.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
      );
    } catch (e) {
      print('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP code. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number.';
                    } else if (!value.startsWith('+91')) {
                      return 'Please enter a valid Indian phone number (starting with +91).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _verifyPhoneNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  otpStatusMessage, // Display OTP status message
                  style: TextStyle(color: otpStatusMessage.contains('failed') ? Colors.red : Colors.green), // Set color based on success/failure
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Enter OTP sent to your phone:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'OTP Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the OTP code.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => _verifyOtp(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(color: Colors.black),
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
