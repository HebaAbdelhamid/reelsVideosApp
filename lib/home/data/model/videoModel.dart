import 'package:reelsapp/home/domain/entities/video.dart';

class VideoModel extends Video {
  VideoModel({required super.id, required super .videoUrl});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      videoUrl: json['video'], // Assuming the video URL is in the 'video' field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'video': videoUrl,
    };
  }
}

