class Recipe {
  final int id;
  final String content;
  final String title;
  static const String TABLENAME = "recipes";

  Recipe({this.id, this.content, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'title': title};
  }
}