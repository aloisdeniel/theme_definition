import 'package:equatable/equatable.dart';

class Spacing extends Equatable {
  const Spacing(this.value);
  final double value;

  @override
  List<Object?> get props => [value];
}
