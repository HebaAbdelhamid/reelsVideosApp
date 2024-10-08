import 'package:reelsapp/home/domain/useCases/grt_video_reels.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelsapp/home/presentation/cubit/home_states.dart';



class VideoCubit extends Cubit<VideoState> {
  final FetchVideos fetchVideos;

  VideoCubit(this.fetchVideos) : super(VideoInitial());

  Future<void> loadVideos() async {
    try {
      emit(VideoLoading());
      final videos = await fetchVideos();
      emit(VideoLoaded(videos));
    } catch (e) {
      emit(VideoError('Failed to fetch videos'));
    }
  }
}
