import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipesapp/models/recipe_detail_model.dart';
import 'package:recipesapp/models/recipe_list_model.dart';
import 'package:recipesapp/models/recipe_model.dart';

class ApiService {
  final String apiKey = '6d702e6fc9e349ee9ac552ce6093eb5e';
  final String baseUrl = 'https://api.spoonacular.com/recipes';

  /// Fetch recipes based on a query
  Future<List<Recipe>> fetchRecipes(String query, {int number = 10}) async {
    final url = Uri.parse(
        '$baseUrl/complexSearch?query=$query&number=$number&apiKey=$apiKey');

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
  Future<RecipeDetail> fetchRecipeDetails(int recipeId) async {
    final url = Uri.parse('$baseUrl/$recipeId/information?apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return RecipeDetail.fromJson(data);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  /// Fetch random recipes
  Future<List<Recipe>> fetchRandomRecipes({int number = 5}) async {
    final url = Uri.parse('$baseUrl/random?number=$number&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List recipes = data['recipes'];

      return recipes.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load random recipes');
    }
  }

  /// Fetch list of recipes for infinite scrolling
  Future<List<RecipeList>> fetchRecipeList({int number = 100, int offset = 0}) async {
    final url = Uri.parse(
        '$baseUrl/complexSearch?number=$number&offset=$offset&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List recipes = data['results'];

      return recipes.map((json) => RecipeList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipe list');
    }
  }
}
