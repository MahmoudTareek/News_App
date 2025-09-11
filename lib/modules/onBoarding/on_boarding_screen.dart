// OnBoarding Screen with page view and smooth page indicator
import 'package:flutter/material.dart';
import 'package:news_app/models/on_boarding_model.dart';
import 'package:news_app/modules/login/login_screen.dart';
import 'package:news_app/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  bool isfirst = true;
  String nextText = "Next";
  String backText = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index) {
                // Check if we are on the last page, next button will change to "Get Started"
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                    nextText = "Get Started";
                  });
                  // If we are not on the last page, next button will be "Next"
                } else
                  setState(() {
                    isLast = false;
                    nextText = "Next";
                  });
                // Check if we are on the first page, back button will be hidden
                if (index != 0) {
                  setState(() {
                    backText = "Back";
                  });
                  // If we are not on the first page, back button will be shown
                } else
                  setState(() {
                    backText = " ";
                  });
                // Check if we are on the first page
                if (index == 0) {
                  setState(() {
                    isfirst = true;
                  });
                  // If we are not on the first page
                } else
                  setState(() {
                    isfirst = false;
                  });
              },
              itemBuilder: (context, index) =>
                  // Build each boarding item using the model data from a function below to be more readable and cleaner
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            // Row for smooth page indicator and buttons
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // smooth_page_indicator package changed the dots indicator to a smooth one, the selected dot is larger and animated when changing pages by swiping or pressing next button
                    SmoothPageIndicator(
                      controller: boardController,
                      effect: ScrollingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                      count: boarding.length,
                    ),
                  ],
                ),
                Spacer(),
                // Back button, only visible when we are not on the first page
                if (!isfirst)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Go to previous page if not on the first page
                    onPressed: () {
                      if (isfirst) {
                        null;
                      } else {
                        boardController.previousPage(
                          duration: Duration(microseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Text(
                      backText,
                      style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                    ),
                  ),
                SizedBox(width: 5.0),
                // Next or Get Started button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () {
                      // Check if we are on the last page, if so navigate to login screen, otherwise go to next page
                      // navigateTo function is in shared/components.dart to be reusable in other places if I want to navigate to another screen
                      if (isLast) {
                        navigateTo(context, LoginScreen());
                      } else {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    // Change button text based on whether we are on the last page or not
                    child: Text(
                      nextText,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build each boarding item using the model data
  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Image(
          image: AssetImage('${model.image}'),
          width: double.infinity,
          height: 550.0,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(height: 10.0),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 100.0),
        child: Column(
          children: [
            Text(
              '${model.title}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text('${model.body}', style: TextStyle(fontSize: 14.0)),
          ],
        ),
      ),
    ],
  );
}
