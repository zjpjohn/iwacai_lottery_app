import 'dart:io';

import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return GlowingOverscrollIndicator(
        showLeading: false,
        showTrailing: false,
        child: child,
        axisDirection: details.direction,
        color: Colors.transparent,
      );
    }
    return super.buildOverscrollIndicator(context, child, details);
  }
}
