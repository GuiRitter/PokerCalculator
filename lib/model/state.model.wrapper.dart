import 'package:flutter/material.dart' show ThemeMode, ValueGetter;
import 'package:flutter_guiritter/common/_import.dart'
    show AppLocalizationsGuiRitter;
import 'package:flutter_guiritter/common/_import.dart' as common_gui_ritter;
import 'package:flutter_guiritter/model/_import.dart' as model_gui_ritter;
import 'package:flutter_guiritter/model/_import.dart' show LoadingTagModel;
import 'package:poker_calculator/common/_import.dart'
    show AppLocalizations, StateEnum, StateKey;
import 'package:redux/redux.dart' show Store;

class StateModelWrapper
    extends model_gui_ritter.StateModelWrapper<AppLocalizations> {
  StateModelWrapper({
    required super.storeStateMap,
  });

  StateModelWrapper.init({
    required AppLocalizations? l10n,
    required AppLocalizationsGuiRitter? l10nGuiRitter,
    required List<LoadingTagModel> loadingTagList,
    required String? token,
    required ThemeMode themeMode,
    required StateEnum state,
    required String? sessionId,
  }) : this(
          storeStateMap: {
            common_gui_ritter.StateKey.l10n: l10n,
            common_gui_ritter.StateKey.l10nGuiRitter: l10nGuiRitter,
            common_gui_ritter.StateKey.loadingTagList: loadingTagList,
            common_gui_ritter.StateKey.themeMode: themeMode,
            common_gui_ritter.StateKey.token: token,
            StateKey.state: state,
            StateKey.sessionId: sessionId,
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

    storeStateMapNew[StateKey.state] = newState;
    storeStateMapNew[StateKey.sessionId] = newSessionId;

    return storeStateMapNew;
  }

  static String? getSessionId({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.sessionId] as String?;

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

  static setState({
    required Map<String, dynamic> storeStateMap,
    required StateEnum state,
  }) =>
      storeStateMap[StateKey.state] = state;
}
