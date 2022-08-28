import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../bloc/first_screen_event.dart';
import '../bloc/first_screen_state.dart';
import './second_screen.dart';
import '../bloc/first_screen_bloc.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late final FirstScreenBloc _bloc;
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    _bloc = FirstScreenBloc();
    _bloc.eventSink.add(LoadDataEvent());

    _bloc.value.listen((state) {
      if (state is Loaded) {
        resolve(state);
      }
    });
  }

  resolve(Loaded state) async {
    if (state.data.isVideo && state.isImageLoading) {
      setState(() {
        controller = VideoPlayerController.network(state.data.url)
          ..addListener(() {
            setState(() {});
          })
          ..setLooping(true)
          ..setVolume(0.5);
      });
      await controller.initialize();
      _bloc.eventSink.add(ImageLoadedEvent());
      controller.play();
      // ..initialize();
      // .then((value) {
      //   _bloc.eventSink.add(ImageLoadedEvent());
      //   controller.play();
      // });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: _bloc.value,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data is Loaded) {
              final state = snapshot.data as Loaded;
              late Image image;
              // print(state.data.url);
              if (!state.data.isVideo) {
                image = Image.network(state.data.url);
                image.image.resolve(const ImageConfiguration()).addListener(
                  ImageStreamListener(
                    (info, call) {
                      _bloc.eventSink.add(ImageLoadedEvent());
                    },
                  ),
                );
              }

              return Center(
                child: Container(
                  height: size.height * 0.5,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: size.height * 0.06,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 206, 206),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: state.data.isVideo
                      ? controller.value.isInitialized
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: VideoPlayer(controller),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: state.isImageLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : image,
                        ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: StreamBuilder(
        stream: _bloc.value,
        builder: (context, snapshot) {
          return (snapshot.hasData &&
                  snapshot.data is Loaded &&
                  !(snapshot.data as Loaded).isImageLoading)
              ? FloatingActionButton.extended(
                  onPressed: () {
                    _bloc.eventSink.add(SaveToHiveEvent());
                    Navigator.of(context).pushNamed(Screen2.routeName);
                  },
                  label: const Text('Save and Move'),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
