// import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:tlig_app/TestimoniesItem/testimonies_item.dart';

class Testimonies extends StatefulWidget {
  const Testimonies({super.key});

  @override
  State<Testimonies> createState() => _TestimoniesState();
}

class _TestimoniesState extends State<Testimonies> {
  List<TestimoniesItem> testimonies = [];

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
    ..loadRequest(Uri.parse("https://ww3.tlig.org/en/testimonies/"));
  
  // @override
  // void initState() {
  //   super.initState();
  //   //loadTestimonies();
  // }

// Future<void> loadTestimonies() async{
//   try{
//     final loadedTestimonies = await fetchTestimonies();
//     setState(() {
//       testimonies = loadedTestimonies;
//     });
//   }catch (e){
//     print("error: ${e}");
//   }
// }
// Future<List<TestimoniesItem>> fetchTestimonies() async{
//   final String response = await rootBundle.loadString('assets/testimonies/testimonies.json');
//   final List<dynamic> data = jsonDecode(response);
//   return data.map((e) => TestimoniesItem.fromJson(e)).toList();
// }
  
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Expanded(child: 
    // ListView.builder(
    //   itemCount: testimonies.length,
    //   itemBuilder: (context, index) {
    //     final testimony = testimonies[index];
    //     return ListTile(
    //       //leading: Image.network(station.coverUrl!),
    //       trailing: Text(testimony.id.toString()),
    //       //subtitle: Image.asset(testimony.fileUrl!),
    //       title: Text(testimony.title!),
    //       subtitle: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(testimony.description!),
    //           Text(testimony.fileUrl!),
    //         ]
    //       ),
    //       leading: Text(testimony.type!),
    //     );
    //   },

    // )
    // ),
    // // ------- INPUT SECTION -------
    //   Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [

    //         Text("Submit Testimony",
    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

    //         SizedBox(height: 10),

    //         // NAME
    //         TextField(
    //           decoration: InputDecoration(
    //             labelText: "Your Name",
    //             border: OutlineInputBorder(),
    //           ),
    //         ),

    //         SizedBox(height: 10),

    //         // MESSAGE
    //         TextField(
    //           maxLines: 4,
    //           decoration: InputDecoration(
    //             labelText: "Your Message",
    //             alignLabelWithHint: true,
    //             border: OutlineInputBorder(),
    //           ),
    //         ),

    //         SizedBox(height: 10),

    //         OutlinedButton.icon(
    //           onPressed: () {
    //           },
    //           icon: Icon(Icons.attach_file),
    //           label: Text("Choose File"),
    //         ),

    //         SizedBox(height: 10),

    //         ElevatedButton(
    //           onPressed: () {
    //           },
    //           style: ElevatedButton.styleFrom(
    //             minimumSize: Size(double.infinity, 45),
    //           ),
    //           child: Text("Submit"),
    //         ),
    //       ],
    //     ),
    //   ),

    //   Divider(),
    // ],
    // ); 
    return  SafeArea(
        child: WebViewWidget(controller: _controller,),
       );
  }
}