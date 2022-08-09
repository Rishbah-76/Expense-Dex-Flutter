import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputNewTransactions extends StatefulWidget {
  final Function addNewTransactions;

  InputNewTransactions(this.addNewTransactions);

  @override
  State<InputNewTransactions> createState() => _InputNewTransactionsState();
}

class _InputNewTransactionsState extends State<InputNewTransactions> {
  // const InputNewTransactions({Key key}) : super(key: key);
  final _inputController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _onSubmitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final submitedTitle = _inputController.text;
    final submitedAmount = double.parse(_amountController.text);

    if (submitedTitle.isEmpty || submitedAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransactions(
      submitedTitle,
      submitedAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentWithDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year), //DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 7,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _inputController,
                onSubmitted: (_) => _onSubmitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_) => _onSubmitData(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No Date Chosen!"
                          : 'Date Picked: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  Platform.isIOS
                      ? CupertinoButton(
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: _presentWithDatePicker,
                        )
                      : TextButton(
                          //textColor: Theme.of(context).textTheme.button,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: _presentWithDatePicker,
                        ),
                ],
              ),
              ElevatedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Color.fromARGB(255, 116, 40, 116),
                  ),
                ),
                onPressed: _onSubmitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
