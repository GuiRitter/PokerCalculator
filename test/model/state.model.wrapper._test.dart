import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_guiritter/model/_import.dart' show LoadingTagModel;
import 'package:flutter_test/flutter_test.dart' show expect, setUpAll, test;
import 'package:intl/date_symbol_data_local.dart';
import 'package:poker_calculator/common/_import.dart' show StateEnum;
import 'package:poker_calculator/model/_import.dart'
    show SessionModel, StateModelWrapper;

void main() {
  setUpAll(
    () async => initializeDateFormatting(
      'en',
    ),
  );

  test(
    'serialize and back',
    () async {
      final stateDeserializedExpected = {
        'l10n': null,
        'l10nGuiRitter': null,
        'themeMode': ThemeMode.dark,
        'loadingTagList': <LoadingTagModel>[],
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dnZWRJbkFzIjoiYWRtaW4iLCJpYXQiOjE0MjI3Nzk2Mzh9.gzSraSYS8EXBxLN _oWnFSRgCzcmJmMjLiuyu5CSpyHI=',
        'state': StateEnum.foo,
        'sessionId': '00000000-0000-4000-8000-000000000000',
        'sessionList': [
          SessionModel(
            id: '00000000-0000-4000-8000-000000000001',
            name: 'mock session',
            createdAt: DateTime.parse(
              '1970-12-31T23:59:59-03:00',
            ),
            isSelected: false,
          ),
        ]
      };

      final state = StateModelWrapper(
        storeStateMap: stateDeserializedExpected,
      );

      final stateSerializedActual = state.serialize();
      const stateSerializedExpected =
          '{"l10n":null,"l10nGuiRitter":null,"themeMode":"dark","loadingTagList":[],"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dnZWRJbkFzIjoiYWRtaW4iLCJpYXQiOjE0MjI3Nzk2Mzh9.gzSraSYS8EXBxLN _oWnFSRgCzcmJmMjLiuyu5CSpyHI=","state":"foo","sessionId":"00000000-0000-4000-8000-000000000000","sessionList":[{"id":"00000000-0000-4000-8000-000000000001","name":"mock session","createdAt":"1971-01-01T02:59:59.000+00:00","isSelected":false}]}';

      expect(
        stateSerializedActual,
        stateSerializedExpected,
        reason: 'serialized',
      );

      final stateDeserializedActual = StateModelWrapper.deserialize(
        serialized: stateSerializedExpected,
      ).storeStateMap;

      expect(
        stateDeserializedActual,
        stateDeserializedExpected,
        reason: 'deserialized',
      );
    },
  );
}
