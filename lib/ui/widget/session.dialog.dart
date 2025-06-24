import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Column,
        FocusNode,
        Icon,
        Icons,
        MainAxisSize,
        SizedBox,
        StatelessWidget,
        SwitchListTile,
        TextEditingController,
        TextField,
        Theme,
        ValueListenableBuilder,
        ValueNotifier,
        Widget,
        WidgetState,
        WidgetStateProperty,
        WidgetStatesConstraint;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/ui/widget/_import.dart' show buildTextButton;
import 'package:flutter_guiritter/util/_import.dart'
    show logger, onDialogCancelPressed;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:poker_calculator/ui/widget/text_l10n.widget.dart'
    show getTextG, getTextL;

final controller = TextEditingController();

final focusNode = FocusNode();

ValueNotifier<bool> isInsertSequentialNotifier = ValueNotifier(
  false,
);

final _log = logger('SessionDialog');

class SessionDialog extends StatelessWidget {
  const SessionDialog({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    controller.text = '';

    isInsertSequentialNotifier.value = false;

    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    return ValueListenableBuilder<bool>(
      valueListenable: isInsertSequentialNotifier,
      builder: (
        context,
        _,
        __,
      ) =>
          AlertDialog(
        title: getTextL((l) => l!.newSessionName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildDialogContent(
            context: context,
            fieldPadding: fieldPadding,
          ),
        ),
        actions: buildDialogActions(
          context: context,
        ),
      ),
    );
  }

  Widget buildCancelButton({
    required BuildContext context,
  }) =>
      buildTextButton(
        label: getTextG((l) => l!.cancel),
        onPressed: () => onDialogCancelPressed(
          context: context,
        ),
        align: false,
      );

  List<Widget> buildDialogActions({
    required BuildContext context,
  }) =>
      [
        buildCancelButton(
          context: context,
        ),
        buildOkButton(
          context: context,
        ),
      ];

  List<Widget> buildDialogContent({
    required BuildContext context,
    required double fieldPadding,
  }) =>
      [
        buildTextField(
          context: context,
        ),
        SizedBox.square(
          dimension: fieldPadding,
        ),
        buildSwitchListTile(),
      ];

  Widget buildOkButton({
    required BuildContext context,
  }) =>
      buildTextButton(
        label: getTextG((l) => l!.ok),
        onPressed: () => onDialogOkPressed(
          context: context,
        ),
        align: false,
      );

  SwitchListTile buildSwitchListTile() {
    return SwitchListTile(
      title: getTextL((l) => l!.another),
      // TODO also seems to only work in Material 3
      thumbIcon: WidgetStateProperty<Icon>.fromMap(
        <WidgetStatesConstraint, Icon>{
          WidgetState.selected: Icon(
            Icons.library_add,
          ),
          WidgetState.any: Icon(
            Icons.add_box,
          ),
        },
      ),
      value: isInsertSequentialNotifier.value,
      onChanged: isInsertSequentialChanged,
    );
  }

  TextField buildTextField({
    required BuildContext context,
  }) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onSubmitted: (
        _,
      ) =>
          onDialogOkPressed(
        context: context,
      ),
    );
  }

  void isInsertSequentialChanged(
    bool isInsertSequential,
  ) =>
      isInsertSequentialNotifier.value = isInsertSequential;

  onDialogOkPressed({
    required BuildContext context,
  }) async {
    _log("onDialogOkPressed").print();

    dispatch(
      session_action.createSession(
        name: controller.text,
      ),
    );

    if (isInsertSequentialNotifier.value) {
      controller.text = '';

      focusNode.requestFocus();
    } else {
      onDialogCancelPressed(
        context: context,
      );
    }
  }
}
