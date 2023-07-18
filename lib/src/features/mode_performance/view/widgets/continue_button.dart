import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

// class ContinueButton extends StatelessWidget {
//   final String title;
//   final void Function() onTap;
//   const ContinueButton({super.key, required this.title, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(backgroundColor),
//         elevation: MaterialStateProperty.all(0),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             side: BorderSide(color: borderColor, width: 2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         minimumSize: MaterialStateProperty.all(
//           Size(
//             MediaQuery.of(context).size.width * 0.85,
//             MediaQuery.of(context).size.height * 0.06,
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(color: textColor),
//           ),
//           const SizedBox(
//             width: 9,
//           ),
//           ImageIcon(
//             AssetImage(icon),
//             color: textColor,
//             size: 24,
//           )
//         ],
//       ),
//     );
//   }
// }

// class ContinueButton extends StatelessWidget {
//   final String title;
//   final void Function() onTap;
//   final String icon;

//   const ContinueButton({
//     super.key,
//     required this.title,
//     required this.onTap,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(AppColor.purplePrimary),
//         elevation: MaterialStateProperty.all(0),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(79),
//           ),
//         ),
//         minimumSize: MaterialStateProperty.all(
//           Size(
//             MediaQuery.of(context).size.width * 0.94,
//             MediaQuery.of(context).size.height * 0.055,
//           ),
//         ),
//       ),
//       child: Expanded(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium
//                   ?.copyWith(color: AppColor.whiteText),
//             ),
//             const SizedBox(
//               width: 13,
//             ),
//             ImageIcon(
//               AssetImage(icon),
//               color: AppColor.whiteText,
//               size: 24,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class ContinueButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const ContinueButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            minHeight: 50,
            minWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(79.0),
            color: AppColor.purplePrimary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColor.whiteText),
              ),
              const SizedBox(
                width: 13,
              ),
              const ImageIcon(
                AssetImage(ImagesSources.right),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
