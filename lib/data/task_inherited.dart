import 'package:alura_lista_tarefas_flutter/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required super.child});

  final List<Task> taskList = [
    Task("Aprender Flutter", "assets/images/flutter.png", 3),
    Task("Andar de Bike", "assets/images/bike.png", 2),
    Task("Meditar", "assets/images/meditar.jpg", 5),
    Task("Ler", "assets/images/ler.png", 4),
    Task("Jogar", "assets/images/jogar.jpg", 1),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
