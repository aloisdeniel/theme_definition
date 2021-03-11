import 'package:equatable/equatable.dart';

class Image extends Equatable {
  const Image({
    required this.source,
    required this.path,
  });
  final String path;
  final ImageSource source;

  @override
  List<Object?> get props => [source, path];
}

enum ImageSource {
  asset,
  network,
}
