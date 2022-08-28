import 'package:equatable/equatable.dart';

import '../models/post_response.dart';

abstract class SecondScreenState {
  const SecondScreenState();
}

class Loading extends SecondScreenState {
  const Loading();
}

class Loaded extends SecondScreenState with EquatableMixin {
  final List<PostResponse> data;
  const Loaded({required this.data});

  @override
  List<Object?> get props => [data];
}
