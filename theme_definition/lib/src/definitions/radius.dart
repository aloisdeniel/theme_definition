import 'package:equatable/equatable.dart';

class Radius extends Equatable {
  const Radius(this.value);
  final double value;

  @override
  List<Object?> get props => [value];
}
