//DB interface
import '../models/todo_models.dart';

class DbInterface {
  Future initDB() {
    return null;
  }

  Future<List<Map<String, dynamic>>> select(String table,
      {bool distinct,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) {
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
