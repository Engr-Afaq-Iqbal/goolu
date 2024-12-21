import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/app_box_design.dart';
import '../../Components/app_time_stamp_converter.dart';
import '../../Components/title_space_text.dart';
import '../../Config/app_config.dart';
import '../../Model/TransactionModel/stripe_payment_record_model.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/utils.dart';

class TransactionListDetails extends StatelessWidget {
  final StripePaymentRecord? singleTransaction;

  const TransactionListDetails({super.key, this.singleTransaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions Detail',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Darker shade of grey for the AppBar
        centerTitle: true,
      ),
      backgroundColor: kF3F3F3,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Transaction Details Box
              AppBoxDesign(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width,
                    ),
                    Text(
                      singleTransaction?.status?.capitalize ?? '- -',
                      style: bold18NavyBlue.copyWith(
                        color: kGreen1ED760,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${singleTransaction?.amount ?? '- -'} ${singleTransaction?.currency ?? ''}',
                      style: regular16NavyBlue.copyWith(
                        color: Theme.of(context).iconTheme.color,
                      ),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              // Status and Additional Details
              AppBoxDesign(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transaction Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction Status:',
                          style: bold16NavyBlue.copyWith(
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kGreen1ED760,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                          ),
                          child: Text(
                            singleTransaction?.status?.capitalize ?? '- -',
                            style: bold14White,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppStyles.dividerLine(),
                    const SizedBox(height: 20),
                    // Timestamps
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'Date:',
                          textStyle: regular14NavyBlue.copyWith(
                            color: Theme.of(context).iconTheme.color,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                        TimestampConverter(
                          timestamp:
                              int.parse(singleTransaction?.created ?? '000'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    // Amount
                    TitleSpaceTxt(
                      title: '${'Amount'}:',
                      txt:
                          '${singleTransaction?.amount ?? '- -'} ${singleTransaction?.currency ?? ''}',
                    ),
                    const SizedBox(height: 10),
                    // Transaction ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'Transaction Id'}:',
                          style: regular14NavyBlue.copyWith(
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            copyToClipboard('${singleTransaction?.id}');
                          },
                          child: Icon(
                            Icons.copy_rounded,
                            color: secDarkBlueNavyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${singleTransaction?.id}',
                      style: bold14NavyBlue.copyWith(
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
