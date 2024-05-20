import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class HttpService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<ToDo>> getToDo() async {
    final String uri = baseUrl;

    http.Response response = await http.get(Uri.parse(uri));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      List<ToDo> todos =
          jsonResponse.map((json) => ToDo.fromJson(json)).toList();
      return todos;
    } else {
      print("Failed to load todos");
      return [];
    }
  }
}
