import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter_guiritter/common/_import.dart' show Settings;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/redux/user/action.dart' as user_action;
import 'package:flutter_guiritter/ui/page/_import.dart' show LoadingPage;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:poker_calculator/model/_import.dart' show TabsModel;
import 'package:poker_calculator/ui/page/_import.dart'
    show CalculatorPage, SessionPage;
import 'package:poker_calculator/ui/widget/_import.dart' show getTextL;

final _log = logger('TabsPage');

class TabsPage extends StatelessWidget {
  const TabsPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    dispatch(
      user_action.validateAndSetToken(
        newToken: Settings.revalidateToken,
      ),
    );

    return StoreConnector<Map<String, dynamic>, TabsModel>(
      distinct: true,
      converter: TabsModel.select,
      builder: connectorBuilder,
    );
  }

  Widget connectorBuilder(
    BuildContext context,
    TabsModel tabsModel,
  ) {
    _log('connectorBuilder').map('tabsModel', tabsModel).print();

    return tabsModel.isLoading
        ? LoadingPage(
            title: getTextL((l) => l!.title),
          )
        : tabsModel.isSessionSelected
            ? CalculatorPage()
            : SessionPage();
  }
}
