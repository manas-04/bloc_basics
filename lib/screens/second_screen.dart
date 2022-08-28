import 'package:flutter/material.dart';

import '../bloc/second_screen_state.dart';
import '../bloc/second_screen_bloc.dart';
import '../bloc/second_screen_event.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);
  static const String routeName = "/screeen2";

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late final SecondScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SecondScreenBloc();
    _bloc.eventSink.add(SetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen2'),
      ),
      body: StreamBuilder(
        initialData: false,
        stream: _bloc.value,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data is Loaded) {
              final state = snapshot.data as Loaded;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(state.data[index].id),
                    elevation: 4,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 2),
                      child: ListTile(
                        title: Text(
                          'Title : ${state.data[index].title}',
                          style: const TextStyle(fontSize: 17),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Body : ${state.data[index].body}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 88, 88, 88),
                            ),
                          ),
                        ),
                      ),
                    ),
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
    );
  }
}
