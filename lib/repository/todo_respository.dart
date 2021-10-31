import 'package:flutter/foundation.dart';
import 'package:json_api_handle/models/todo.dart';
import 'package:json_api_handle/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository extends Repository {
  // http url
  String dataURL = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<Todo>> getTodosList() async {
    List<Todo> todoList = [];
    // https://jsonplaceholder.typicode.com/todos
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      debugPrint('Status Code: ${response.statusCode}');
      var body = json.decode(response.body);
      // parse
      for (int i = 0; i < body.length; i++) {
        todoList.add(Todo.fromJson(body[i]));
      }
    } else {
      debugPrint('Status Code: ${response.statusCode}');
    }
    return todoList;
  }

  @override
  Future<String> patchCompleted(Todo todo) async {
    String resData = '';

    var url = Uri.parse('$dataURL/todos/${todo.id}');
    await http.patch(
      url,
      body: {'completed': (!todo.completed!).toString()},
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);

      return resData = result['completed'];
    });
    print(resData);
    return resData;
  }

  @override
  Future<String> putCompleted(Todo todo) async {
    String resData = '';

    var url = Uri.parse('$dataURL/todos/${todo.id}');
    await http.put(
      url,
      body: {'completed': (!todo.completed!).toString()},
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
    });
    print(resData);
    return resData;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    print(todo.toJson());
    var url = Uri.parse('$dataURL/todos/');
    String result = '';
    var response = await http.post(url, body: todo.toJson());
    if (response.statusCode == 201) {
      debugPrint('Status Code: ${response.statusCode}');
      var body = json.decode(response.body);
      debugPrint('Response Body: $body');
      result = 'true';
    } else {
      debugPrint('Status Code: ${response.statusCode}');
    }

    return result;
  }

  @override
  Future<String> deletedTodo(Todo todo) async {
    String result = 'false';
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    await http.delete(url).then((response) {
      print(response.body);
      return result = 'true';
    });
    return result;
  }
}
