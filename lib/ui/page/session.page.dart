import 'package:flutter/material.dart'
    show BuildContext, ListView, StatelessWidget, Widget;
import 'package:flutter_guiritter/ui/widget/_import.dart'
    show AppBarSignedOutWidget, BodyWidget;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:poker_calculator/ui/widget/_import.dart'
    show SessionWidget, getTextL;

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

    return BodyWidget(
      usePadding: false,
      appBar: AppBarSignedOutWidget(
        title: getTextL((l) => l!.title),
      ),
      body: StoreConnector<Map<String, dynamic>, List<SessionModel>>(
        distinct: true,
        converter: SessionModel.select,
        builder: connectorBuilder,
      ),
    );
  }

  Widget connectorBuilder(
    BuildContext context,
    List<SessionModel> sessionList,
  ) {
    _log('connectorBuilder').mapList('sessionList', sessionList).print();

    return ListView.builder(
      itemCount: sessionList.length + 1,
      itemBuilder: (
        context,
        index,
      ) =>
          SessionWidget(
        session: (index < sessionList.length) ? sessionList[index] : null,
      ),
    );
  }
}
