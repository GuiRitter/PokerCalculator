import 'package:flutter_guiritter/extension/_import.dart'
    show DateTimeNullableExtension, DynamicListExtension;
import 'package:flutter_guiritter/model/_import.dart' show Encodable, Loggable;
import 'package:poker_calculator/model/_import.dart' show StateModelWrapper;
import 'package:poker_calculator/redux/session/action.dart' as session_action;
import 'package:redux/redux.dart' show Store;

class SessionModel implements Loggable, Encodable {
  final String id;
  final String name;
  final DateTime createdAt;
  final bool isSelected;

  SessionModel({
    required this.id,
    required this.name,
    required this.createdAt,
    this.isSelected = false,
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
        'isSelected': isSelected,
      };

  SessionModel toggleSelectedOnMatch({
    required session_action.ToggleSessionSelectionAction action,
  }) =>
      (id == action.id)
          ? withIsSelected(
              isSelected: action.isSelected,
            )
          : this;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt.getISO8601(),
        'isSelected': isSelected,
      };

  SessionModel withIsSelected({
    required bool isSelected,
  }) =>
      SessionModel(
        id: id,
        name: name,
        createdAt: createdAt,
        isSelected: isSelected,
      );

  static SessionModel fromJson(
    dynamic json,
  ) =>
      SessionModel(
        id: json['id'],
        name: json['name'],
        createdAt: DateTime.parse(
          json['createdAt'],
        ),
      );

  static bool isAnySessionSelected({
    required List<SessionModel> sessionList,
  }) =>
      sessionList.any(
        SessionModel.isSessionSelected,
      );

  static bool isSessionNotSelected(
    SessionModel session,
  ) =>
      !session.isSelected;

  static bool isSessionSelected(
    SessionModel session,
  ) =>
      session.isSelected;

  static List<SessionModel> ofDynamicList({
    required dynamic list,
  }) =>
      DynamicListExtension(list).ofDynamic(
        mapper: SessionModel.fromJson,
      );

  static List<SessionModel> select(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.sessionList;
  }
}
