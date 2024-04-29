import 'package:equatable/equatable.dart';

class Composition extends Equatable {
  int id;
  String name;
  bool isSelected = false;

  Composition({
    required this.id,
    required this.name,
  });

  factory Composition.fromJson(Map<String, dynamic> json) {
    return Composition(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'id: $id, name: $name, isSelected: $isSelected';
  }

  @override
  List<Object?> get props => [id];
}
