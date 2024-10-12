import 'package:flutter/material.dart';
import 'package:reelsapp/home/data/dataSource/remote_data_source.dart';
import 'package:reelsapp/home/data/repository/get_video_reels_impl.dart';
import 'package:reelsapp/home/domain/useCases/grt_video_reels.dart';
import 'package:reelsapp/home/presentation/cubit/home_cubit.dart';
import 'package:reelsapp/home/presentation/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  // final apiService = VideoApiService();
  // final videoRepository = VideoRepositoryImpl(apiService);
  // final fetchVideosUseCase = FetchVideos(videoRepository);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  VideoApiService apiService = VideoApiService();
  VideoRepositoryImpl videoRepository = VideoRepositoryImpl(apiService, sharedPreferences);
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
