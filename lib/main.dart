import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tlig_app/widgets/disclaimer.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'package:tlig_app/widgets/message_display.dart';
//import 'package:tlig_app/widgets/ecclesiastical_approval.dart';
import 'package:tlig_app/widgets/testimonies.dart';
import 'package:tlig_app/widgets/tlig_radio.dart';
//import 'package:tlig_app/RadioItem/radio_item.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  //final RadioPlayerController _radioController = RadioPlayerController();

  //bool _isRadioPlaying = false;

  bool acceptedDisclaimer = false;

  // void _toggleRadioONOFF() async {
  //   if (_isRadioPlaying) {
  //     await _radioController.pause();
  //   } else {
  //     await _radioController.play();
  //   }
  //   setState(() {
  //     _isRadioPlaying = !_isRadioPlaying;
  //   });
  // }

  List<BottomNavigationBarItem> navitems = [
    BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.perm_media_rounded),
    //   label: "Media",
    //),
    BottomNavigationBarItem(icon: Icon(Icons.radio), label: "TLIGRadio"),
    //BottomNavigationBarItem(icon: Icon(Icons.approval), label: "Approvals"),
    BottomNavigationBarItem(
      icon: Icon(Icons.celebration),
      label: "Testimonies",
    ),
  ];

  int currentPage = 0;

  @override
  void dispose() {
    //_radioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MessageDisplay(url: "https://ww3.tlig.org/en/the-messages/"),
      TligRadio(),
      //EcclesiasticalApproval(),
      Testimonies(),
    ];
    return Scaffold(
      body: Stack(
        children: [
          pages[currentPage],
          // Positioned(
          //   bottom: 20, // distance from top
          //   right: 20, // distance from right
          //   child: FloatingActionButton(
          //     onPressed: _toggleRadioONOFF,
          //     child: Icon(
          //       _isRadioPlaying ? Icons.pause : Icons.play_arrow,
          //       size: 32,
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.yellow,
        backgroundColor: Colors.amber,
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        items: navitems,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  }
  runApp(
    MaterialApp(
      home: const AppGate(),
      theme: ThemeData(
        primaryColor: Color(0xFF1F2D5C),
        scaffoldBackgroundColor: Color.fromARGB(255, 252, 232, 179),
        fontFamily: GoogleFonts.poppins().fontFamily,

        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1F2D5C),
          foregroundColor: Color(0xFFF2D68A),
          elevation: 0,
        ),

        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF111A33)),
          bodyMedium: TextStyle(color: Color(0xFF111A33)),
          titleLarge: TextStyle(
            color: Color(0xFF1F2D5C),
            fontWeight: FontWeight.bold,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              if (states.contains(WidgetState.hovered)) {
                return Colors.red;
              }
              if (states.contains(WidgetState.pressed)) {
                return Colors.orange;
              }
              return Color(0xFF1F2D5C);
            }),

            foregroundColor: WidgetStateProperty.all(Color(0xFFF2D68A)),

            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 17, horizontal: 24),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textStyle: WidgetStateProperty.all(
              TextStyle(fontWeight: FontWeight.bold,
              fontSize: 16),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xFF1F2D5C)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1F2D5C)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    ),
  );
}
