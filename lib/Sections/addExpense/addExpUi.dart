import 'package:flutter/material.dart';

class ExpenseEntry {
  final double amount;
  final String category;
  final DateTime date;
  final String? shopName;
  final String? itemDescription;

  ExpenseEntry({
    required this.amount,
    required this.category,
    required this.date,
    this.shopName,
    this.itemDescription,
  });
}

class AddExpenseScreen extends StatefulWidget {
  // final Function(ExpenseEntry) onSave;
  // final ExpenseEntry? initialEntry;

  AddExpenseScreen();

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
//     if (widget.initialEntry != null) {
// // Populate fields if editing an existing entry
//       amountController.text = widget.initialEntry!.amount.toString();
//       selectedCategory = widget.initialEntry!.category;
//       selectedDate = widget.initialEntry!.date;
//       shopNameController.text = widget.initialEntry!.shopName ?? '';
//       itemDescriptionController.text = widget.initialEntry!.itemDescription ?? '';
//     }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

//   void _saveExpense() {
//     if (amountController.text.isEmpty || selectedCategory == null) {
// // You can add additional validation logic here if needed
//       return;
//     }
//
//     double amount = double.parse(amountController.text);
//     widget.onSave(ExpenseEntry(
//       amount: amount,
//       category: selectedCategory!,
//       date: selectedDate,
//       shopName: shopNameController.text.isNotEmpty ? shopNameController.text : null,
//       itemDescription: itemDescriptionController.text.isNotEmpty ? itemDescriptionController.text : null,
//     ));
//     Navigator.pop(context); // Close the AddExpenseScreen after saving
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: ['Food', 'Health', 'Fashion']
                  .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: shopNameController,
              decoration: InputDecoration(labelText: 'Shop Name (Optional)'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: itemDescriptionController,
              decoration: InputDecoration(labelText: 'Item Description (Optional)'),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text('Date: ${selectedDate.toLocal()}'),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: (){},
              child: Text('Save Expense'),
            ),
          ],
        ),
      ),
    );
  }
}