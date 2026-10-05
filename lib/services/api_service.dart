import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_user.dart';
import '../models/product.dart';
import '../models/user_profile.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  /// Asynchronous POST request for authenticating a user.
  /// DummyJSON valid test credentials:
  /// Username: emilys
  /// Password: emilyspass
  static Future<AuthUser> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.trim(),
          'password': password.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return AuthUser.fromJson(data);
      } else {
        final message = data['message'] ?? 'Authentication failed (${response.statusCode})';
        throw Exception(message);
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Network or parsing error: $e');
    }
  }

  /// Asynchronous GET request to fetch product catalog.
  static Future<List<Product>> getProducts({int limit = 20, int skip = 0}) async {
    final url = Uri.parse('$baseUrl/products?limit=$limit&skip=$skip');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> productsJson = data['products'] as List<dynamic>? ?? [];
        return productsJson
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load products (${response.statusCode})');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Unable to fetch products: $e');
    }
  }

  /// Asynchronous GET request to fetch list of users.
  static Future<List<UserProfile>> getUsers({int limit = 15}) async {
    final url = Uri.parse('$baseUrl/users?limit=$limit');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> usersJson = data['users'] as List<dynamic>? ?? [];
        return usersJson
            .map((item) => UserProfile.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load users (${response.statusCode})');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Unable to fetch users: $e');
    }
  }

  /// Asynchronous GET request to fetch details for a single user by id.
  static Future<UserProfile> getUserById(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return UserProfile.fromJson(data);
      } else {
        throw Exception('Failed to load user #$id (${response.statusCode})');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Unable to fetch user details: $e');
    }
  }
}
