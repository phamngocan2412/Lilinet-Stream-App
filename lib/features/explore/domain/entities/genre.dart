import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String id;
  final String name;
  final String? icon;

  const Genre({
    required this.id,
    required this.name,
    this.icon,
  });

  @override
  List<Object?> get props => [id, name, icon];
}
