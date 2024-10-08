import 'package:reelsapp/home/data/dataSource/remote_data_source.dart';
import 'package:reelsapp/home/domain/entities/video.dart';
import 'package:reelsapp/home/domain/repository/get_video_reels.dart';


class VideoRepositoryImpl implements VideoRepository {
  final VideoApiService apiService;

  VideoRepositoryImpl(this.apiService);

  @override
  Future<List<Video>> fetchVideos() {
    return apiService.fetchVideos();

  }


}
