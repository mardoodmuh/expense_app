import 'package:flutter/material.dart';
import 'package:personal_expenses/models/expense.dart';
import 'package:personal_expenses/widgets/new_expense.dart';
import 'expenses_list/expenses_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Expense> _registeredExpenses = [
    Expense(
      category: Category.work,
      title: 'Flutter Course', 
      amount: 29.9, 
      date: DateTime.now(),
    ),
    Expense(
      category: Category.food,
      title: 'Doner', 
      amount: 2.9, 
      date: DateTime.now(),
    ),
     Expense(
      category: Category.travel,
      title: 'Flight Ticket', 
      amount: 249.9, 
      date: DateTime.now(),
    ),
      Expense(
      category: Category.leisure,
      title: 'Movie Ticket', 
      amount: 3.5, 
      date: DateTime.now(),
    ),
      Expense(
      category: Category.leisure,
      title: 'Video Game on Steam', 
      amount: 13.4, 
      date: DateTime.now(),
    ),
  ];

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Bar!"),
        actions: [
          IconButton(onPressed: () {
            showModalBottomSheet(
              context: context, 
              builder: (c) => NewExpense(onAddExpense: _addExpense),
            );
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded( 
              child:  ExpensesList(
                expenses: _registeredExpenses, 
                onRemoveExpense: _removeExpense,
              ),  
            )
          ],
        ),
      ),
    );
  }
}
