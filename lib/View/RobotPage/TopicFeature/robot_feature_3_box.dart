// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:goolu/Controller/RobotController/robot_controller.dart';
//
// import '../../../Config/app_config.dart';
// import '../../../Controller/MicrophoneController/microphone_controller.dart';
// import '../../../Theme/colors.dart';
// import '../../../Utils/dimensions.dart';
// import '../../../Utils/font_styles.dart';
// import '../../../Utils/image_urls.dart';
//
// class RobotFeature3Box extends StatefulWidget {
//   final int index;
//   const RobotFeature3Box({super.key, required this.index});
//
//   @override
//   State<RobotFeature3Box> createState() => _RobotFeature3BoxState();
// }
//
// class _RobotFeature3BoxState extends State<RobotFeature3Box> {
//   bool showOrHideAnswer = false;
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RobotController>(builder: (RobotController robotCtrl) {
//       return Container(
//         width: MediaQuery.of(context)
//             .size
//             .width, // Using MediaQuery instead of Get
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.2),
//           border: Border.all(color: Colors.grey, width: 1),
//           borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: SizesDimensions.width(75),
//                   child: customText(
//                     text: robotCtrl.questionAnswerModel
//                             ?.getQuestion(widget.index) ??
//                         '',
//                     maxLines: 10,
//                     textStyle: bold18NavyBlue,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     final text = robotCtrl.questionAnswerModel
//                             ?.getQuestion(widget.index) ??
//                         'noTextAvailable'.tr;
//                     await Get.find<MicrophoneController>().speak(text);
//                   },
//                   child: Container(
//                     width: 30.0,
//                     height: 30.0,
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: kYellowffde59,
//                       shape: BoxShape.circle,
//                     ),
//                     child: SvgPicture.asset(
//                       '$imgUrl$playImage',
//                       colorFilter: ColorFilter.mode(
//                         primaryBlueColor,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     if (showOrHideAnswer == false) {
//                       showOrHideAnswer = true;
//                     } else {
//                       showOrHideAnswer = false;
//                     }
//                     setState(() {});
//                   },
//                   child: customText(
//                     text: showOrHideAnswer == true
//                         ? '(hide answer)'
//                         : '(view example answer)',
//                     maxLines: 1,
//                     textStyle: bold18Green,
//                   ),
//                 ),
//               ],
//             ),
//             if (showOrHideAnswer == true) size5h,
//             if (showOrHideAnswer == true)
//               customText(
//                   text:
//                       robotCtrl.questionAnswerModel?.getAnswer(widget.index) ??
//                           '- -',
//                   maxLines: 10,
//                   textStyle: regular14NavyBlue),
//           ],
//         ),
//       );
//     });
//   }
// }
