import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/ui/widget/_import.dart'
    show EverySessionWidget, ExistingSessionWidget, NewSessionWidget;

class SessionWidget extends StatelessWidget {
  final SessionModel? session;
  final int sessionCount;
  final int sessionSelectedCount;

  const SessionWidget({
    super.key,
    required this.session,
    required this.sessionCount,
    required this.sessionSelectedCount,
  });

  bool get isAnySessionSelected => sessionSelectedCount > 0;

  bool get isEverySessionSelected =>
      isAnySessionSelected && (sessionSelectedCount == sessionCount);

  @override
  Widget build(
    BuildContext context,
  ) {
    if (session == null) {
      return isAnySessionSelected
          ? EverySessionWidget(
              session: null,
              sessionCount: sessionCount,
              sessionSelectedCount: sessionSelectedCount,
            )
          : NewSessionWidget(
              session: null,
              sessionCount: sessionCount,
              sessionSelectedCount: sessionSelectedCount,
            );
    } else {
      return ExistingSessionWidget(
        session: session,
        sessionCount: sessionCount,
        sessionSelectedCount: sessionSelectedCount,
      );
    }
  }
}
