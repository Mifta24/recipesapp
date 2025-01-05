class RecipeDetail {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;
  final String summary;
  final List<String> ingredients;
  final List<String> instructions;

  RecipeDetail({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.summary,
    required this.ingredients,
    required this.instructions,
  });

  // Factory constructor to parse JSON
  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String? ?? '',
      readyInMinutes: json['readyInMinutes'] as int,
      servings: json['servings'] as int,
      summary: json['summary'] as String? ?? 'No description available.',
      ingredients: (json['extendedIngredients'] as List)
          .map((e) => e['original'] as String)
          .toList(),
      instructions: (json['analyzedInstructions'] as List)
          .expand((e) => e['steps'] as List)
          .map((step) => step['step'] as String)
          .toList(),
    );
  }
}
