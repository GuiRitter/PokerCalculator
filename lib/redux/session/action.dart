import 'package:flutter_guiritter/util/_import.dart' show logger;
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

class CreateSessionAction {
  final String name;

  const CreateSessionAction({
    required this.name,
  });
}
