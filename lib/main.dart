import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:reelsapp/home/data/dataSource/remote_data_source.dart';
import 'package:reelsapp/home/data/repository/get_video_reels_impl.dart';
import 'package:reelsapp/home/domain/useCases/grt_video_reels.dart';
import 'package:reelsapp/home/presentation/cubit/home_cubit.dart';
import 'package:reelsapp/home/presentation/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() async{
  final String baseUrl="https://api.sawalef.app/api/v1";

  WidgetsFlutterBinding.ensureInitialized();
  VideoApiService apiService = VideoApiService(baseUrl);
  DefaultCacheManager cacheManager=DefaultCacheManager();
  VideoRepositoryImpl videoRepository = VideoRepositoryImpl(apiService, cacheManager);
  FetchVideos fetchVideosUseCase = FetchVideos(videoRepository);

  runApp(MyApp(fetchVideosUseCase));
}

class MyApp extends StatelessWidget {
  final FetchVideos fetchVideos;

  MyApp(this.fetchVideos);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => VideoCubit(fetchVideos)..loadVideos(),
        child: HomePage(),
      ),
    );
  }
}
