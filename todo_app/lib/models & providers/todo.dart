class Todo {
  final String title;
  final String shortNote;
  final String time;
  final DateTime? date;
  bool isCompleted;
  Todo({
    required this.title,
    required this.time,
    required this.date,
    required this.isCompleted,
    required this.shortNote,
  });
}
