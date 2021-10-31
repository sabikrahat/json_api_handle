import 'package:json_api_handle/models/todo.dart';
import 'package:json_api_handle/repository/repository.dart';

class TodoController {
  final Repository repository;

  TodoController({required this.repository});

  // get
  Future<List<Todo>> fetchTodoList() async {
    return repository.getTodosList();
  }

  // patch
  Future<String> updatePatchCompleted(Todo todo) async {
    return repository.patchCompleted(todo);
  }

  // put
  Future<String> updatePutCompleted(Todo todo) async {
    return repository.putCompleted(todo);
  }

  // post
  Future<String> postTodo(Todo todo) async {
    return repository.postTodo(todo);
  }

  // delete
  Future<String> deletedTodo(Todo todo) async {
    return repository.deletedTodo(todo);
  }
}
