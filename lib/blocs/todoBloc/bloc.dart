import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_bloc/blocs/todoBloc/event.dart';
import 'package:todos_app_bloc/blocs/todoBloc/state.dart';
import 'package:todos_app_bloc/servies/todos.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final Todo _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasks(event.username);
      emit(TodosLoadedState(
        todos,
        event.username,
      ));
    });

    on<AddTodoEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      add(LoadTodosEvent(currentState.username));
      _todoService.addStask(event.todoText, currentState.username);
    });

    on<ToggleTodoEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      await _todoService.updateTask(event.todoTask, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });
  }
}