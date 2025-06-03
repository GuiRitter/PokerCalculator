import 'package:poker_calculator/model/_import.dart' show StateModelWrapper;
import 'package:poker_calculator/redux/navigation/action.dart'
    show NavigationAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final goTypedReducer = TypedReducer<Map<String, dynamic>, NavigationAction>(
  goReducer,
).call;

final navigationCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    goTypedReducer,
  ],
);

Map<String, dynamic> goReducer(
  Map<String, dynamic> stateModelMap,
  NavigationAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).copyWith(
      state: () => action.state,
    );
