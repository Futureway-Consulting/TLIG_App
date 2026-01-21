import 'package:tlig_app/RadioItem/radio_item.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TligRadio extends StatefulWidget {
  const TligRadio({super.key});

  @override
  State<TligRadio> createState() => _TligRadioState();
}

class _TligRadioState extends State<TligRadio> {

  final WebViewController _controller = WebViewController()
  ..setUserAgent(
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
  '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
)..setNavigationDelegate(
    NavigationDelegate(
      onNavigationRequest: (request) {
        return NavigationDecision.navigate;
      },
    ),
  )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://tligradio.org/"));
  
  List<RadioStation> stations = [];

  
 
  @override
  Widget build(BuildContext context) {
   return  SafeArea(
        child: WebViewWidget(controller: _controller,),
       );
  }
}
