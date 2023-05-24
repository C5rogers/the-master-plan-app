import 'package:flutter/material.dart';
import 'package:master_plan/controllers/plan_controller.dart';
import './models/data_layer.dart';

class PlanProvider extends InheritedWidget {
  // final _plan = <Plan>[];
  final _controller = PlanController();
  PlanProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }

  static PlanController of(BuildContext context) {
    PlanProvider? provider =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    // final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._controller;
  }
}
