// import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class Testimonies extends StatefulWidget {
  const Testimonies({super.key});

  @override
  State<Testimonies> createState() => _TestimoniesState();
}

class _TestimoniesState extends State<Testimonies> {
  final WebViewController _controller = WebViewController()
    ..setUserAgent(
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    )
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://ww3.tlig.org/en/testimonies/"));

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WebViewWidget(controller: _controller));
  }
}
