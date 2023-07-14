import 'package:expense_tracker/expenses/expenses_list.dart';
import 'package:expense_tracker/models/expenses_model.dart';
import 'package:expense_tracker/new_expenses_widget/add_expenses_widget.dart';
import 'package:flutter/material.dart';

class ExpensesUiScreen extends StatefulWidget {
  const ExpensesUiScreen({super.key});

  @override
  State<ExpensesUiScreen> createState() {
    return _ExpensesUiScreen();
  }
}

class _ExpensesUiScreen extends State<ExpensesUiScreen> {
  final List<ExpensesModel> _registeredExpenses = [];
  void _addExpensesOVerlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddExpenses(
            onAddExpenses: _addExpense,
          );
        });
  }

  void _addExpense(ExpensesModel expensesModel) {
    setState(() {
      _registeredExpenses.add(expensesModel);
    });
  }

  void _removeExpenses(ExpensesModel expensesRemove) {
    final expenseIndex = _registeredExpenses.indexOf(expensesRemove);
    setState(() {
      _registeredExpenses.remove(expensesRemove);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense Deleted"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expensesRemove);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContetn = const Center(
      child: Text('No items on the list'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContetn = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
        actions: [
          IconButton(
              onPressed: _addExpensesOVerlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: mainContetn,
          )
        ],
      ),
    );
  }
}
