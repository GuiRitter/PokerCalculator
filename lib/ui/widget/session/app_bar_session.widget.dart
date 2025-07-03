import 'dart:math' show Random;

import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Column,
        Icon,
        IconButton,
        Icons,
        MainAxisSize,
        PreferredSizeWidget,
        Size,
        StatelessWidget,
        TextEditingController,
        TextField,
        Widget,
        kToolbarHeight,
        showDialog;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/ui/widget/_import.dart'
    show AppBarSignedOutWidget, buildTextButton;
import 'package:flutter_guiritter/util/_import.dart'
    show logger, onDialogCancelPressed;
import 'package:poker_calculator/common/_import.dart' show AppLocalizations;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:poker_calculator/ui/widget/_import.dart'
    show getTextG, getTextL;

final controller = TextEditingController();

final rng = Random();

final _log = logger('AppBarSessionWidget');

class AppBarSessionWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isAnySessionSelected;

  const AppBarSessionWidget({
    super.key,
    required this.isAnySessionSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );

  @override
  Widget build(
    BuildContext context,
  ) {
    List<IconButton> actionList = [];

    if (isAnySessionSelected) {
      final iconButton = IconButton(
        icon: const Icon(
          Icons.delete,
        ),
        onPressed: () => promptDeleteSession(
          context: context,
        ),
      );

      actionList.add(
        iconButton,
      );
    }

    return AppBarSignedOutWidget<AppLocalizations>(
      title: getTextL((l) => l!.title),
      actionList: actionList,
    );
  }

  onDialogOkPressed({
    required BuildContext context,
    required String challenge,
  }) async {
    _log('onDialogOkPressed')
        .raw('challenge', challenge)
        .raw('input', controller.text)
        .print();

    if (controller.text != challenge) {
      return;
    }

    dispatch(
      session_action.deleteSelectedSessions(),
    );

    onDialogCancelPressed(
      context: context,
    );
  }

  void promptDeleteSession({
    required BuildContext context,
  }) {
    _log('onDialogOkPressed').print();

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

        final challenge = String.fromCharCodes(
          List.generate(
            3,
            (
              _,
            ) =>
                rng.nextInt(
                  26,
                ) +
                97, // Generates a-z
          ),
        );

        final okButton = buildTextButton(
          label: getTextG((l) => l!.ok),
          onPressed: () => onDialogOkPressed(
            context: context,
            challenge: challenge,
          ),
          align: false,
        );

        return AlertDialog(
          title: getTextL((l) => l!.confirmDeleteSession),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getTextL(
                (
                  l,
                ) =>
                    l!.deleteSessionChallenge(
                  challenge,
                ),
              ),
              TextField(
                controller: controller,
                autofocus: true,
                onSubmitted: (_) => onDialogOkPressed(
                  context: context,
                  challenge: challenge,
                ),
              ),
            ],
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
