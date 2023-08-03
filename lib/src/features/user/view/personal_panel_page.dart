import 'package:flutter/material.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_screen.dart';

import 'package:shebalin/src/features/user/view/widgets/ticket.dart';

import '../../../theme/theme.dart';

class PersonalPanelPage extends StatelessWidget {
  PersonalPanelPage({Key? key}) : super(key: key);

  final _searchTextController = TextEditingController();
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
          child: SingleChildScrollView(
            child: PromocodeScreen(),
          ),
        ),
      ),
    );
  }
}
