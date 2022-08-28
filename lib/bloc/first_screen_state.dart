import 'package:equatable/equatable.dart';

import '../models/url_response.dart';

abstract class FirstScreenState {
  const FirstScreenState();
}

class Loading extends FirstScreenState {
  const Loading();
}

class Loaded extends FirstScreenState with EquatableMixin {
  final UrlResponse data;
  final bool isImageLoading;
  const Loaded({required this.data, required this.isImageLoading});

  @override
  List<Object?> get props => [data, isImageLoading];
}
