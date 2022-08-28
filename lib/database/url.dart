import 'package:hive/hive.dart';

part 'url.g.dart';

@HiveType(typeId: 1)
class Url {
  Url({required this.url});
  @HiveField(0)
  String url;
}
