import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final dateFormatter = DateFormat.yMd();
  Category _selectedCategory = Category.food;

  @override
    void dispose() {
      super.dispose();
      _titleController.dispose();
      _amountController.dispose();
    }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: 
                  TextField( 
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$',
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate==null ? 'Select Date' : dateFormatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final firstDate = DateTime(now.year-1, now.month, now.day);
                        final lastDate = now;
                        final DateTime? pickedDate = await showDatePicker(
                          context: context, 
                          initialDate: now, 
                          firstDate: firstDate, 
                          lastDate: lastDate
                        );
                        setState(() {
                          _selectedDate = pickedDate;                          
                        });
                      }, 
                      icon: const Icon(Icons.calendar_month_sharp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e, 
                      child: Text(e.name)
                    ),
                  ).toList(), 
                  onChanged: (newCategory){
                    if (newCategory == null) {
                      return;
                    }else{
                      setState(() {
                        _selectedCategory = newCategory;
                      });
                  }
                }
              ),
              const Spacer(),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(onPressed: () {
                final double? enteredAmount = double.tryParse(_amountController.text);
                final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
                
                if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
                  showDialog(
                    context: context, 
                    builder: (ctx) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Invalid Data!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: const Text('Okay'),
                        ),
                      ],
                    ),
                  );
                } else {
                  widget.onAddExpense(
                    Expense(
                      title: _titleController.text, 
                      amount: enteredAmount, 
                      date: _selectedDate!, 
                      category: _selectedCategory
                    )
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
              ),
            ],
          ),
        ],
      )
    );
  }
}
