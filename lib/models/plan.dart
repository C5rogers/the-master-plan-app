import './task.dart';

class Plan {
  String name = '';
  final List<Task> tasks = [];

  int get completeCount => tasks.where((task) => task.complete).length;

  String get compleatenessMessage =>
      '$completeCount out of ${tasks.length} tasks';
}
