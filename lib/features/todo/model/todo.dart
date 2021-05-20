class Todo {
  final String title;
  final bool isCompleted;
  final String id;
  final String timestamp;

  Todo({this.title, this.isCompleted, this.id, this.timestamp});

  Todo copyWith({String title, bool isCompleted, String id, String timestamp}) {
    return Todo(
        id: id ?? this.id,
        isCompleted: isCompleted ?? this.isCompleted,
        timestamp: timestamp ?? this.timestamp,
        title: title ?? this.title);
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'],
        isCompleted: json['isCompleted'],
        title: json['title'],
        timestamp: json['timestamp']);
  }

  static Map<String, dynamic> toJson(Todo todo) {
    return {
      "isCompleted": todo.isCompleted ?? false,
      "title": todo.title ?? "",
      "timestamp": todo.timestamp ?? "",
      "id": todo.id ?? ""
    };
  }
}
