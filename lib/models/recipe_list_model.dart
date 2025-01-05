class RecipeList {
  final int id;
  final String title;
  final String image;

  RecipeList({
    required this.id,
    required this.title,
    required this.image,
  });

  factory RecipeList.fromJson(Map<String, dynamic> json) {
    return RecipeList(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      image: json['image'] as String,
    );
  }
}
