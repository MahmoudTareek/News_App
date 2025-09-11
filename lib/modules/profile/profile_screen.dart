import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/modules/onBoarding/on_boarding_screen.dart';
import 'package:news_app/shared/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    var cubit = NewsCubit.get(context);
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: Image(
                        image: AssetImage('assets/images/profile.jpg'),
                      ).image,
                    ),
                  ),
                  SizedBox(height: 30),
                  defaultFormField(
                    context: context,
                    controller: userNameController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    label: 'User Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20),
                  defaultFormField(
                    context: context,
                    controller: emailController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email,
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: defaultButton(
                          function: () {
                            Fluttertoast.showToast(
                              msg: "Your Information Updated Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          text: 'Update',
                          background: Colors.blue,
                          radius: 50.0,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: defaultButton(
                          function: () {
                            cubit.currentIndex = 0;
                            navigateTo(context, OnBoardingScreen());
                          },
                          text: 'Logout',
                          background: Colors.red,
                          radius: 50.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
