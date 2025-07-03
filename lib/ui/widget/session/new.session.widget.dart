import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        Icons,
        StatelessWidget,
        TextEditingController,
        Widget,
        showDialog;
import 'package:flutter_guiritter/common/_import.dart' show CardVariant;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:poker_calculator/ui/widget/_import.dart'
    show BaseSessionWidget, SessionDialog, getTextL;

final controller = TextEditingController();

final _log = logger('NewSessionWidget');

class NewSessionWidget extends StatelessWidget {
  final SessionModel? session;
  final int sessionCount;
  final int sessionSelectedCount;

  const NewSessionWidget({
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
  ) =>
      BaseSessionWidget(
        cardVariant: CardVariant.outlined,
        leading: Icon(
          Icons.add,
        ),
        title: getTextL((l) => l!.newSession),
        isSelected: false,
        onTap: () => promptNewSession(
          context: context,
        ),
        onLongPress: onNewSessionLongPressed,
      );

  Widget newSessionDialogBuilder(
    context,
  ) =>
      SessionDialog();

  void onNewSessionLongPressed() {
    _log("onNewSessionLongPressed").print();

    dispatch(
      session_action.toggleEverySessionSelection(
        isSelected: true,
      ),
    );
  }

  void promptNewSession({
    required BuildContext context,
  }) {
    _log("promptNewSession").print();

    showDialog(
      context: context,
      builder: newSessionDialogBuilder,
    );
  }
}
