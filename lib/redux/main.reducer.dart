import 'package:flutter_guiritter/redux/l10n/reducer.dart'
    show buildL10nCombinedReducer;
import 'package:flutter_guiritter/redux/loading/reducer.dart'
    show loadingCombinedReducer;
import 'package:flutter_guiritter/redux/theme/reducer.dart'
    show themeCombinedReducer;
import 'package:flutter_guiritter/redux/user/reducer.dart'
    show userCombinedReducer;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:poker_calculator/common/_import.dart' show AppLocalizations;
import 'package:poker_calculator/redux/navigation/reducer.dart'
    show navigationCombinedReducer;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final noActionTypedReducer = TypedReducer<Map<String, dynamic>, NoAction>(
  noActionReducer,
).call;

final _log = logger('main.reducer');

Map<String, dynamic> noActionReducer(
  Map<String, dynamic> stateModelMap,
  NoAction action,
) =>
    stateModelMap;

Map<String, dynamic> reducer(
  Map<String, dynamic> stateModelMap,
  dynamic action,
) {
  _log('reducer').asString('action', action.runtimeType).print();

  final reducerCombined = combineReducers<Map<String, dynamic>>(
    [
      buildL10nCombinedReducer<AppLocalizations>(),
      loadingCombinedReducer,
      navigationCombinedReducer,
      noActionTypedReducer,
      themeCombinedReducer,
      userCombinedReducer,
    ],
  );

  return reducerCombined(
    stateModelMap,
    action,
  );
}

class NoAction {}
