import 'dart:async' show FutureOr;
import 'dart:io' show HttpOverrides;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Locale,
        MaterialApp,
        StatelessWidget,
        ThemeMode,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_guiritter/common/_import.dart'
    show appName, navigatorState, Settings, snackState;
import 'package:flutter_guiritter/common/_import.dart' as common_gui_ritter
    show AppLocalizationsGuiRitter;
import 'package:flutter_guiritter/extension/_import.dart' show StringExtension;
import 'package:flutter_guiritter/model/_import.dart' show LoadingTagModel;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/redux/api/action.dart' as api_action;
import 'package:flutter_guiritter/redux/l10n/action.dart' as l10n_action;
import 'package:flutter_guiritter/redux/theme/selector.dart' show themeSelector;
import 'package:flutter_guiritter/service/dio/my_http_overrides.dart'
    show MyHttpOverrides;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart'
    show StoreConnector, StoreProvider;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;
import 'package:poker_calculator/common/_import.dart'
    show AppLocalizations, StateEnum;
import 'package:poker_calculator/model/_import.dart'
    show SessionModel, StateModelWrapper;
import 'package:poker_calculator/redux/main.reducer.dart' show reducer;
import 'package:poker_calculator/theme/_import.dart' show dark, light;
import 'package:poker_calculator/ui/page/_import.dart' show RootPage;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show thunkMiddleware;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

  SharedPreferences.getInstance().then(
    initializeApp,
  );
}

const isSplashTest = bool.hasEnvironment(
  'SPLASH_TEST',
);

final _log = logger('main');

FutureOr initializeApp(
  SharedPreferences prefs,
) async {
  final themeName = prefs.getString(
    Settings.themeKey,
  );

  await initializeDateFormatting(
    "en",
  );

  _log('initializeApp').raw('theme', themeName).print();

  final theme = (themeName?.isNotEmpty ?? false)
      ? ThemeMode.values.byName(
          themeName!,
        )
      : ThemeMode.system;

  final token = prefs
      .getString(
        Settings.tokenKey,
      )
      .nullIfEmpty;

  api_action.toggleToken(
    token: token,
  );

  final initialStateString = prefs.getString(
    Settings.stateStorageKey,
  );

  final initialState = ((initialStateString == null)
      ? StateModelWrapper.init(
          l10n: null,
          l10nGuiRitter: null,
          loadingTagList: <LoadingTagModel>[],
          themeMode: theme,
          token: token,
          state: StateEnum.foo,
          sessionId: null,
          sessionList: <SessionModel>[],
        )
      : StateModelWrapper.deserialize(
          serialized: initialStateString,
        ));

  final store = Store<Map<String, dynamic>>(
    reducer,
    initialState: initialState.storeStateMap,
    middleware: [
      thunkMiddleware,
    ],
  );

  dispatch = store.dispatch;

  runApp(
    MyApp(
      store: store,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Store<Map<String, dynamic>> store;

  const MyApp({
    super.key,
    required this.store,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    _log('build').print();

    final themeLight = light(
      context: context,
    );

    final themeDark = dark(
      context: context,
    );

    return StoreProvider<Map<String, dynamic>>(
      store: store,
      child: StoreConnector<Map<String, dynamic>, ThemeMode>(
        distinct: true,
        converter: themeSelector,
        builder: (
          context,
          themeMode,
        ) =>
            MaterialApp(
          title: appName,
          onGenerateTitle: getTitleLocalized,
          localeResolutionCallback: populateL10nNotifier,
          theme: themeLight,
          darkTheme: themeDark,
          themeMode: themeMode,
          home: const RootPage(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          // TODO implement l10n switching
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorKey: navigatorState,
          scaffoldMessengerKey: snackState,
        ),
      ),
    );
  }

  String getTitleLocalized(
    context,
  ) =>
      AppLocalizations.of(
        context,
      )!
          .title;

  Locale? populateL10nNotifier(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    _log('populateL10nNotifier').asString('locale', locale).print();

    late common_gui_ritter.AppLocalizationsGuiRitter newL10nGuiRitter;
    late AppLocalizations newL10n;

    Future.wait(
      [
        common_gui_ritter.AppLocalizationsGuiRitter.delegate
            .load(
              locale!,
            )
            .then(
              (
                l10nLoaded,
              ) =>
                  newL10nGuiRitter = l10nLoaded,
            ),
        AppLocalizations.delegate
            .load(
              locale,
            )
            .then(
              (
                l10nLoaded,
              ) =>
                  newL10n = l10nLoaded,
            ),
      ],
    ).then(
      (
        _,
      ) {
        setL10nMethod() => dispatch(
              l10n_action.setL10n(
                l10n: newL10n,
                l10nGuiRitter: newL10nGuiRitter,
              ),
            );

        if (isSplashTest) {
          Future.delayed(
            const Duration(
              seconds: 30,
            ),
          ).then(
            (_) => setL10nMethod(),
          );
        } else {
          setL10nMethod();
        }
      },
    );

    return locale;
  }
}
