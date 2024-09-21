import 'package:ulis_ync/model/student.dart';

class Group {
  final String id;
  final String name;
  final String description;
  final String image;
  final String ownerId;
  final List<String> students;

  Group({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.ownerId,
    required this.students,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'ownerId': ownerId,
      'students': students, // Ensure students is a list of strings
    };
  }

  factory Group.fromMap(Map<String, dynamic> data, String documentId) {
    return Group(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      ownerId: data['ownerId'] ?? '',
      students: List<String>.from(data['students'] ?? []),
    );
  }
}