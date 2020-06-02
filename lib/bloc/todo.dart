import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../db/sqlite.dart';
import '../models/todo_models.dart';

class Todo extends ChangeNotifier {
  Todo() {
    _init();
  }

  List<TodoItem> items = [];
  List<TodoCategory> categoryes = [];

  List<TodoItem> get items_completed =>
      items.where((item) => item.completed == true).toList();
  List<TodoItem> get items_unCompleted =>
      items.where((item) => item.completed == false).toList();

  int get total_items {
    var count = 0;

    for (var i = 0; i < categoryes.length; i++) {
      count += categoryes[i].totalItems - categoryes[i].completed;
    }

    return count;
  }

  void _init() async {
    await getCategoryes();
  }

  Future getCategoryes() async {
    var _results = await SQLiteProvider.db.customSelect('SELECT t.* ,'
        '(SELECT COUNT(*) FROM ${TodoItem.table} i WHERE i.category=t.id AND i.completed=1 ) as completed, '
        '(SELECT COUNT(*) FROM ${TodoItem.table} i WHERE i.category=t.id ) as totalItems '
        'FROM ${TodoCategory.table} t');
    categoryes = _results
        .map<TodoCategory>((item) => TodoCategory.fromMap(item))
        .toList();
    notifyListeners();
  }

  Future addCategory(TodoCategory category) async {
    await SQLiteProvider.db.insert(TodoCategory.table, category);
    log('Category added');
    await getCategoryes();
  }

  Future editCategory(
      TodoCategory old_category, TodoCategory new_category) async {
    if (old_category != new_category) {
      await SQLiteProvider.db.update(TodoCategory.table, new_category);
      log('Category edited');
      await getCategoryes();
    }
  }

  Future getItems(int categoryId) async {
    var _results = await SQLiteProvider.db.select(TodoItem.table,
        where: '"category" = ?', whereArgs: [categoryId]);
    items = _results.map<TodoItem>((item) => TodoItem.fromMap(item)).toList();
    notifyListeners();
  }

  Future addItem(TodoItem item) async {
    await SQLiteProvider.db.insert(TodoItem.table, item);
    log('Item add ${item.title}');
    await getItems(item.category);
  }

  Future toggleItem(TodoItem item) async {
    var new_item = TodoItem(
        id: item.id,
        category: item.category,
        title: item.title,
        description: item.description,
        completed: !item.completed);
    await SQLiteProvider.db.update(TodoItem.table, new_item);
    await getItems(item.category);
    log('Item toggle ${item.title}');
  }

  Future deleteItem(TodoItem item) async {
    await SQLiteProvider.db.delete(TodoItem.table, item);
    await getItems(item.category);
    log('Item delete ${item.title}');
  }

  Future editItem(TodoItem old_item, TodoItem new_item) async {
    if (old_item != new_item) {
      await SQLiteProvider.db.update(TodoItem.table, new_item);
      await getItems(new_item.category);
      log('Task edited ${old_item.title}');
    }
  }
}
