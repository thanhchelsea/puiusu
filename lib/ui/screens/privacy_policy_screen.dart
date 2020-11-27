import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PrivacyPolicy extends StatelessWidget {
  String htmlFilePath = 'assets/faq.html';
  WebViewController webViewController;
  loadLocalHTML() async{

    String fileHtmlContents = await rootBundle.loadString(htmlFilePath);
    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreenMethod(
        title: "home.faq",
        body:Container(
          padding: EdgeInsets.only(right: 10),
          child: WebView(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
            ].toSet(),
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController tmp) {
              webViewController = tmp;
              loadLocalHTML();
            },
          ),
        ),
      ),
    );
  }
}
