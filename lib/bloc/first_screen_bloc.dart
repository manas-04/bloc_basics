// ignore_for_file: file_names

import 'dart:async';
import 'package:dio/dio.dart';

import '../main.dart';
import '../models/url_response.dart';
import '../bloc/first_screen_state.dart';
import './first_screen_event.dart';

class FirstScreenBloc {
  FirstScreenState _state = const Loading();
  final _stateController = StreamController<FirstScreenState>.broadcast();

  StreamSink<FirstScreenState> get _inValueSink => _stateController.sink;
  Stream<FirstScreenState> get value => _stateController.stream;

  final _eventController = StreamController<FirstScreenEvent>();

  Sink<FirstScreenEvent> get eventSink => _eventController.sink;

  _handleLoadDataEvent(LoadDataEvent event) async {
    var dio = Dio();
    final response = await dio.get('https://random.dog/woof.json');
    final data = UrlResponse.fromJson(response.data);
    _state = Loaded(data: data, isImageLoading: true);
    _inValueSink.add(_state);
  }

  FirstScreenBloc() {
    void _mapEventToState(FirstScreenEvent event) {
      if (event is LoadDataEvent) {
        _handleLoadDataEvent(event);
      } else if (event is SaveToHiveEvent) {
        box.put('imageUrl', (_state as Loaded).data.url);
      } else if (event is ImageLoadedEvent) {
        if (_state is Loaded) {
          _state = Loaded(data: (_state as Loaded).data, isImageLoading: false);
          _inValueSink.add(_state);
        }
      }
    }

    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
