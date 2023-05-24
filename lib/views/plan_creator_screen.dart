import 'package:flutter/material.dart';
import 'package:master_plan/models/plan.dart';
import 'package:master_plan/plan_provider.dart';
import 'package:master_plan/views/plan_screen.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  Widget _buildListCreater() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
              labelText: "Add Plan", contentPadding: EdgeInsets.all(20)),
          onEditingComplete: addPlan,
        ),
      ),
    );
  }

  void addPlan() {
    final text = textController.text;
    if (text.isEmpty) {
      return;
    }
    final controller = PlanProvider.of(context);
    controller.addNewPlan(text);
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildMasterPlans() {
    final plans = PlanProvider.of(context).plans;
    if (plans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            "You Dont Have Any Master Plans Yet!",
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      );
    }

    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Dismissible(
            key: ValueKey(plan),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              final controller = PlanProvider.of(context);
              controller.deletePlan(plan);
              setState(() {});
            },
            child: ListTile(
              title: Text(plan.name),
              subtitle: Text(plan.compleatenessMessage),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PlanScreen(plan: plan)));
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Plans'),
      ),
      body: Column(
        children: [_buildListCreater(), Expanded(child: _buildMasterPlans())],
      ),
    );
  }
}
