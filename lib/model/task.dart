class Task {
  String id;
  String title;
  String description;
  String status;
  DateTime deadline;
  DateTime timeSubmitted;
  int lateTime = -1;
  int remainingTime = -1;
  String linkFile;
  bool isLinkFile = false;
  String linkImage;
  bool isLinkImage = false;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.deadline,
    required this.timeSubmitted,
    required this.linkFile,
    required this.linkImage,
  });

  Task.newTask(this.title, this.description, this.deadline)
      : id = DateTime.now().millisecondsSinceEpoch.toString(),
        status = 'chưa hoàn thành',
        timeSubmitted = DateTime.now(),
        linkFile = '',
        linkImage = '';

  void updateTask(Task task) {
    description = task.description;
    deadline = task.deadline;
    status = task.status;
  }

  void updateSubmit(DateTime timeSubmitted, String linkFile, String linkImage, bool isLinkFile, bool isLinkImage) {
    this.timeSubmitted = timeSubmitted;
    if (timeSubmitted.isAfter(deadline)) {
      lateTime = -1;
    } else {
      lateTime = timeSubmitted.difference(deadline).inHours;
    }
    if (isLinkFile) {
      this.linkFile = linkFile;
      this.isLinkFile = true;
      this.isLinkImage = false;
    } else {
      this.linkFile = "";
      this.isLinkFile = false;
      this.isLinkImage = true;
    }
  }
}