import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        Icons,
        StatelessWidget,
        TextEditingController,
        Widget;
import 'package:flutter_guiritter/common/_import.dart' show CardVariant;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:poker_calculator/ui/widget/_import.dart'
    show BaseSessionWidget, getTextL;

final controller = TextEditingController();

final _log = logger('EverySessionWidget');

class EverySessionWidget extends StatelessWidget {
  final SessionModel? session;
  final int sessionCount;
  final int sessionSelectedCount;

  const EverySessionWidget({
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
    final cardVariant =
        isEverySessionSelected ? CardVariant.filled : CardVariant.outlined;

    final isSelected =
        isAnySessionSelected ? (isEverySessionSelected ? true : null) : false;

    return BaseSessionWidget(
      cardVariant: cardVariant,
      leading: Icon(
        Icons.add,
      ),
      title: getTextL((l) => l!.sessionSelectedCount(
          sessionCount, sessionSelectedCount, sessionCount)),
      isSelected: isSelected,
      onCheckChanged: onListCheckBoxChanged,
      tristate: true,
    );
  }

  void onListCheckBoxChanged(
    bool? value,
  ) {
    _log("onListCheckBoxChanged").print();

    dispatch(
      session_action.toggleEverySessionSelection(),
    );
  }
}
