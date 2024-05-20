class ToDo {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  ToDo({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
