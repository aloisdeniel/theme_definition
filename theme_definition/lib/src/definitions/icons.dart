import 'package:equatable/equatable.dart';

class Icon extends Equatable {
  const Icon(this.data);
  final String data;

  @override
  List<Object?> get props => [data];
}
