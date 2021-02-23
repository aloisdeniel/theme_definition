import 'package:equatable/equatable.dart';

class Size extends Equatable {
  const Size(this.width, this.height);
  final double width;
  final double height;

  @override
  List<Object?> get props => [width, height];
}
