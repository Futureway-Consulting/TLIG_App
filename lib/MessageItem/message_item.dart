class MessageItem {
  final int id;
  final bool? isAudio;
  final int? year;
  final String? month;
  final String? category;
  final String? theme;
  final String? title;
  final String? message;

  MessageItem({
    required this.id,
    this.isAudio,
    this.year,
    this.month,
    this.category,
    this.theme,
    this.title,
    this.message
  });

  factory MessageItem.fromJson(Map<String,dynamic> json){
    int extractYear(String value) {
  final regex = RegExp(r'(\d{4})(?!.*\d{4})'); // last 4-digit number
  final match = regex.firstMatch(value);
  if (match != null) return int.parse(match.group(0)!);
  throw FormatException("No valid 4-digit year found in: $value");
}
    return MessageItem(
      id: json["id"],
      year: extractYear(json["date"]),
      category: json["category"],
      theme: json["theme"],
      message: json["message"],
      isAudio: false,
      title: json["title"],
    );
  }

}