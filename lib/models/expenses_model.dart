import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formater = DateFormat.yMd();

enum Category { work, travel, leisure, food }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpensesModel {
  ExpensesModel(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get formatedDate {
    return formater.format(date);
  }
}
