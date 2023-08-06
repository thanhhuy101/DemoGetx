import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/todo.controller.dart';
import 'package:todo_app/models/todo.model.dart';

class TodoApp extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController _textEditingController = TextEditingController();

  void _showEditTodoDialog(BuildContext context, int index) {
    Todo todo = todoController.todos[index];
    _textEditingController.text = todo.title;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Todo'),
        content: TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(labelText: 'Todo title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String editedTitle = _textEditingController.text.trim();
              if (editedTitle.isNotEmpty) {
                Todo editedTodo = Todo(title: editedTitle, isDone: todo.isDone);
                todoController.edit(index, editedTodo);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App with GetX'),
      ),
      body: Obx(() => ListView.builder(
            itemCount: todoController.todos.length,
            itemBuilder: (context, index) {
              Todo todo = todoController.todos[index];
              return ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => todoController.status(index),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showEditTodoDialog(context, index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => todoController.remove(index),
                    ),
                  ],
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _textEditingController.text = '';

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Add Todo'),
              content: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: 'Todo title'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String title = _textEditingController.text.trim();
                    if (title.isNotEmpty) {
                      Todo newTodo = Todo(title: title);
                      todoController.add(newTodo);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
