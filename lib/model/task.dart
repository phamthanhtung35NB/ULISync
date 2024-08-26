

class Task {
  String id;
  String title;
  String description;
  String groupId;
  String status;
  DateTime deadline;
  DateTime timeSubmitted;
  String linkFile;
  bool isLinkFile;
  String linkImage;
  bool isLinkImage;
  String assignedTo;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.groupId,
    this.status = 'chưa hoàn thành',
    required this.deadline,
    required this.timeSubmitted,
    this.linkFile = '',
    this.isLinkFile = false,
    this.linkImage = '',
    this.isLinkImage = false,
    this.assignedTo = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'groupId': groupId,
      'status': status,
      'deadline': deadline.toIso8601String(),
      'timeSubmitted': timeSubmitted.toIso8601String(),
      'linkFile': linkFile,
      'isLinkFile': isLinkFile,
      'linkImage': linkImage,
      'isLinkImage': isLinkImage,
      'assignedTo': assignedTo,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      groupId: map['groupId'],
      status: map['status'],
      deadline: DateTime.parse(map['deadline']),
      timeSubmitted: DateTime.parse(map['timeSubmitted']),
      linkFile: map['linkFile'],
      isLinkFile: map['isLinkFile'],
      linkImage: map['linkImage'],
      isLinkImage: map['isLinkImage'],
      assignedTo: map['assignedTo'],
    );
  }
}