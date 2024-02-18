import 'package:codewithdheeraj/api/network.dart';
import 'package:codewithdheeraj/api/networkhelper.dart';
import 'package:codewithdheeraj/model/productmodel.dart';
import 'package:flutter/material.dart';

class TodoViewProvider extends ChangeNotifier {
  List<TodoModel> _todoModel = [];
  List<TodoModel> get todoModel => _todoModel;

  bool isLoading = false;

  setTodoModel(List<TodoModel> todoModel) {
    _todoModel = todoModel;
    notifyListeners();
  }

  getTodoResponse() async {
    isLoading = true;
    var finalResponse = await ServiceClass.getTodoData();

    if (finalResponse is Success) {
      setTodoModel(finalResponse.response as List<TodoModel>);
    }
    isLoading = false;
    if (finalResponse is Failure) {
      print(finalResponse.code);
      isLoading = false;
    }
  }

  void forEach(Null Function(dynamic p) param0) {}
}
