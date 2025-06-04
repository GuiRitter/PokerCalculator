import 'package:flutter/material.dart'
    show BuildContext, ListTile, Localizations, StatelessWidget, Text, Widget;
import 'package:flutter_guiritter/extension/date_time.dart'
    show DateTimeExtension;
import 'package:poker_calculator/model/_import.dart' show SessionModel;

class SessionWidget extends StatelessWidget {
  final SessionModel session;

  const SessionWidget({
    super.key,
    required this.session,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final locale = Localizations.localeOf(
      context,
    ).toString();

    return ListTile(
      title: Text(
        session.name,
      ),
      subtitle: Text(
        session.createdAt.toHumanReadableString(
          locale: locale,
        ),
      ),
    );
  }
}
