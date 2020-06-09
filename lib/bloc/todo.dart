import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pedantic/pedantic.dart';
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

//TODO: optimization sql reqwesr, decrease, rewrite in memory

  Future getCategoryes({bool notify = true}) async {
    var _results = await SQLiteProvider.db.customSelect('SELECT t.* ,'
        '(SELECT COUNT(*) FROM ${TodoItem.table} i WHERE i.category=t.id AND i.completed=1 ) as completed, '
        '(SELECT COUNT(*) FROM ${TodoItem.table} i WHERE i.category=t.id ) as totalItems '
        'FROM ${TodoCategory.table} t');
    categoryes = _results
        .map<TodoCategory>((item) => TodoCategory.fromMap(item))
        .toList();
    if (notify) {
      notifyListeners();
    }
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

  Future deleteCategory(TodoCategory category) async {
    await SQLiteProvider.db.delete(TodoCategory.table, category);
    await SQLiteProvider.db
        .delete(TodoItem.table, category, where: 'category = ?');

    //await getCategoryes();
    log('Category deleted ${category.title}');
  }

  Future getItems(int categoryId, {bool notify = true}) async {
    var _results = await SQLiteProvider.db.select(TodoItem.table,
        where: '"category" = ?', whereArgs: [categoryId]);
    items = _results.map<TodoItem>((item) => TodoItem.fromMap(item)).toList();
    if (notify) {
      notifyListeners();
    }
  }

  Future addItem(TodoItem item) async {
    await SQLiteProvider.db.insert(TodoItem.table, item);
    log('Item add ${item.title}');
    await getItems(item.category);
  }

  void toggleItem(TodoItem item) async {
    final new_item = item.copyWith(completed: !item.completed);
    await SQLiteProvider.db.update(TodoItem.table, new_item);
    await getCategoryes(notify: false);
    await getItems(new_item.category, notify: false);
    
    /*
    unawaited(SQLiteProvider.db.update(TodoItem.table, new_item));
    //overwrrite TodoItem
    updateItem(new_item);

    final category_index =
        categoryes.indexWhere((old_item) => old_item.id == item.category);
    final old_category = categoryes[category_index];
    final new_category = categoryes[category_index].copyWith(
      completed: new_item.completed
          ? old_category.completed + 1
          : old_category.completed - 1,
    );
    updateCategory(new_category, index: category_index);
    */

    notifyListeners();
    log('Item toggle ${item.title}');
  }

  void updateItem(TodoItem item, {index}) {
    //search item if index not set
    index ??= items.indexWhere((old_item) => old_item.id == item.id);
    //overvrite
    items[index] = item;
  }

  void updateCategory(TodoCategory item, {index}) {
    //search item if index not set
    index ??= categoryes.indexWhere((old_item) => old_item.id == item.id);
    //overvrite
    categoryes[index] = item;
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
