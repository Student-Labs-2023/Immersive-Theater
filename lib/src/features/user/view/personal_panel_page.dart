import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.85,
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: searchBarRadius,
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Icon(
                        Icons.search_outlined,
                        color: secondaryTextColor,
                        size: 24,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(left: 12)),
                  Expanded(
                    child: TextField(
                      enableSuggestions: false,
                      maxLength: 22,
                      autocorrect: false,
                      controller: _searchTextController,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: primaryTextColor,
                            fontSize: 20,
                          ),
                      decoration: InputDecoration(
                        counterText: '',
                        labelStyle:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: primaryTextColor,
                                  fontSize: 20,
                                ),
                        border: InputBorder.none,
                        hintText: 'Поиск',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: bodySmallFontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 12, 24, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Мои покупки',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: titleMediumFontSize),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Все',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
            const Ticket(),
            const Ticket(),
            const Ticket(),
            const Ticket()
          ],
        ),
      ),
    );
  }
}
