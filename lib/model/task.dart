class Task {
  String id;
  String title;
  String description;

  // đã hoàn thành
  //chưa hoàn thành
  // bị trễ
  // nộp mộn
  String status;

  //thời hạn hoàn thành DL
  DateTime deadline;

  // THời gian hoàn thành
  DateTime timeSubmitted;

  //Nộp muộn bao nhiêu lâu tính theo giờ, nếu khôg nộp muộn trả về -1
  int lateTime = -1;

  //thời gian còn lại để hoàn thành, nếu đã hoàn thành trả về -1
  int remainingTime = -1;

  //link file
  String linkFile;
  bool isLinkFile = false;

  //link ảnh
  String linkImage;
  bool isLinkImage = false;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.status,
      required this.deadline,
      required this.timeSubmitted,
      required this.linkFile,
      required this.linkImage});

  //Tạo task mới
  Task( this.title, this.description, this.deadline) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    title = title;
    description = description;
    deadline = deadline;
  }
  //update task
  //up date last time
  //update remaining time
  void updateTask(Task task) {
    description = task.description;
    deadline = task.deadline;
    status = task.status;
  }

  //update khi submit xong
  void updateSubmit(DateTime timeSubmitted,String linkFile,String linkImage,bool isLinkFile,bool isLinkImage) {
    this.timeSubmitted = timeSubmitted;
    if (timeSubmitted.isAfter(deadline)) {
      lateTime = -1;
    } else {
      lateTime = timeSubmitted.difference(deadline).inHours;
      // lateTime = timeSubmitted.difference(deadline).inHours;
    }
    if (isLinkFile==true) {
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
