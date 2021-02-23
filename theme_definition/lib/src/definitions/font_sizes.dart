import 'package:equatable/equatable.dart';

class FontSize extends Equatable {
  const FontSize(this.value);
  final double value;

  @override
  List<Object?> get props => [value];
}
