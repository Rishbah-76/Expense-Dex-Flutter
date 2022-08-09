import 'package:flutter/material.dart';
import '../widgets/bar_chart.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpendingforBarPercentage {
    return groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: BarChart(
                data['day'],
                data['amount'],
                totalSpendingforBarPercentage == 0.0
                    ? 0.0
                    : (data['amount'] as double) /
                        totalSpendingforBarPercentage,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
