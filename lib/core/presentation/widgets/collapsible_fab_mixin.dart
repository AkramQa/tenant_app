import 'package:flutter/widgets.dart';

/// Shrinks an extended FAB to its icon once the page scrolls, so it hides
/// less content. Wrap the scrollable in a `NotificationListener` using
/// [onScrollNotification] and pass [isFabExtended] to the FAB.
mixin CollapsibleFabMixin<T extends StatefulWidget> on State<T> {
  bool isFabExtended = true;

  bool onScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) return false;
    final bool isExtended = notification.metrics.pixels <= 0;
    if (isExtended != isFabExtended) setState(() => isFabExtended = isExtended);
    return false;
  }
}
