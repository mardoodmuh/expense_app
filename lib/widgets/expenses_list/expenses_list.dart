import 'package:flutter/material.dart';
import 'package:personal_expenses/models/expense.dart';
import 'package:personal_expenses/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expenses,
    required this.onRemoveExpense,
    super.key
  }) ;
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.8), margin: Theme.of(context).cardTheme.margin,),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
