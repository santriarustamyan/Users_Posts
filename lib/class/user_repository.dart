import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:users_posts_project/model/users/user_info.dart';

class UserRepository {
  Future<List<UserInfo>> getUser() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: <String, String>{'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final a =
          parsed.map<UserInfo>((json) => UserInfo.fromJson(json)).toList();

      return a;
    } else {
      throw Exception('Failed to update a case');
    }
  }
}
