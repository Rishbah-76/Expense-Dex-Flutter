import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import '../widgets/transaction_list.dart';
import 'models/transactions.dart';
import 'widgets/input_new_transactions.dart';
import 'widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        errorColor: Color.fromARGB(255, 152, 166, 23),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromARGB(255, 80, 206, 215),
        ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 20,
            ),
            button: TextStyle(
              color: Colors.white38,
              fontSize: 12,
              fontFamily: 'QuickSand',
              fontWeight: FontWeight.bold,
            )),
      ),
      title: 'Expense-Dex',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 67.89,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New',
    //   amount: 56.25,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => id == element.id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return InputNewTransactions(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Expense-Dex"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Expense-Dex"),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add_box_sharp),
              )
            ],
          );

    final txtWidget = Container(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));

    final homePageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart's",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                      //activeColor: Theme.of(context).backgroundColor,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                width: double.infinity,
                height: (mediaQuery.size.height -
                        mediaQuery.padding.top -
                        appBar.preferredSize.height) *
                    0.3,
                child: Chart(_userTransaction),
              ),
            if (!isLandScape) txtWidget,
            if (isLandScape)
              _showChart
                  ? Container(
                      width: double.infinity,
                      height: (mediaQuery.size.height -
                              mediaQuery.padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: Chart(_userTransaction),
                    )
                  : txtWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: homePageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: homePageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
