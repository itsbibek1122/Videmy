import 'package:flutter/cupertino.dart';

class Category {
  String name;
  Category({
    required this.name,
  });

  static map(Padding Function(dynamic e) param0) {}
}

List<Category> categories = [
  Category(
    name: 'Teacher',
  ),
  Category(
    name: 'Student',
  ),
];
