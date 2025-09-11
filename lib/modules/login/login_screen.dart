// Login Screen with email and password fields, remember me checkbox, forgot password link, social media login buttons, and sign up link.
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for email and password input fields
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // Key to manage form state and validation if needed in the future
  var formKey = GlobalKey<FormState>();
  // Variable to toggle password visibility
  bool isPassword = true;
  // Variable to track the state of the "Remember me" checkbox
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting texts
                const Text(
                  'Hello',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Again!',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(right: 130.0),
                  child: Text(
                    'Welcome back you’ve been missed',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  children: [
                    // Username label with asterisk for required field
                    Text('Username', style: TextStyle(fontSize: 14.0)),
                    Text(
                      '*',
                      style: TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  ],
                ),
                // Email input field using a custom defaultFormField widget from components.dart to be used across the app for consistency and reusability
                defaultFormField(
                  context: context,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  // Validation to ensure the email field is not empty
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    // Password label with asterisk for required field
                    Text('Password', style: TextStyle(fontSize: 14.0)),
                    Text(
                      '*',
                      style: TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  ],
                ),
                defaultFormField(
                  context: context,
                  controller: passwordController,
                  // Suffix icon to toggle password visibility
                  suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                  suffixPrssed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  // Keyboard type for password input to be hidden password
                  type: TextInputType.visiblePassword,
                  // Obscure text for password field based on isPassword state
                  isPassword: isPassword,
                  // Validation to ensure the password field is not empty
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password must not be empty';
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    // "Remember me" checkbox
                    Checkbox(
                      value: isRemember,
                      onChanged: (value) {
                        setState(() {
                          isRemember = !isRemember;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    const Text('Remember me', style: TextStyle(fontSize: 14.0)),
                    const Spacer(),
                    // "Forgot Password?" link aligned to the right
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Login button using a custom defaultButton widget from components.dart for consistency and reusability
                defaultButton(
                  function: () {
                    // Navigate to the NewsLayout screen and remove all previous routes from the stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => NewsLayout()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  text: 'Login',
                  radius: 10.0,
                ),
                const SizedBox(height: 15.0),
                Center(
                  child: Text(
                    'or continue with',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                SizedBox(height: 15.0),
                // Social media login buttons for Facebook and Google
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/facebook.png',
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Facebook',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Google',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Sign up if the user doesn't have an account
                    Text(
                      'don’t have an account? ',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
