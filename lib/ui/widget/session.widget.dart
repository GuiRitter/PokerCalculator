import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        CheckboxListTile,
        Color,
        Icon,
        Icons,
        ListTile,
        Localizations,
        StatelessWidget,
        Text,
        TextEditingController,
        Widget,
        showDialog;
import 'package:flutter_guiritter/extension/_import.dart'
    show DateTimeExtension;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:poker_calculator/ui/widget/_import.dart'
    show SessionDialog, getTextL;

final controller = TextEditingController();

final _log = logger('SessionWidget');

class SessionWidget extends StatelessWidget {
  final SessionModel? session;
  final bool isAnySessionSelected;

  const SessionWidget({
    super.key,
    required this.session,
    required this.isAnySessionSelected,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final locale = Localizations.localeOf(
      context,
    ).toString();

    if (isAnySessionSelected) {
      final checkboardListTile = CheckboxListTile(
        title: Text(
          session!.name,
        ),
        subtitle: Text(
          session!.createdAt.toHumanReadableString(
            locale: locale,
          ),
        ),
        value: session!.isSelected,
        onChanged: onSessionCheckBoxChanged,
      );

      if (session!.isSelected) {
        return buildFilledCard(
          child: checkboardListTile,
        );
      }

      return buildOutlinedCard(
        child: checkboardListTile,
      );
    } else {
      if (session == null) {
        return buildOutlinedCard(
          child: ListTile(
            leading: Icon(
              Icons.add,
            ),
            title: getTextL((l) => l!.newSession),
            onTap: () => promptNewSession(
              context: context,
            ),
          ),
        );
      } else {
        return buildOutlinedCard(
          child: ListTile(
            title: Text(
              session!.name,
            ),
            subtitle: Text(
              session!.createdAt.toHumanReadableString(
                locale: locale,
              ),
            ),
            onLongPress: selectSession,
          ),
        );
      }
    }
  }

  Widget buildFilledCard({
    required Widget child,
  }) {
    return Card.filled(
      elevation: 0,
      child: child,
    );
  }

  // TODO should build an outlined card but I think this only works in Material 3
  Widget buildOutlinedCard({
    required Widget child,
  }) {
    return Card.outlined(
      color: const Color(
        0x00000000,
      ),
      elevation: 0,
      child: child,
    );
  }

  Widget newSessionDialogBuilder(
    context,
  ) =>
      SessionDialog();

  void onSessionCheckBoxChanged(
    bool? hasChanged,
  ) {
    _log("onSessionCheckBoxChanged")
        .raw('session', session?.id)
        .raw('hasChanged', hasChanged)
        .print();

    if (hasChanged == null) {
      return;
    }

    toggleSessionSelection(
      isSelected: hasChanged,
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

  void selectSession() => toggleSessionSelection(
        isSelected: true,
      );

  void toggleSessionSelection({
    required bool isSelected,
  }) {
    _log("selectSession")
        .raw('session', session?.id)
        .raw('isSelected', isSelected)
        .print();

    if (session == null) return;

    dispatch(
      session_action.toggleSessionSelection(
        id: session!.id,
        isSelected: isSelected,
      ),
    );
  }
}
