import 'package:flutter_guiritter/util/_import.dart' show buildUUID;
import 'package:poker_calculator/model/_import.dart'
    show SessionModel, StateModelWrapper;
import 'package:poker_calculator/redux/session/action.dart'
    show CreateSessionAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final sessionCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    _createSessionTypedReducer,
  ],
);

final _createSessionTypedReducer =
    TypedReducer<Map<String, dynamic>, CreateSessionAction>(
  _createSessionReducer,
).call;

Map<String, dynamic> _createSessionReducer(
  Map<String, dynamic> stateModelMap,
  CreateSessionAction action,
) {
  final state = StateModelWrapper(
    storeStateMap: stateModelMap,
  );

  final newSessionList = [
    ...state.sessionList,
    SessionModel(
      id: buildUUID(),
      name: action.name,
      createdAt: DateTime.now(),
    ),
  ];

  return state.copyWith(
    sessionList: () => newSessionList,
  );
}
