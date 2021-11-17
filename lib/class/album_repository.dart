import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:users_posts_project/model/album/album_info.dart';
import 'package:users_posts_project/model/album/photo_model.dart';

class AlbumRepository {
  Future<List<AlbumInfo>> getAlbum(int userId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final a = parsed
          .map<AlbumInfo>((json) => AlbumInfo.fromJson(json))
          .where((i) => i.userId == userId)
          .toList();

      return a;
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<List<Photo>> getPhosts(int albumId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      headers: <String, String>{'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final a = parsed
          .map<Photo>((json) => Photo.fromJson(json))
          .where((i) => i.albumId == albumId)
          .toList();

      return a;
    } else {
      throw Exception('Failed to update a case');
    }
  }
}
