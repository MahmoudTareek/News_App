// WebViewScreen to show the webview of the article
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String articalURL;
  // Constructor to accept article URL as parameter
  WebViewScreen(this.articalURL);

  @override
  Widget build(BuildContext context) {
    // Initialize the WebViewController with JavaScript disabled and load the article URL
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(articalURL));

    return Scaffold(
      appBar: AppBar(),
      // Display the WebView using the controller initialized above
      body: WebViewWidget(controller: controller),
    );
  }
}
