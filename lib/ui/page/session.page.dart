import 'package:flutter/material.dart'
    show BuildContext, ListView, StatelessWidget, Widget;
import 'package:flutter_guiritter/ui/widget/_import.dart' show BodyWidget;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/ui/widget/_import.dart'
    show AppBarSessionWidget, SessionWidget;

final _log = logger('SessionPage');

class SessionPage extends StatelessWidget {
  const SessionPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    _log('build').print();

    return StoreConnector<Map<String, dynamic>, List<SessionModel>>(
      distinct: true,
      converter: SessionModel.select,
      builder: connectorBuilder,
    );
  }

  Widget connectorBuilder(
    BuildContext context,
    List<SessionModel> sessionList,
  ) {
    _log('connectorBuilder').mapList('sessionList', sessionList).print();

    final sessionCount = sessionList.length;
    final sessionSelectedCount = SessionModel.getSelectedCount(
      sessionList: sessionList,
    );

    final isAnySessionSelected = SessionModel.isAnySessionSelected(
      sessionList: sessionList,
    );

    buildSessionWidget(
      SessionModel session,
    ) =>
        SessionWidget(
          session: session,
          sessionCount: sessionCount,
          sessionSelectedCount: sessionSelectedCount,
        );

    final List<Widget> itemList = sessionList
        .map(
          buildSessionWidget,
        )
        .toList();

    final sessionCommandWidget = SessionWidget(
      session: null,
      sessionCount: sessionCount,
      sessionSelectedCount: sessionSelectedCount,
    );

    itemList.add(
      sessionCommandWidget,
    );

    itemBuilder(
      context,
      index,
    ) =>
        itemList[index];

    return BodyWidget(
      usePadding: false,
      appBar: AppBarSessionWidget(
        isAnySessionSelected: isAnySessionSelected,
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
