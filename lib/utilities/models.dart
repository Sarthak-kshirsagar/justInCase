import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projecthack/utilities/dateFunc.dart';

class Expense {
  double? amount;
  String category;
  String storeName;

  String description;

  Expense({
    required this.amount,
    required this.category,
    required this.storeName,

    required this.description,
  });
}
class ExpenseData {
  final double dailyExpense;
  final double monthlyExpense;
  final double yearlyIncome;

  ExpenseData(this.dailyExpense, this.monthlyExpense, this.yearlyIncome);
}
Future<void> addExpenseToFirestore(Expense expense) async {
  try {
    // Get the current user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Get the current month name
      String currentMonth = getCurrentMonth();

      // Create a document reference in "MonthlyIncome" subcollection
      DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
          .collection('userId')
          .doc(userId)
          .collection('MonthlyIncome')
          .doc(currentMonth);

      // Get the current document data or initialize it if it doesn't exist
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
      Map<String, dynamic> data = docSnapshot.exists ? docSnapshot.data()! : {};

      // Update the values for the current month and store
      data[expense.storeName] ??= 0.0;
      data[expense.storeName] += expense.amount;

      // Set the updated data back to the document
      await docRef.set(data);

      print('Expense added successfully for $currentMonth and store ${expense.storeName}');
    } else {
      print('User not logged in.');
      // Handle the case where the user is not logged in
    }
  } catch (e) {
    print('Error adding expense to Firestore: $e');
    // Handle the error as needed
  }
}

Future<void> addExpenseToFirestore2(Expense expense) async {
  try {
    // Get the current user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Get the current month name and year
      String currentMonth = getCurrentMonth();
      String currentYear = getCurrentYear();

      // Create a document reference in "CategorizeExpense"
      DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
          .collection('CategorizeExpense')
          .doc(userId);



      // Get the current document data or initialize it if it doesn't exist
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
      Map<String, dynamic> data = docSnapshot.exists ? docSnapshot.data()! : {};

      // Update the values for the current month and year
      data['userId'] = userId;
      data['shopName']= expense.storeName.toString();
      data['monthlyCategory'] ??= {};
      data['monthlyCategory'][currentMonth] ??= {};
      data['monthlyCategory'][currentMonth]['food'] ??= 0.0;
      data['monthlyCategory'][currentMonth]['food'] += expense.amount;

      data['yearlyCategory'] ??= {};
      data['yearlyCategory'][currentYear] ??= 0.0;
      data['yearlyCategory'][currentYear] += expense.amount;

      // Set the updated data back to the document
      await docRef.set(data);

      print('Expense added successfully for $currentMonth and $currentYear');
    } else {
      print('User not logged in.');
      // Handle the case where the user is not logged in
    }
  } catch (e) {
    print('Error adding expense to Firestore: $e');
    // Handle the error as needed
  }
}
Future<void> addExpenseToFirestorePayments(Expense expense) async {
  try {
    // Get the current user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Get the current month name and year
      String currentMonth = getCurrentMonth();
      String currentYear = getCurrentYear();
      String currentDate = getCurrentDate();

      // Create a document reference in "CategorizeExpense"
      DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
          .collection('Payments')
          .doc(userId);



      // Get the current document data or initialize it if it doesn't exist
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
      Map<String, dynamic> data = docSnapshot.exists ? docSnapshot.data()! : {};

      // Update the values for the current month and year
      data['userId'] = userId;
      data['dailyExpense'] ??={};

      data['monthlyCategory'] ??= {};
      data['monthlyCategory'][currentMonth] ??= 0.0;
      data['monthlyCategory'][currentMonth] += expense.amount;

      data['yearlyCategory'] ??= {};
      data['yearlyCategory'][currentYear] ??= 0.0;
      data['yearlyCategory'][currentYear] += expense.amount;

      data['dailyExpense'] ??= {};
      if (data['dailyExpense']['date'] == currentDate) {
        // If it's the same day, add the daily expense to the existing value
        data['dailyExpense']['value'] += expense.amount;
      } else {
        // If it's a new day, reset the daily expense to the new value
        data['dailyExpense'] = {'date': currentDate, 'value': expense.amount};
      }
      // Set the updated data back to the document
      await docRef.set(data);

      print('Expense added successfully for $currentMonth and $currentYear');
    } else {
      print('User not logged in.');
      // Handle the case where the user is not logged in
    }
  } catch (e) {
    print('Error adding expense to Firestore: $e');
    // Handle the error as needed
  }
}
Future<void> addExpenseToFirestoreShopsCollection(Expense expense) async {
  try {
    // Get the current user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Get the current month name and year
      String currentMonth = getCurrentMonth();
      String currentYear = getCurrentYear();

      // Create a document reference in "CategorizeExpense"
      DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
          .collection('ShopWiseExpense')
          .doc(userId);



      // Get the current document data or initialize it if it doesn't exist
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
      Map<String, dynamic> data = docSnapshot.exists ? docSnapshot.data()! : {};

      // Update the values for the current month and year
      data['userId'] = userId;
      // Handle ShopName
      data['shopName'] ??= {};
      data['shopName'][expense.storeName] ??= {};
      data['shopName'][expense.storeName][currentMonth] ??= 0.0;
      data['shopName'][expense.storeName][currentMonth] += expense.amount;



      // Set the updated data back to the document
      await docRef.set(data);

      print('Expense added successfully for $currentMonth and $currentYear');
    } else {
      print('User not logged in.');
      // Handle the case where the user is not logged in
    }
  } catch (e) {
    print('Error adding expense to Firestore: $e');
    // Handle the error as needed
  }
}


class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
