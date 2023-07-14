import 'package:expense_tracker/expenses/expenses_card.dart';
import 'package:expense_tracker/models/expenses_model.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});
  final List<ExpensesModel> expenses;
  final void Function(ExpensesModel expensesModel) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: Theme.of(context).cardTheme.margin,
        ),
        onDismissed: (direction) {
          removeExpense(
            expenses[index],
          );
        },
        child: ExpensesCard(expenses[index]),
      ),
    );
    // return Column(
    //   children: [for (var expense in expenses) ExpensesCard(expense)],
    // );
  }
}
