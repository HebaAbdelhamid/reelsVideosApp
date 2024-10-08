import 'package:reelsapp/home/domain/entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> fetchVideos();
}
