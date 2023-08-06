import 'package:get/get.dart';

import '../models/todo.model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void add(Todo todo) {
    todos.add(todo);
  }

  void edit(int index, Todo edited) {
    todos[index] = edited;
  }

  void remove(int index) {
    todos.removeAt(index);
  }

  void status(int index) {
    todos[index].isDone = !todos[index].isDone;
  }
}
