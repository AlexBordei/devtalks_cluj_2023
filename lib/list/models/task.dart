class Task {
  final int? id;
  final String title;
  final String description;
  final bool done;

  Task(
      {this.id,
      required this.title,
      required this.description,
      this.done = false});

  // Create a Task from JSON data
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      done: json['done'] ?? false,
    );
  }

  // Convert Task to JSON format
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'done': done,
    };
  }

  // Assuming you'll update this method to handle copying properties
  copyWith({required bool done}) {
    return Task(
      id: id,
      title: title,
      description: description,
      done: done,
    );
  }
}
