import 'package:flutter/material.dart';
import 'package:news_app/models/on_boarding_model.dart';
import 'package:news_app/modules/home/home_screen.dart';
// import 'package:news_app/shared/components.dart';
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
      // extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                    nextText = "Get Started";
                  });
                } else
                  setState(() {
                    isLast = false;
                    nextText = "Next";
                  });
                if (index != 0) {
                  setState(() {
                    backText = "Back";
                  });
                } else
                  setState(() {
                    backText = " ";
                  });
                if (index == 0) {
                  setState(() {
                    isfirst = true;
                  });
                } else
                  setState(() {
                    isfirst = false;
                  });
              },
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      if (isLast) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
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
