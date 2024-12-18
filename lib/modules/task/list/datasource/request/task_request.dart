class TaskRequest {
  TaskRequest({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }

  final String title;
  final String description;
}
