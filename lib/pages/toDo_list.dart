import 'package:flutter/material.dart';
import '../service/http_service.dart';
import '../models/todo.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late Future<List<ToDo>> todosFuture;
  late HttpService service;

  @override
  void initState() {
    super.initState();
    service = HttpService();
    todosFuture = service.getToDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do List",
          style: TextStyle(
              color: Colors.white), // Mengubah warna teks menjadi putih
        ),
        backgroundColor: Colors
            .blue, // Mengatur latar belakang keseluruhan header menjadi biru
      ),
      body: FutureBuilder<List<ToDo>>(
        future: todosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ToDo todo = snapshot.data![index];
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${todo.id}. ',
                          style: TextStyle(
                            decoration: todo.completed!
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            todo.title!,
                            style: TextStyle(
                              decoration: todo.completed!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Checkbox(
                      value: todo.completed,
                      onChanged: (bool? value) {
                        setState(() {
                          todo.completed = value!;
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
