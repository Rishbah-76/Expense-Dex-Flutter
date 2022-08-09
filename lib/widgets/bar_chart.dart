import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingPercentageOfTotal;
  BarChart(
      this.label, double this.amount, double this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '₹${amount.toStringAsFixed(0)}',
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.5,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //color: Color.fromARGB(136, 131, 191, 91),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(135, 105, 150, 41),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            child: FittedBox(
              child: Text(label),
            ),
            height: constraints.maxHeight * 0.15,
          ),
        ],
      );
    });
  }
}
