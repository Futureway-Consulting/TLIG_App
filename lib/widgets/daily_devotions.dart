import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class DailyDevotions extends StatefulWidget {

  const DailyDevotions({super.key});

  @override
  State<DailyDevotions> createState() => _DailyDevotionsState();
}

class _DailyDevotionsState extends State<DailyDevotions> {

    final WebViewController _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://ww3.tlig.org/en/about/photos-videos/"));
  
  @override
  Widget build(BuildContext context) {
      
       return  SafeArea(
        child: WebViewWidget(controller: _controller),
       );
        }
    
  }
