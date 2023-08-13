import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final TextEditingController controller = TextEditingController(
    text: "+7",
  );
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isActive ? AppColor.purplePrimary : AppColor.grey,),
        color: AppColor.accentBackground,
      ),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.06),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        enabled:true, //TODO: implement login bloc
        onChanged: (text) {
          //TODO: call Bloc.add function
        },
        onTap: (){
          setState(() {
            isActive = true;
          });
        },
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyLarge,
        maxLines: 1,
        decoration: InputDecoration(
          isCollapsed: true,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.transparent,
          label: Text(
            "+7",
            style: Theme.of(context).textTheme.bodyLarge,
            textHeightBehavior: const TextHeightBehavior(
              leadingDistribution: TextLeadingDistribution.proportional,
            ),
          ),
          suffixIcon: isActive? InkWell(
            onTap: () {
              controller.clear();
            },
            child: Image.asset(
              ImagesSources.cross,
              height: 24,
            ),
          ) : null,
        ),
      ),
    );
  }
}
