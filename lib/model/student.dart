import 'group.dart';

class Student {
  late String name;
  late int mssv;
  late List<Group> groups;

  Student(this.name, this.mssv, this.groups);

  @override
  String toString() {
    return 'Student{name: $name, mssv: $mssv, groups: $groups}';
  }




}