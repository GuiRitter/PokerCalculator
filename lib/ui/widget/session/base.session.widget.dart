import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        CheckboxListTile,
        Color,
        GestureLongPressCallback,
        GestureTapCallback,
        ListTile,
        StatelessWidget,
        ValueChanged,
        Widget;
import 'package:flutter_guiritter/common/_import.dart' show CardVariant;

final variantMap = {
  CardVariant.filled: buildFilledCard,
  CardVariant.outlined: buildOutlinedCard,
};

Widget buildFilledCard({
  required Widget child,
}) {
  return Card.filled(
    elevation: 0,
    child: child,
  );
}

// TODO should build an outlined card but I think this only works in Material 3
Widget buildOutlinedCard({
  required Widget child,
}) {
  return Card.outlined(
    color: const Color(
      0x00000000,
    ),
    elevation: 0,
    child: child,
  );
}

class BaseSessionWidget extends StatelessWidget {
  final CardVariant cardVariant;
  final ValueChanged<bool?>? onCheckChanged;
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final bool? isSelected;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool tristate;

  const BaseSessionWidget({
    super.key,
    required this.cardVariant,
    this.onCheckChanged,
    this.leading,
    required this.title,
    this.subtitle,
    this.isSelected,
    this.onTap,
    this.onLongPress,
    this.tristate = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    Widget child;

    if (onCheckChanged != null) {
      child = CheckboxListTile(
        title: title,
        subtitle: subtitle,
        value: isSelected,
        onChanged: onCheckChanged,
        tristate: tristate,
      );
    } else {
      child = ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        onLongPress: onLongPress,
      );
    }

    return variantMap[cardVariant]!(
      child: child,
    );
  }
}
