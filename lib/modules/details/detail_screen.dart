// Detail screen to show the details of the article when clicked on it from the list of articles in the home screen or search screen. Moreover, it contains a button to open the full article in a web view screen.
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
import 'package:news_app/shared/components.dart';

class DetailScreen extends StatelessWidget {
  String articleImageURL;
  String articleTitle;
  String articleContent;
  String articlePublishedTime;
  String articleSource;
  String articleURL;

  // Constructor to accept article details as parameters
  DetailScreen({
    super.key,
    required this.articleImageURL,
    required this.articleTitle,
    required this.articleContent,
    required this.articlePublishedTime,
    required this.articleSource,
    required this.articleURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.share_outlined), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar for the article source
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: Image(
                    image: AssetImage('assets/images/profile.jpg'),
                  ).image,
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article source name and published time
                    Text(
                      '${articleSource}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${articlePublishedTime}h ago',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              // Article image
              child: Image.network(
                '${articleImageURL}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              // Article title
              '${articleTitle}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              // Article content with '[+n chars]' removed
              '${articleContent}'.replaceAll(RegExp(r'\[\+\d+ chars\]'), ''),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      // Button to open the full article in a web view
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: defaultButton(
          function: () {
            // navigateTo is a custom function defined in components.dart to navigate to a new screen to be easier to use everywhere in the app without repeating the same code again and again
            navigateTo(context, WebViewScreen(articleURL));
          },
          text: 'Open Article',
          radius: 10.0,
        ),
      ),
    );
  }
}
