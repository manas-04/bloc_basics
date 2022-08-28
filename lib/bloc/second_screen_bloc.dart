// ignore_for_file: file_names

import 'dart:async';

import 'package:dio/dio.dart';

import '../models/post_response.dart';
import '../bloc/second_screen_state.dart';
import './second_screen_event.dart';

class SecondScreenBloc {
  SecondScreenState _state = const Loading();
  final _secondScreenStateController = StreamController<SecondScreenState>();

  StreamSink<SecondScreenState> get _inValue =>
      _secondScreenStateController.sink;
  Stream<SecondScreenState> get value => _secondScreenStateController.stream;

  final _secondScreenEventController = StreamController<SecondScreenEvent>();

  Sink<SecondScreenEvent> get eventSink => _secondScreenEventController.sink;

  _handleLoadDataEvent(SecondScreenEvent event) async {
    var dio = Dio();
    final response = await dio.get('http://jsonplaceholder.typicode.com/posts');
    final data = response.data
        .map<PostResponse>((element) => PostResponse.fromJson(element))
        .toList();
    _state = Loaded(data: data);
    _inValue.add(_state);
  }

  SecondScreenBloc() {
    void _mapEventToState(SecondScreenEvent event) {
      if (event is SetDataEvent) {
        _handleLoadDataEvent(event);
      }
    }

    _secondScreenEventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _secondScreenEventController.close();
    _secondScreenStateController.close();
  }
}
