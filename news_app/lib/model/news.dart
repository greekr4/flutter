

class News{
  late String title;
  late String content;

  News({
    required this.title,
    required this.content,
});


  News.fromMap(Map<String, dynamic>? map){
    title = map?['title'] ?? '';
    content = map?['description'] ?? '';
  }
}