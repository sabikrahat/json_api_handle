import 'package:flutter/material.dart';
import 'package:json_api_handle/controller/todo_controller.dart';
import 'package:json_api_handle/models/todo.dart';
import 'package:json_api_handle/repository/todo_respository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // dependency injection
    var todoController = TodoController(repository: TodoRepository());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rest Api'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          //
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }
          return buildBodyContainer(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Todo todo = Todo(
            userId: 3,
            title: 'sample post',
            completed: false,
          );
          todoController.postTodo(todo);
        },
      ),
    );
  }

  SafeArea buildBodyContainer(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
        itemCount: snapshot.data?.length ?? 0,
        itemBuilder: (context, index) {
          Todo todo = snapshot.data![index];
          return Container(
            height: 100.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text('${todo.id}')),
                Expanded(flex: 3, child: Text('${todo.title}')),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          todoController.updatePatchCompleted(todo).then(
                            (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 500),
                                  content: Text(value),
                                ),
                              );
                            },
                          );
                        },
                        child: buildCallContainer(
                          title: 'Patch',
                          color: Colors.orange[100]!,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          todoController.updatePutCompleted(todo);
                        },
                        child: buildCallContainer(
                          title: 'Put',
                          color: Colors.purple[100]!,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          todoController.deletedTodo(todo).then(
                            (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 500),
                                  content: Text(value),
                                ),
                              );
                            },
                          );
                        },
                        child: buildCallContainer(
                          title: 'Del',
                          color: Colors.red[100]!,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0.5,
            height: 0.5,
          );
        },
      ),
    );
  }

  Container buildCallContainer({required String title, required Color color}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Text(title)),
    );
  }
}
