import 'package:ulis_ync/model/student.dart';

class Group {
  String id;
  String name;
  String description;
  String image;
  String ownerId;
  List<Student> students;

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
      'students': students.map((student) => student.toMap()).toList(),
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      ownerId: map['ownerId'],
      students: List<Student>.from(map['students']?.map((x) => Student.fromMap(x))),
    );
  }
}