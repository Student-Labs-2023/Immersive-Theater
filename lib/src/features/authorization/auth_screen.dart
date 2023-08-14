// import 'package:flutter/material.dart';
// import 'package:shebalin/src/features/authorization/widgets/sms_code_input_page.dart';
// import 'package:shebalin/src/theme/app_color.dart';
// import 'package:shebalin/src/theme/images.dart';

// class AuthScreen extends StatefulWidget {
//   AuthScreen({super.key});
//   static const String routeName = "/auth-screen";
//   final TextEditingController controller = TextEditingController(
//     text: "+7",
//   );
//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   bool isActive = false;
//   bool isValid = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.whiteBackground,
//       body: Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16, top: 96),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Номер телефона",
//               style: Theme.of(context)
//                   .textTheme
//                   .displaySmall!
//                   .copyWith(fontWeight: FontWeight.w700),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 4, bottom: 20),
//               child: Text(
//                 "Он нужен, чтобы сохранять ваши спектакли",
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium!
//                     .copyWith(color: AppColor.greyText),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: isActive
//                       ? (isValid ? AppColor.purplePrimary : Colors.red)
//                       : AppColor.grey,
//                 ),
//                 color: isValid
//                     ? AppColor.accentBackground
//                     : AppColor.alertTextFieldBg,
//               ),
//               constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 0.06),
//               child: TextField(
//                 controller: widget.controller,
//                 keyboardType: TextInputType.number,
//                 enabled: true, //TODO: implement login bloc
//                 onChanged: (text) {
//                   //TODO: call Bloc.add function
//                 },
//                 onTap: () {
//                   setState(() {
//                     isActive = true;
//                   });
//                 },
//                 textAlignVertical: TextAlignVertical.center,
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 maxLines: 1,
//                 decoration: InputDecoration(
//                   isCollapsed: true,
//                   floatingLabelAlignment: FloatingLabelAlignment.center,
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                   floatingLabelBehavior: FloatingLabelBehavior.never,
//                   alignLabelWithHint: true,
//                   filled: true,
//                   fillColor: Colors.transparent,
//                   label: Text(
//                     "+7",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                     textHeightBehavior: const TextHeightBehavior(
//                       leadingDistribution: TextLeadingDistribution.proportional,
//                     ),
//                   ),
//                   suffixIcon: isActive
//                       ? InkWell(
//                           onTap: () {
//                             setState(() {
//                               widget.controller.clear();
//                             });
//                           },
//                           child: Image.asset(
//                             ImagesSources.cross,
//                             height: 24,
//                           ),
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//             isValid
//                 ? const SizedBox(
//                     height: 31,
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.only(top: 5, bottom: 14),
//                     child: Text(
//                       "Номер введён неполностью",
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: AppColor.redAlert,
//                           ),
//                     ),
//                   ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (widget.controller.text.length < 12) {
//                   setState(() {
//                     isValid = false;
//                   });
//                 } else if (widget.controller.text.length == 12 ||
//                     widget.controller.text.length == 2) {
//                   setState(() {
//                     isValid = true;
//                   });
//                   Navigator.of(context).pushNamed(
//                     SMSCodeInputPage.routeName,
//                     arguments: "+79509999999",
//                   );
//                 }
//               },
//               style: ButtonStyle(
//                 elevation: const MaterialStatePropertyAll(0),
//                 backgroundColor:
//                     MaterialStateProperty.all(AppColor.purplePrimary),
//                 shape: MaterialStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 minimumSize: MaterialStateProperty.all(
//                   Size(
//                     MediaQuery.of(context).size.width,
//                     MediaQuery.of(context).size.height * 0.06,
//                   ),
//                 ),
//               ),
//               child: Text(
//                 'Далее',
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyLarge
//                     ?.copyWith(color: AppColor.whiteText),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
