import 'package:flutter_guiritter/model/_import.dart' show Loggable;
import 'package:poker_calculator/common/_import.dart' show StateEnum;
import 'package:poker_calculator/model/_import.dart' show StateModelWrapper;
import 'package:redux/redux.dart' show Store;

class TabsModel implements Loggable {
  final bool isLoading;
  final bool isSessionSelected;
  // TODO might not be needed
  final StateEnum state;

  TabsModel({
    required this.isLoading,
    required this.isSessionSelected,
    required this.state,
  });

  @override
  int get hashCode => Object.hash(
        isLoading,
        isSessionSelected,
        state,
      );

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! TabsModel) {
      return false;
    }
    return (isLoading == other.isLoading) &&
        (isSessionSelected == other.isSessionSelected) &&
        (state == other.state);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'isLoading': isLoading,
        'isSessionSelected': isSessionSelected,
        'state': state.name,
      };

  static TabsModel select(
    Store<Map<String, dynamic>> store,
  ) =>
      TabsModel(
        isLoading: StateModelWrapper.selectIsLoading(
          store,
        ),
        isSessionSelected: StateModelWrapper.selectIsSessionSelected(
          store,
        ),
        state: StateModelWrapper.selectState(
          store,
        ),
      );
}
