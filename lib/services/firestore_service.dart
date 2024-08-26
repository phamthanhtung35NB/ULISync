import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ulis_ync/model/group.dart';
import 'package:ulis_ync/model/task.dart';
import 'package:ulis_ync/model/student.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createGroup(Group group) async {
    await _db.collection('groups').doc(group.id).set(group.toMap());
  }

  Future<void> updateGroup(Group group) async {
    await _db.collection('groups').doc(group.id).update(group.toMap());
  }

  Future<void> deleteGroup(String groupId) async {
    await _db.collection('groups').doc(groupId).delete();
  }

  Future<void> addMemberToGroup(String groupId, String email) async {
    DocumentSnapshot groupDoc = await _db.collection('groups').doc(groupId).get();
    if (groupDoc.exists) {
      Group group = Group.fromMap(groupDoc.data() as Map<String, dynamic>);
      // Assuming you have a method to get a student by email
      Student newMember = await getStudentByEmail(email);
      group.students.add(newMember);
      await _db.collection('groups').doc(groupId).update(group.toMap());
    }
  }

  Future<Student> getStudentByEmail(String email) async {
    QuerySnapshot snapshot = await _db.collection('students').where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      return Student.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      throw Exception('Student not found');
    }
  }

  Future<void> addTask(Task task) async {
    await _db.collection('tasks').doc(task.id).set(task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _db.collection('tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _db.collection('tasks').doc(taskId).delete();
  }

  Future<Group> getGroup(String groupId) async {
    DocumentSnapshot doc = await _db.collection('groups').doc(groupId).get();
    return Group.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<Task> getTask(String taskId) async {
    DocumentSnapshot doc = await _db.collection('tasks').doc(taskId).get();
    return Task.fromMap(doc.data() as Map<String, dynamic>);
  }
}