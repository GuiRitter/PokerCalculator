import 'package:flutter_guiritter/extension/_import.dart'
    show DateTimeNullableExtension;
import 'package:flutter_guiritter/model/_import.dart' show LoggableModel;
import 'package:poker_calculator/model/_import.dart' show StateModelWrapper;
import 'package:redux/redux.dart' show Store;

class SessionModel implements LoggableModel {
  final String id;
  final String name;
  final DateTime createdAt;

  SessionModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SessionModel) return false;
    return id == other.id;
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'id': id,
        'name': name,
        'createdAt': createdAt.getISO8601(),
      };

  static List<SessionModel> select(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.sessionList;
  }
}
