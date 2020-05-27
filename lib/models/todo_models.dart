import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../utils/icons.dart';

abstract class TodoModel extends Equatable{
  final int id;

  const TodoModel({this.id});

  factory TodoModel.fromMap(){
    return null;
  }
  Map toMap(){
    return null;
  }

  ////override toString
  @override
  bool get stringify => true;
}

class TodoCategory extends TodoModel{
  @override
  final int id;
  final String title;
  final IconData icon;

  static final String table = 'Categories';

  const TodoCategory({this.id, this.title = '', this.icon});

  factory TodoCategory.fromMap(Map<String, dynamic> map) => TodoCategory(
        id: map['id'],
        title: map['title'],        
        icon: map['icon'].toString().getFontAwesomeIcon
      );

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'icon': icon.getFontAwesomeString
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  //override bool operator ==
  @override
  List<Object> get props => [id, title, icon];

}

class TodoItem extends TodoModel{
  @override
  final id;
  final int category;
  final String title;
  final String description;
  final bool completed;

  static final String table = 'Items';

  const TodoItem(
      {this.id,
      this.category,
      this.title = '',
      this.description = '',
      this.completed = false});

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'category': category,
      'title': title,
      'description': description,
      'completed': completed ? '1' : '0'
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) => TodoItem(
      id: map['id'],
      category: map['category'],
      title: map['title'],
      description: map['description'],
      completed: map['completed'] == 1);

  //override bool operator ==
  @override
  List<Object> get props => [id, category, title, description, completed];
}
