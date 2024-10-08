import 'package:reelsapp/home/domain/entities/video.dart';
import 'package:reelsapp/home/domain/repository/get_video_reels.dart';


class FetchVideos {
  final VideoRepository repository;

  FetchVideos(this.repository);

  Future<List<Video>> call() {
    return repository.fetchVideos();
  }
}

