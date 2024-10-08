import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelsapp/home/presentation/components/video_player_page.dart';
import 'package:reelsapp/home/presentation/cubit/home_cubit.dart';
import 'package:reelsapp/home/presentation/cubit/home_states.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos Reels'),
        centerTitle: true,
      ),
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is VideoLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context,index)=>SizedBox(height: 7,),
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                final video = state.videos[index];
                return
                  VideoPlayerPage(videoUrl: video.videoUrl,
                  autoPlay: index==0,)
                ;
              },
            );
          } else if (state is VideoError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No Videos'));
          }
        },
      ),
    );
  }
}


