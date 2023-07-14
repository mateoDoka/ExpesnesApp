import 'package:expense_tracker/models/expenses_model.dart';
import 'package:flutter/material.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key, required this.onAddExpenses});
  final void Function(ExpensesModel expensesModel) onAddExpenses;
  @override
  State<AddExpenses> createState() {
    return _AddExpenses();
  }
}

class _AddExpenses extends State<AddExpenses> {
  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.work;
  void setDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpensesData() {
    final enteredAmount = double.tryParse(amountController.text);
    final amountValidation = enteredAmount == null || enteredAmount <= 0;
    if (textController.text.trim().isEmpty ||
        amountValidation ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    "Make sure title,amound,category and date were entered"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }
    widget.onAddExpenses(ExpensesModel(
        category: selectedCategory,
        title: textController.text,
        amount: enteredAmount,
        date: selectedDate!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    amountController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: textController,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text("Amount"), prefixText: '\$'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? 'No date selected'
                        : formater.format(selectedDate!)),
                    IconButton(
                        onPressed: setDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: submitExpensesData, child: const Text("Save")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"))
            ],
          ),
        ],
      ),
    );
  }
}
