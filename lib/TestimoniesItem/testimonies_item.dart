class TestimoniesItem {
  int id;
  String? type;
  String? title;
  String? description;
  String? fileUrl;



  TestimoniesItem({
    required this.id,
    this.type,
    this.title,
    this.description,
    this.fileUrl,
  });

 factory TestimoniesItem.fromJson(Map<String, dynamic> json) {
    return TestimoniesItem(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch, 
      type: json['type'] ?? "Null",
      title: json['title'] ?? "Null",
      description: json['description']  ?? "Null",
      fileUrl: json['file'] ?? "Null",
    );
  }
}