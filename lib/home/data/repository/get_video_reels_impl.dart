import 'package:reelsapp/home/data/dataSource/remote_data_source.dart';
import 'package:reelsapp/home/data/model/videoModel.dart';
import 'package:reelsapp/home/domain/entities/video.dart';
import 'package:reelsapp/home/domain/repository/get_video_reels.dart';


import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoApiService apiService;
  final SharedPreferences sharedPreferences;

  final String _cacheKey = 'cached_videos';

  VideoRepositoryImpl(this.apiService, this.sharedPreferences);

  @override
  Future<List<VideoModel>> fetchVideos() async {
    List<VideoModel>? cachedVideos = await getCachedVideos();

    if (cachedVideos != null && cachedVideos.isNotEmpty) {
      return cachedVideos;
    } else {
      List<VideoModel> videos = await apiService.fetchVideos();

      _cacheVideos(videos);

      return videos;
    }
  }

  void _cacheVideos(List<VideoModel> videos) {
    final String jsonVideos = jsonEncode(videos.map((video) => video.toJson()).toList());
    sharedPreferences.setString(_cacheKey, jsonVideos);
  }

  Future<List<VideoModel>?> getCachedVideos() async {
    final String? cachedData = sharedPreferences.getString(_cacheKey);

    if (cachedData != null) {
      List<dynamic> decodedData = jsonDecode(cachedData);
      List<VideoModel> videos = decodedData.map((video) => VideoModel.fromJson(video)).toList();
      return videos;
    }

    return null;
  }
}

