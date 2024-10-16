import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:reelsapp/home/data/model/videoModel.dart';


final String baseUrl="https://api.sawalef.app/api/v1";

class VideoApiService {
  final String baseUrl;

  VideoApiService(this.baseUrl);

  Future<List<VideoModel>> fetchVideos() async {
    final response = await http.get(Uri.parse('$baseUrl/reels'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];

      return data.map((json) => VideoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  Future<Uint8List?> downloadVideo(String videoUrl) async {
    try {
      final response = await http.get(Uri.parse(videoUrl));

      if (response.statusCode == 200) {
        return response.bodyBytes; // Return the video binary data as Uint8List
      } else {
        throw Exception('Failed to download video');
      }
    } catch (e) {
      print('Error downloading video: $e');
      return null;
    }
  }
}


