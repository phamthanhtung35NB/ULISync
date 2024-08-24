class Student {
  String id;
  String name;
  String email;

  Student({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  String toString() {
    return 'Student{id: $id, name: $name, email: $email}';
  }
}