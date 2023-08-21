import 'package:flutter/material.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_panel_page.dart';

class PersonalPanelPage extends StatelessWidget {
  const PersonalPanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).size.height * 0.11,
        0,
        0,
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const SingleChildScrollView(
            child: PromocodePanelPage(),
          ),
        ),
      ),
    );
  }
}
