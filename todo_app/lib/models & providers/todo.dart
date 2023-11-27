class Todo {
  final String title;
  final List<String> tags;
  final String seletedTime;
  final DateTime? date;
  bool isCompleted;
  Todo({
    required this.title,
    required this.date,
    required this.seletedTime,
    required this.isCompleted,
    required this.tags,
  });
}
