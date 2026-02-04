//import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:webview_flutter/webview_flutter.dart';

class MessageDisplay extends StatefulWidget {
  final String url;
  const MessageDisplay({required this.url, super.key});

  @override
  State<MessageDisplay> createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://ww3.tlig.org/en/"));

  String? selectedCategory;

  int? dateFilter;

  bool showWebPage = true;
  bool showTheme = false;
  bool showDates = false;
  bool showMonths = false;
  bool showCategory = false;
  bool showDaySelection = false;
  bool showMonthSelection = false;
  bool showCategorySelection = false;
  List<String> themeSet = [];
  List<String> categorySet = [];
  List<String> monthName = [
    'NoMonth',
    'Jan',
    'Feb',
    'Mar',
    "Apr",
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];
  List<int> yearSet = [];
  int? selectedYear;
  int? selectedMonth;
  List<int> monthSet = [];
  List<int> daySet = [];
  @override
  void initState() {
    super.initState();
    loadJsonDataNew();
    loadCategoryJson();
  }

  late Map<String, List<Map<String, dynamic>>> _allCategories;

  Future<void> loadCategoryJson() async {
    final String response = await rootBundle.loadString(
      'assets/data/messages_by_categories.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(response);

    // Convert dynamic lists to List<int>
    _allCategories = jsonData.map((key, value) {
      return MapEntry(
        key,
        (value as List).map((e) => e as Map<String, dynamic>).toList(),
      );
    });
    if (!mounted) return;
    // Populate categorySet for UI buttons
    setState(() {
      categorySet = _allCategories.keys.toList()..sort();
    });
  }

  void openCategoryMessage(String category, int index) {
    if (_allCategories.containsKey(category)) {
      final msgIdList = _allCategories[category]!;
      if (index >= 0 && index < msgIdList.length) {
        final msgId = msgIdList[index]['id'];
        _controller.loadRequest(
          Uri.parse("https://ww3.tlig.org/en/messages/$msgId/"),
        );
        showWebPage = true;
      }
    }
  }

  late Map<String, dynamic> _allMessages;
  // Full JSON map to use when opening WebView

  Future<void> loadJsonDataNew() async {
    final String response = await rootBundle.loadString(
      'assets/data/messages_by_date.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(response);
    // Populate yearSet for your UI
    final List<int> years = jsonData.keys.map((y) => int.parse(y)).toList()
      ..sort();
    // Store the full JSON for lookup when user selects year/month/day
    _allMessages = jsonData;
    if (!mounted) return;
    setState(() {
      yearSet = years;
      // messages, themeSet, categorySet not used in this method
    });
  }

  void openMessage(int year, int month, int day) {
    final dayStr = day.toString().padLeft(2, '0');
    final monthStr = month.toString();
    final yearStr = year.toString();

    if (_allMessages.containsKey(yearStr) &&
        _allMessages[yearStr].containsKey(monthStr) &&
        _allMessages[yearStr][monthStr].containsKey(dayStr)) {
      final msgId = _allMessages[yearStr][monthStr][dayStr]["id"];
      _controller.loadRequest(
        Uri.parse("https://ww3.tlig.org/en/messages/$msgId/"),
      );
      showWebPage = true;
    } else {
      debugPrint("Message not found for $year-$month-$day");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2D68A),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showDates = !showDates;
                        showCategory = false;
                        selectedYear = null;
                        selectedMonth = null;
                        selectedCategory = null;
                        showWebPage = false;
                      });
                    },
                    child: Text("Msg by Dates"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showCategory = !showCategory;
                        showDates = false;
                        selectedYear = null;
                        selectedMonth = null;
                        selectedCategory = null;
                        showWebPage = false;
                      });
                    },
                    child: Text("Msg by Category"),
                  ),
                ],
              ),
            ),

            if (showDates)
              SizedBox(
                height: MediaQuery.of(context).size.height *0.65,
                  child:ShaderMask(
                    shaderCallback: (rect){
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end:  Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                           Colors.black87,
                        ],
                        stops: [0.5,1],

                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                    child: Container(
                                    decoration: BoxDecoration(
                    color: Color(0xFFF2D68A),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Wrap(
                      spacing: 4,
                      runSpacing: 8,
                      
                      children: [
                        for (int i = 0; i < yearSet.length; i++)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showDates = false;
                    
                                selectedYear = yearSet[i];
                                selectedMonth = null;
                                showMonthSelection = true;
                                monthSet =
                                    (_allMessages[selectedYear.toString()].keys
                                            as Iterable)
                                        .map((m) => int.parse(m.toString()))
                                        .toList()
                                      ..sort();
                    
                                daySet = [];
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dateFilter == yearSet[i]
                                  ? Colors.orange
                                  : null,
                            ),
                            child: Text(yearSet[i].toString()),
                          ),
                      ],
                    ),
                                    ),
                  ),
              ),
              ),
            if (selectedYear != null && showMonthSelection)
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(child: Text(selectedYear.toString())),
                  for (int month in monthSet)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showDaySelection = true;
                          selectedMonth = month;
                          daySet =
                              (_allMessages[selectedYear
                                              .toString()][selectedMonth
                                              .toString()]
                                          .keys
                                      as Iterable)
                                  .map((d) => int.parse(d.toString()))
                                  .toList()
                                ..sort();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMonth == month
                            ? Colors.orange
                            : null,
                      ),
                      child: Text(monthName[month].toString()),
                    ),
                ],
              ),
           if (selectedMonth != null && showDaySelection)
  Expanded(
    child: SingleChildScrollView(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          for (int day in daySet)
            Builder(
              builder: (context) {
                final dayData = _allMessages[selectedYear
                        .toString()][selectedMonth.toString()][
                    day.toString().padLeft(2, '0')];
                final preview = dayData["title"] ?? "No preview";

                return ElevatedButton(
                  onPressed: () {
                    openMessage(selectedYear!, selectedMonth!, day);
                    setState(() {
                      showDaySelection = false;
                      showMonthSelection = false;
                    });
                  },
                  child: Text(
                    '$day: $preview',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
        ],
      ),
    ),
  ),


           if (showCategory)
  Expanded(
    child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF2D68A),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        padding: EdgeInsets.all(8),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            for (String cat in categorySet)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedCategory = cat;
                    showCategory = false;
                    showCategorySelection = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategory == cat
                      ? Colors.orange
                      : null,
                ),
                child: Text(cat),
              ),
          ],
        ),
      ),
    ),
  ),

            if (selectedCategory != null && showCategorySelection)
              Container(
                padding: EdgeInsets.only(top: 8),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 500),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (
                          int i = 0;
                          i < _allCategories[selectedCategory!]!.length;
                          i++
                        )
                          ElevatedButton(
                            onPressed: () {
                              openCategoryMessage(selectedCategory!, i);
                              debugPrint(
                                "im trying to open a page with the number",
                              );
                              setState(() {
                                showCategory = false;
                                showCategorySelection = false;
                              });
                            },
                            child: Text(
                              'Msg: ${i + 1}:: ${_allCategories[selectedCategory!]![i]['preview']}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

            if (showWebPage)
              Expanded(child: WebViewWidget(controller: _controller)),
          ],
        ),
      ),
    );
  }
}
