import 'package:reelsapp/home/data/dataSource/remote_data_source.dart';
import 'package:reelsapp/home/data/model/videoModel.dart';
import 'package:reelsapp/home/domain/repository/get_video_reels.dart';

import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoApiService apiService;
  final DefaultCacheManager cacheManager;

  VideoRepositoryImpl(this.apiService, this.cacheManager);

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

  void _cacheVideos(List<VideoModel> videos) async {
    final String jsonVideos = jsonEncode(videos.map((video) => video.toJson()).toList());
    await cacheManager.putFile('cached_videos.json', utf8.encode(jsonVideos));
  }

  Future<List<VideoModel>?> getCachedVideos() async {
    try {
      final file = await cacheManager.getSingleFile('cached_videos.json');
      final String cachedData = await file.readAsString();
      List<dynamic> decodedData = jsonDecode(cachedData);
      List<VideoModel> videos = decodedData.map((video) => VideoModel.fromJson(video)).toList();
      return videos;
    } catch (e) {
      return null;
    }
  }
}
