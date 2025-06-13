import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter/material.dart' show ThemeMode, ValueGetter;
import 'package:flutter_guiritter/common/_import.dart'
    show AppLocalizationsGuiRitter;
import 'package:flutter_guiritter/common/_import.dart' as common_gui_ritter;
import 'package:flutter_guiritter/extension/_import.dart'
    show EncodableListExtension;
import 'package:flutter_guiritter/model/_import.dart' as model_gui_ritter;
import 'package:flutter_guiritter/model/_import.dart' show LoadingTagModel;
import 'package:poker_calculator/common/_import.dart'
    show AppLocalizations, StateEnum, StateKey;
import 'package:poker_calculator/model/_import.dart' show SessionModel;
import 'package:redux/redux.dart' show Store;

class StateModelWrapper
    extends model_gui_ritter.StateModelWrapper<AppLocalizations> {
  StateModelWrapper({
    required super.storeStateMap,
  });

  factory StateModelWrapper.deserialize({
    required String serialized,
  }) {
    final json = jsonDecode(
      serialized,
    );

    final storeStateMap = {
      common_gui_ritter.StateKey.l10n: null,
      common_gui_ritter.StateKey.l10nGuiRitter: null,
      common_gui_ritter.StateKey.themeMode: ThemeMode.values.byName(
        json[common_gui_ritter.StateKey.themeMode],
      ),
      common_gui_ritter.StateKey.loadingTagList: <LoadingTagModel>[],
      common_gui_ritter.StateKey.token: json[common_gui_ritter.StateKey.token],
      StateKey.state: StateEnum.values.byName(
        json[StateKey.state],
      ),
      StateKey.sessionId: json[StateKey.sessionId],
      StateKey.sessionList: SessionModel.ofDynamicList(
        list: json[StateKey.sessionList],
      ),
    };

    return StateModelWrapper(
      storeStateMap: storeStateMap,
    );
  }

  StateModelWrapper.init({
    required AppLocalizations? l10n,
    required AppLocalizationsGuiRitter? l10nGuiRitter,
    required List<LoadingTagModel> loadingTagList,
    required String? token,
    required ThemeMode themeMode,
    required StateEnum state,
    required String? sessionId,
    required List<SessionModel> sessionList,
  }) : this(
          storeStateMap: {
            common_gui_ritter.StateKey.l10n: l10n,
            common_gui_ritter.StateKey.l10nGuiRitter: l10nGuiRitter,
            common_gui_ritter.StateKey.loadingTagList: loadingTagList,
            common_gui_ritter.StateKey.themeMode: themeMode,
            common_gui_ritter.StateKey.token: token,
            StateKey.state: state,
            StateKey.sessionId: sessionId,
            StateKey.sessionList: sessionList,
          },
        );

  String? get sessionId => getSessionId(
        storeStateMap: storeStateMap,
      );

  set sessionId(
    String? sessionId,
  ) =>
      setSessionId(
        storeStateMap: storeStateMap,
        sessionId: sessionId,
      );

  List<SessionModel> get sessionList => getSessionList(
        storeStateMap: storeStateMap,
      );

  set sessionList(
    List<SessionModel> sessionList,
  ) =>
      setSessionList(
        storeStateMap: storeStateMap,
        sessionList: sessionList,
      );

  StateEnum get state => getState(
        storeStateMap: storeStateMap,
      );

  set state(
    StateEnum state,
  ) =>
      setState(
        storeStateMap: storeStateMap,
        state: state,
      );

  @override
  Map<String, dynamic> copyWith({
    ValueGetter<AppLocalizations?>? l10n,
    ValueGetter<AppLocalizationsGuiRitter?>? l10nGuiRitter,
    ValueGetter<List<LoadingTagModel>>? loadingTagList,
    ValueGetter<ThemeMode>? themeMode,
    ValueGetter<String?>? token,
    ValueGetter<StateEnum>? state,
    ValueGetter<String?>? sessionId,
    ValueGetter<List<SessionModel>>? sessionList,
  }) =>
      buildNewMap(
        storeStateMap: storeStateMap,
        l10n: l10n,
        l10nGuiRitter: l10nGuiRitter,
        themeMode: themeMode,
        token: token,
        loadingTagList: loadingTagList,
        state: state,
        sessionId: sessionId,
        sessionList: sessionList,
      );

  @override
  String serialize() => jsonEncode(
        {
          common_gui_ritter.StateKey.l10n: null,
          common_gui_ritter.StateKey.l10nGuiRitter: null,
          common_gui_ritter.StateKey.themeMode: themeMode.name,
          common_gui_ritter.StateKey.loadingTagList: <LoadingTagModel>[],
          common_gui_ritter.StateKey.token: token,
          StateKey.state: state.name,
          StateKey.sessionId: sessionId,
          StateKey.sessionList: sessionList.toJson(),
        },
      );

  static Map<String, dynamic> buildNewMap({
    required Map<String, dynamic> storeStateMap,
    ValueGetter<AppLocalizations?>? l10n,
    ValueGetter<AppLocalizationsGuiRitter?>? l10nGuiRitter,
    ValueGetter<List<LoadingTagModel>>? loadingTagList,
    ValueGetter<ThemeMode>? themeMode,
    ValueGetter<String?>? token,
    ValueGetter<StateEnum>? state,
    ValueGetter<String?>? sessionId,
    ValueGetter<List<SessionModel>>? sessionList,
  }) {
    final storeStateMapNew = model_gui_ritter.StateModelWrapper.buildNewMap(
      storeStateMap: storeStateMap,
      l10n: l10n,
      l10nGuiRitter: l10nGuiRitter,
      themeMode: themeMode,
      loadingTagList: loadingTagList,
      token: token,
    );

    final storeStateWrapperCurrent = StateModelWrapper(
      storeStateMap: storeStateMap,
    );

    final newState =
        (state != null) ? state.call() : storeStateWrapperCurrent.state;

    final newSessionId = (sessionId != null)
        ? sessionId.call()
        : storeStateWrapperCurrent.sessionId;

    final newSessionList = (sessionList != null)
        ? sessionList.call()
        : storeStateWrapperCurrent.sessionList;

    storeStateMapNew[StateKey.state] = newState;
    storeStateMapNew[StateKey.sessionId] = newSessionId;
    storeStateMapNew[StateKey.sessionList] = newSessionList;

    return storeStateMapNew;
  }

  static String? getSessionId({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.sessionId] as String?;

  static List<SessionModel> getSessionList({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.sessionList] as List<SessionModel>;

  static StateEnum getState({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.state] as StateEnum;

  static bool selectIsLoading(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.loadingTagList.isNotEmpty;
  }

  static bool selectIsSessionSelected(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.sessionId != null;
  }

  static bool selectIsSignedIn(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.token?.isNotEmpty ?? false;
  }

  static StateEnum selectState(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.state;
  }

  static setSessionId({
    required Map<String, dynamic> storeStateMap,
    required String? sessionId,
  }) =>
      storeStateMap[StateKey.sessionId] = sessionId;

  static setSessionList({
    required Map<String, dynamic> storeStateMap,
    required List<SessionModel> sessionList,
  }) =>
      storeStateMap[StateKey.sessionList] = sessionList;

  static setState({
    required Map<String, dynamic> storeStateMap,
    required StateEnum state,
  }) =>
      storeStateMap[StateKey.state] = state;
}
