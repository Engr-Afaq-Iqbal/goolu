import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Services/storage_sevices.dart';
import 'package:goolu/View/Drawer/transaction_list_details.dart';

import '../../Components/app_time_stamp_converter.dart';
import '../../Config/app_config.dart';
import '../../Model/TransactionModel/stripe_payment_record_model.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';
import '../../Utils/utils.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({
    super.key,
  });

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<StripePaymentRecord>> fetchUserTransactions(String userId) async {
    try {
      // Reference to the user's transactions
      final transactionsRef = FirebaseFirestore.instance
          .collection('UserStripeRecord')
          .doc(userId)
          .collection('Records');

      // Fetch all documents
      final snapshot = await transactionsRef.get();

      // Parse Firestore documents into StripePaymentRecord objects
      final transactions = snapshot.docs
          .map((doc) => StripePaymentRecord.fromJson(doc.data()))
          .toList();

      return transactions;
    } catch (e) {
      logger.e("Error fetching user transactions: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StripePaymentRecord>>(
      future: fetchUserTransactions(AppStorage.getUserData()?.userId ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No transactions found.'));
        }

        final transactions = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.all(SizesDimensions.height(2)),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final singleTransaction = transactions[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => TransactionListDetails(
                      singleTransaction: singleTransaction,
                    ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizesDimensions.height(1.5),
                    horizontal: SizesDimensions.width(2)),
                margin:
                    EdgeInsets.symmetric(vertical: SizesDimensions.width(1)),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon Container
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizesDimensions.width(2.5),
                          vertical: SizesDimensions.height(1.5)),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: singleTransaction.status == 'Succeeded'
                          ? SvgPicture.asset('$imgUrl$outGoingArrowImg')
                          : SvgPicture.asset('$imgUrl$outGoingArrowImg'),
                    ),
                    size20w,
                    // Transaction Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizesDimensions.width(67),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: customText(
                                  text: '${singleTransaction.status}',
                                  textStyle: bold18NavyBlue.copyWith(
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              customText(
                                text:
                                    '- ${singleTransaction.amount} ${singleTransaction.currency}',
                                textStyle: bold16NavyBlue.copyWith(
                                  color: kRedFF624D,
                                ),
                              )
                            ],
                          ),
                        ),
                        TimestampConverter(
                          timestamp:
                              int.parse(singleTransaction.created ?? '000'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
