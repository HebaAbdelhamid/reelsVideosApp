import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reelsapp/home/data/model/videoModel.dart';


final String baseUrl="https://api.sawalef.app/api/v1";


class VideoApiService {
  Future<List<VideoModel>> fetchVideos() async {
    final response = await http.get(Uri.parse('$baseUrl/reels'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => VideoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
