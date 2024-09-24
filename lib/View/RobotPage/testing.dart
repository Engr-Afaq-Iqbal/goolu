// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:goolu/Controller/RobotController/robot_controller.dart';
//
// import '../../Model/generate_answers_model.dart';
// import '../../Utils/font_styles.dart';
//
// class QuestionAnswerWidget extends StatefulWidget {
//   final int index;
//   const QuestionAnswerWidget({Key? key, required this.index}) : super(key: key);
//
//   @override
//   _QuestionAnswerWidgetState createState() => _QuestionAnswerWidgetState();
// }
//
// class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
//   final TextEditingController answerCtrl = TextEditingController();
//   int selectedAnswerIndex = -1;
//   String question = 'What are you doing?';
//   List<String> answers = [];
//   bool showTextField = false;
//   final List<Map<String, String>> savedQnA = [];
//   GenerateAnswersModel? generateAnswersModel;
//   RobotController robotCtrl = Get.find<RobotController>();
//   @override
//   void initState() {
//     super.initState();
//     fetchAnswers();
//   }
//
//   Future<void> fetchAnswers() async {
//     bool success = await robotCtrl.generateAnswersFunction();
//     if (success && generateAnswersModel != null) {
//       setState(() {
//         answers = [
//           generateAnswersModel!.option1 ?? '',
//           generateAnswersModel!.option2 ?? '',
//           generateAnswersModel!.option3 ?? '',
//           generateAnswersModel!.option4 ?? '',
//           generateAnswersModel!.option5 ?? '',
//         ];
//         question = 'Your question here'; // Replace with your actual question
//       });
//     }
//   }
//
//   void saveQuestionAnswer() {
//     if (selectedAnswerIndex >= 0 &&
//         selectedAnswerIndex < answers.length &&
//         answers[selectedAnswerIndex] == answerCtrl.text) {
//       savedQnA
//           .add({'question': question, 'answer': answers[selectedAnswerIndex]});
//       setState(() {
//         selectedAnswerIndex = -1;
//         showTextField = false;
//         answerCtrl.clear();
//       });
//     } else {
//       // Handle the case where the answer doesn't match
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(question, style: regular14NavyBlue),
//         ...List.generate(answers.length, (index) {
//           if (answers[index].isEmpty) return SizedBox.shrink();
//           return Row(
//             children: [
//               Radio<int>(
//                 value: index,
//                 groupValue: selectedAnswerIndex,
//                 onChanged: (int? value) {
//                   setState(() {
//                     selectedAnswerIndex = value!;
//                     showTextField = true;
//                   });
//                 },
//               ),
//               Text(answers[index], style: regular14NavyBlue),
//             ],
//           );
//         }),
//         if (showTextField)
//           TextField(
//             controller: answerCtrl,
//             decoration: InputDecoration(hintText: 'Enter your answer'),
//           ),
//         if (showTextField)
//           ElevatedButton(
//             onPressed: saveQuestionAnswer,
//             child: Text('Submit'),
//           ),
//       ],
//     );
//   }
// }
