import 'package:flutter/material.dart'
    show
        BuildContext,
        Localizations,
        StatelessWidget,
        Text,
        TextEditingController,
        Widget;
import 'package:flutter_guiritter/common/_import.dart' show CardVariant;
import 'package:flutter_guiritter/extension/_import.dart'
    show DateTimeExtension;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:poker_calculator/ui/widget/_import.dart' show BaseSessionWidget;

final controller = TextEditingController();

final _log = logger('ExistingSessionWidget');

class ExistingSessionWidget extends StatelessWidget {
  final SessionModel? session;
  final int sessionCount;
  final int sessionSelectedCount;

  const ExistingSessionWidget({
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
    final locale = Localizations.localeOf(
      context,
    ).toString();

    final cardVariant = isAnySessionSelected
        ? (session!.isSelected ? CardVariant.filled : CardVariant.outlined)
        : CardVariant.outlined;

    final onCheckChanged =
        isAnySessionSelected ? onSessionCheckBoxChanged : null;

    final onLongPress = isAnySessionSelected ? null : selectSession;

    return BaseSessionWidget(
      cardVariant: cardVariant,
      title: Text(
        session!.name,
      ),
      subtitle: Text(
        session!.createdAt.toHumanReadableString(
          locale: locale,
        ),
      ),
      isSelected: session!.isSelected,
      onCheckChanged: onCheckChanged,
      onLongPress: onLongPress,
      tristate: false,
    );
  }

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

  void selectSession() => toggleSessionSelection(
        isSelected: true,
      );

  void toggleSessionSelection({
    required bool isSelected,
  }) {
    _log("toggleSessionSelection")
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
