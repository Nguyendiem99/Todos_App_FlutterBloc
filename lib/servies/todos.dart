import 'package:hive/hive.dart';
import 'package:todos_app_bloc/models/task.dart';

class Todo {
  late Box<Task> _tasks;
  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('tasks');
  }
  List<Task> getTasks(final String username){
    final tasks = _tasks.values.where((element) => element.user == username);
    return tasks.toList();
  }
  void addStask(final String task, final String username){
    _tasks.add(Task(username,task, false));
  }
  Future<void> removeTask(final String task,final String username) async {
    final taskToremove = await _tasks.values.firstWhere((element) => element.user==username && element.task ==task);
    await taskToremove.delete();
  }
  Future<void> updateTask(final String task, final String username) async {
    final taskToEdit = _tasks.values.firstWhere((element) => element.task == task && element.user == username);
    final index = taskToEdit.key as int;
    await _tasks.put(index,Task(username,task,!taskToEdit.completed));
  }
}