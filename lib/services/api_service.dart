import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipesapp/models/recipe_model.dart';
 // Import model yang sudah dibuat

class RecipeService {
  final String apiKey = '6d702e6fc9e349ee9ac552ce6093eb5e';
  final String baseUrl = 'https://api.spoonacular.com/recipes';

  /// Fetch recipes based on a query (e.g., "pasta")
  Future<List<Recipe>> fetchRecipes(String query) async {
    final url = Uri.parse('$baseUrl/complexSearch?query=$query&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List recipes = data['results'];

      return recipes.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  /// Fetch recipe details by ID
  Future<Recipe> fetchRecipeDetails(int id) async {
    final url = Uri.parse('$baseUrl/$id/information?apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}
