// Main entry point of the News App using Flutter and Bloc pattern.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/modules/onBoarding/on_boarding_screen.dart';
import 'package:news_app/shared/network/dio_helper.dart';

void main() {
  // Initialize Dio for network requests
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Ensure Flutter bindings are initialized before running the app
    WidgetsFlutterBinding.ensureInitialized();
    // Provide the NewsCubit to the widget tree using MultiBlocProvider for state management
    return MultiBlocProvider(
      providers: [
        // Provide NewsCubit and fetch all news articles on initialization
        BlocProvider<NewsCubit>(create: (context) => NewsCubit()..getAllNews()),
      ],
      child: MaterialApp(
        // Disable the debug banner and set the home screen to OnBoardingScreen
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen(),
      ),
    );
  }
}
