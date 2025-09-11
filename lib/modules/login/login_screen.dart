//login screen
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/modules/home/home_screen.dart';
import 'package:news_app/shared/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

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
                    Text('Username', style: TextStyle(fontSize: 14.0)),
                    Text(
                      '*',
                      style: TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  ],
                ),
                defaultFormField(
                  context: context,
                  controller: emailController,
                  type: TextInputType.emailAddress,
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
                  suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                  suffixPrssed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  type: TextInputType.visiblePassword,
                  isPassword: isPassword,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password must not be empty';
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
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
                defaultButton(
                  function: () {
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
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
