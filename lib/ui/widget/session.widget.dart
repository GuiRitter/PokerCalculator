import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Icon,
        Icons,
        ListTile,
        Localizations,
        StatelessWidget,
        Text,
        TextEditingController,
        TextField,
        Widget,
        showDialog;
import 'package:flutter_guiritter/extension/_import.dart'
    show DateTimeExtension;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/ui/widget/_import.dart' show buildTextButton;
import 'package:flutter_guiritter/util/_import.dart'
    show logger, onDialogCancelPressed;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:poker_calculator/ui/widget/text_l10n.widget.dart'
    show getTextG, getTextL;

final controller = TextEditingController();

final _log = logger('SessionWidget');

class SessionWidget extends StatelessWidget {
  final SessionModel? session;

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

    if (session == null) {
      return ListTile(
        leading: Icon(
          Icons.add,
        ),
        title: getTextL((l) => l!.newSession),
        onTap: () => promptNewSession(
          context: context,
        ),
      );
    }

    return ListTile(
      title: Text(
        session!.name,
      ),
      subtitle: Text(
        session!.createdAt.toHumanReadableString(
          locale: locale,
        ),
      ),
    );
  }

  onDialogOkPressed({
    required BuildContext context,
  }) async {
    _log("onDialogOkPressed").print();

    dispatch(
      session_action.createSession(
        name: controller.text,
      ),
    );

    onDialogCancelPressed(
      context: context,
    );
  }

  void promptNewSession({
    required BuildContext context,
  }) {
    _log("promptNewSession").print();

    showDialog(
      context: context,
      builder: (
        context,
      ) {
        controller.text = '';

        final cancelButton = buildTextButton(
          label: getTextG((l) => l!.cancel),
          onPressed: () => onDialogCancelPressed(
            context: context,
          ),
          align: false,
        );

        final okButton = buildTextButton(
          label: getTextG((l) => l!.ok),
          onPressed: () => onDialogOkPressed(
            context: context,
          ),
          align: false,
        );

        return AlertDialog(
          title: getTextL((l) => l!.newSessionName),
          content: TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: (_) => onDialogOkPressed(
              context: context,
            ),
          ),
          actions: [
            cancelButton,
            okButton,
          ],
        );
      },
    );
  }
}
