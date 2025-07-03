import 'package:flutter_guiritter/util/_import.dart' show buildUUID;
import 'package:poker_calculator/model/_import.dart'
    show SessionModel, StateModelWrapper;
import 'package:poker_calculator/redux/session/action.dart'
    show
        CreateSessionAction,
        DeleteSessionAction,
        ToggleEverySessionSelectionAction,
        ToggleSessionSelectionAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final sessionCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    _createSessionTypedReducer,
    _deleteSessionTypedReducer,
    _toggleEverySessionSelectionTypedReducer,
    _toggleSessionSelectionTypedReducer,
  ],
);

final _createSessionTypedReducer =
    TypedReducer<Map<String, dynamic>, CreateSessionAction>(
  _createSessionReducer,
).call;

final _deleteSessionTypedReducer =
    TypedReducer<Map<String, dynamic>, DeleteSessionAction>(
  _deleteSessionReducer,
).call;

final _toggleEverySessionSelectionTypedReducer =
    TypedReducer<Map<String, dynamic>, ToggleEverySessionSelectionAction>(
  _toggleEverySessionSelectionReducer,
).call;

final _toggleSessionSelectionTypedReducer =
    TypedReducer<Map<String, dynamic>, ToggleSessionSelectionAction>(
  _toggleSessionSelectionReducer,
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

Map<String, dynamic> _deleteSessionReducer(
  Map<String, dynamic> stateModelMap,
  DeleteSessionAction action,
) {
  final state = StateModelWrapper(
    storeStateMap: stateModelMap,
  );

  final newSessionList = state.sessionList
      .where(
        SessionModel.isSessionNotSelected,
      )
      .toList();

  return state.copyWith(
    sessionList: () => newSessionList,
  );
}

Map<String, dynamic> _toggleEverySessionSelectionReducer(
  Map<String, dynamic> stateModelMap,
  ToggleEverySessionSelectionAction action,
) {
  final state = StateModelWrapper(
    storeStateMap: stateModelMap,
  );

  final isEverySessionSelected = SessionModel.isEverySessionSelected(
    sessionList: state.sessionList,
  );

  final newIsSelected = action.isSelected ?? (!isEverySessionSelected);

  SessionModel toggleSelected(
    SessionModel session,
  ) =>
      session.withIsSelected(
        isSelected: newIsSelected,
      );

  final newSessionList = state.sessionList
      .map(
        toggleSelected,
      )
      .toList();

  return state.copyWith(
    sessionList: () => newSessionList,
  );
}

Map<String, dynamic> _toggleSessionSelectionReducer(
  Map<String, dynamic> stateModelMap,
  ToggleSessionSelectionAction action,
) {
  final state = StateModelWrapper(
    storeStateMap: stateModelMap,
  );

  SessionModel toggleSelectedOnGivenSession(
    SessionModel session,
  ) =>
      session.toggleSelectedOnMatch(
        action: action,
      );

  final newSessionList = state.sessionList
      .map(
        toggleSelectedOnGivenSession,
      )
      .toList();

  return state.copyWith(
    sessionList: () => newSessionList,
  );
}
