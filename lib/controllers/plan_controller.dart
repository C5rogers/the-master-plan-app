import '../models/data_layer.dart';

class PlanController {
  final _plans = <Plan>[];

  // this list can't be modified by any other class
  List<Plan> get plans => List.unmodifiable(_plans);

  // this will create new plan as suggested
  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }
    name = _checkForDuplicates(_plans.map((plan) => plan.name), name);
    final plan = Plan()..name = name;
    _plans.add(plan);
  }

  void deletePlan(Plan plan) {
    _plans.remove(plan);
  }

  void createTask(Plan plan, [String? description]) {
    if (description == null || description.isEmpty) {
      description = "New Task";
    }

    description = _checkForDuplicates(
        plan.tasks.map((t) => t.description.toString()), description);

    final task = Task()..description = description;
    plan.tasks.add(task);
  }

  void deleteTask(Plan plan, Task task) {
    plan.tasks.remove(task);
  }

  String _checkForDuplicates(Iterable<String> items, String text) {
    final duplicatedList = items.where((item) => item.contains(text)).length;
    if (duplicatedList > 0) {
      text += '${duplicatedList + 1}';
    }
    return text;
  }
}
