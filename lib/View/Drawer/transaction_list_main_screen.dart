import 'package:flutter/material.dart';
import 'package:goolu/View/Drawer/transaction_list.dart';

import '../../Theme/colors.dart';

class TransactionMainScreen extends StatelessWidget {
  const TransactionMainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Darker shade of grey for the AppBar
        centerTitle: true,
      ),
      backgroundColor: kF3F3F3, // Light grey background
      body: const TransactionListScreen(), // Call the transaction list
    );
  }
}
