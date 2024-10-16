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

      for (var video in videos) {
        await _downloadAndCacheVideo(video.videoUrl, video.id as String);
      }

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

  Future<void> _downloadAndCacheVideo(String videoUrl, String videoId) async {
    try {
      final videoResponse = await apiService.downloadVideo(videoUrl);
      if (videoResponse != null) {
        await cacheManager.putFile('$videoId.mp4', videoResponse);
      }
    } catch (e) {
      print('Error caching video $videoId: $e');
    }
  }

  Future getCachedVideo(String videoId) async {
    try {
      final cachedVideoFile = await cacheManager.getSingleFile('$videoId.mp4');
      return cachedVideoFile;
    } catch (e) {
      print('Error retrieving cached video $videoId: $e');
      return null;
    }
  }
}
