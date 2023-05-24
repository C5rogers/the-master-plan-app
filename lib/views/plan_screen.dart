import 'package:flutter/material.dart';
import 'package:master_plan/plan_provider.dart';
import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  final Plan? plan;
  const PlanScreen({super.key, this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  ScrollController? scrollController;

  Plan get plan => widget.plan!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController?.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController?.dispose();
    super.dispose();
  }

  Widget _buildList() {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTitle(plan.tasks[index]),
    );
  }

  Widget _buildTaskTitle(Task task) {
    return Dismissible(
      key: ValueKey(task),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        final controller = PlanProvider.of(context);
        controller.deleteTask(plan, task);
        setState(() {});
      },
      child: ListTile(
        leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
            setState(() {
              task.complete = selected!;
            });
          },
        ),
        title: TextFormField(
          initialValue: task.description,
          onChanged: (text) {
            setState(() {
              task.description = text;
            });
          },
        ),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        // setState(() {
        //   plan.tasks.add(Task());
        // });
        final controller = PlanProvider.of(context);
        controller.createTask(plan);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Plan'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildList()),
          SafeArea(child: Text(plan.compleatenessMessage))
        ],
      ),
      floatingActionButton: _buildAddTaskButton(),
    );
  }
}
