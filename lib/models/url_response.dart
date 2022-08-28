import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as path;

class UrlResponse with EquatableMixin {
  final int fileSizeBytes;
  final String url;
  final bool isVideo;

  const UrlResponse(this.fileSizeBytes, this.url, this.isVideo);

  factory UrlResponse.fromJson(Map<String, dynamic> json) => UrlResponse(
        json["fileSizeBytes"],
        json["url"],
        path.extension(json['url']) == ".mp4",
      );

  @override
  List<Object?> get props => [fileSizeBytes, url];
}
