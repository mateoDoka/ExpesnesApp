import 'package:flutter/material.dart';

import '../models/expenses_model.dart';

class ExpensesCard extends StatelessWidget {
  const ExpensesCard(this.expenses, {super.key});
  final ExpensesModel expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expenses.title),
          const SizedBox(
            height: 4,
          ),
          Row(children: [
            Text(
              '\$${expenses.amount.toStringAsFixed(2)}',
            ),
            const Spacer(),
            Row(
              children: [
                Icon(categoryIcons[expenses.category]),
                Text(expenses.formatedDate)
              ],
            )
          ])
        ],
      ),
    ));
  }
}
