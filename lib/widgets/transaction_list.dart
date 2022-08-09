import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added Yet!!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'asset/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 32,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '₹${transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? ElevatedButton(
                          // style: ElevatedButton.styleFrom(
                          //   primary: Colors.red, // background
                          //   onPrimary: Colors.white, // foreground
                          //),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.10,
                            child: Row(
                              children: [
                                Container(
                                  child: Text('Trash'),
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                Container(
                                  child: Icon(Icons.delete),
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ],
                            ),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}


// void comment{
//    Card(
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                           vertical: 12,
//                           horizontal: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).primaryColor,
//                             width: 2,
//                           ),
//                         ),
//                         padding: EdgeInsets.all(12),
//                         child: Text(
//                           '₹${transactions[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transactions[index].title,
//                             style: Theme.of(context).textTheme.headline6,
//                           ),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index].date),
//                             style: TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
// }