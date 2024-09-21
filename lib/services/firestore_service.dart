import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ulis_ync/model/group.dart';
import 'package:ulis_ync/model/student.dart';
import 'package:ulis_ync/model/task.dart';
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createGroup(Group group) async {
    await _db.collection('groups').doc(group.id).set(group.toMap());
  }

  Future<List<Group>> getGroups() async {
    QuerySnapshot snapshot = await _db.collection('groups').get();
    return snapshot.docs.map((doc) => Group.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
  }

  Future<void> updateGroup(Group group) async {
    await _db.collection('groups').doc(group.id).update(group.toMap());
  }

  Future<void> deleteGroup(String groupId) async {
    await _db.collection('groups').doc(groupId).delete();
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

  Future<Task> getTask(String taskId) async {
    DocumentSnapshot doc = await _db.collection('tasks').doc(taskId).get();
    return Task.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> addMemberToGroup(String groupId, String email) async {
    DocumentReference groupRef = _db.collection('groups').doc(groupId);
    DocumentSnapshot groupDoc = await groupRef.get();
    if (groupDoc.exists) {
      Group group = Group.fromMap(groupDoc.data() as Map<String, dynamic>, groupDoc.id);
      Student newMember = await getStudentByEmail(email);
      group.students.add(newMember.id); // Ensure newMember.id is a string
      await groupRef.update(group.toMap());
    }
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ulis_ync/model/group.dart';
// import 'package:ulis_ync/model/task.dart';
// import 'package:ulis_ync/model/student.dart';
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   Future<void> createGroup(Group group) async {
//     await _db.collection('groups').doc(group.id).set(group.toMap());
//   }
//
//   Future<List<Group>> getGroups() async {
//     QuerySnapshot snapshot = await _db.collection('groups').get();
//     return snapshot.docs.map((doc) => Group.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
//   }
//   Future<void> updateGroup(Group group) async {
//     await _db.collection('groups').doc(group.id).update(group.toMap());
//   }
//
//   Future<void> deleteGroup(String groupId) async {
//     await _db.collection('groups').doc(groupId).delete();
//   }
//
//   // Future<void> addMemberToGroup(String groupId, String email) async {
//   //   DocumentSnapshot groupDoc = await _db.collection('groups').doc(groupId).get();
//   //   if (groupDoc.exists) {
//   //     Group group = Group.fromMap(groupDoc.data() as Map<String, dynamic>);
//   //     // Assuming you have a method to get a student by email
//   //     Student newMember = await getStudentByEmail(email);
//   //     group.students.add(newMember);
//   //     await _db.collection('groups').doc(groupId).update(group.toMap());
//   //   }
//   // }
//
//   Future<Student> getStudentByEmail(String email) async {
//     QuerySnapshot snapshot = await _db.collection('students').where('email', isEqualTo: email).get();
//     if (snapshot.docs.isNotEmpty) {
//       return Student.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
//     } else {
//       throw Exception('Student not found');
//     }
//   }
//
//   Future<void> addTask(Task task) async {
//     await _db.collection('tasks').doc(task.id).set(task.toMap());
//   }
//
//   Future<void> updateTask(Task task) async {
//     await _db.collection('tasks').doc(task.id).update(task.toMap());
//   }
//
//   Future<void> deleteTask(String taskId) async {
//     await _db.collection('tasks').doc(taskId).delete();
//   }
//
//   // Future<Group> getGroup(String groupId) async {
//   //   DocumentSnapshot doc = await _db.collection('groups').doc(groupId).get();
//   //   return Group.fromMap(doc.data() as Map<String, dynamic>);
//   // }
//
//   Future<Task> getTask(String taskId) async {
//     DocumentSnapshot doc = await _db.collection('tasks').doc(taskId).get();
//     return Task.fromMap(doc.data() as Map<String, dynamic>);
//   }
//   Future<void> addMemberToGroup(String groupId, Student newMember) async {
//     DocumentReference groupRef = _db.collection('groups').doc(groupId);
//     DocumentSnapshot groupDoc = await groupRef.get();
//     if (groupDoc.exists) {
//       Group group = Group.fromMap(groupDoc.data() as Map<String, dynamic>, groupDoc.id);
//       group.students.add(newMember.id); // Ensure newMember.id is a string
//       await groupRef.update(group.toMap());
//     }
//   }
// }