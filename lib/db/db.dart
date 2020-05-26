//DB interface
import 'package:todolist/models/todo_models.dart';

class DbInterface {
  Future initDB() {
    return null;
  }

  Future<List<Map<String, dynamic>>> select(String table, {List arguments}) {
    return null;
  }

  Future<int> insert(String table, TodoModel model) {
    return null;
  }

  Future<int> update(String table, TodoModel model) {
    return null;
  }

  Future<int> delete(String table, TodoModel model) {
    return null;
  }
}
