import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:poker_calculator/model/_import.dart'
    show SessionModel, StateModelWrapper;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

final _log = logger('session.action');

ThunkAction<Map<String, dynamic>> createSession({
  required String name,
}) =>
    (
      Store<Map<String, dynamic>> store,
    ) async {
      _log('createSession').raw('name', name).print();

      if (name.isEmpty) return;

      store.dispatch(
        CreateSessionAction(
          name: name,
        ),
      );
    };

ThunkAction<Map<String, dynamic>> deleteSelectedSessions() => (
      Store<Map<String, dynamic>> store,
    ) async {
      _log('deleteSelectedSessions').print();

      final state = StateModelWrapper(
        storeStateMap: store.state,
      );

      final isAnySessionSelected = SessionModel.isAnySessionSelected(
        sessionList: state.sessionList,
      );

      if (!isAnySessionSelected) return;

      store.dispatch(
        DeleteSessionAction(),
      );
    };

ThunkAction<Map<String, dynamic>> toggleSessionSelection({
  required String id,
  required bool isSelected,
}) =>
    (
      Store<Map<String, dynamic>> store,
    ) async {
      _log('toggleSessionSelection')
          .raw('id', id)
          .raw('isSelected', isSelected)
          .print();

      if (id.isEmpty) return;

      store.dispatch(
        ToggleSessionSelectionAction(
          id: id,
          isSelected: isSelected,
        ),
      );
    };

class CreateSessionAction {
  final String name;

  const CreateSessionAction({
    required this.name,
  });
}

class DeleteSessionAction {}

class ToggleSessionSelectionAction {
  final String id;
  final bool isSelected;

  const ToggleSessionSelectionAction({
    required this.id,
    required this.isSelected,
  });
}
