import 'package:flutter/widgets.dart';

/// Use Provider OnInit Mixin
mixin UseProviderOnInit {
  /// Call [action] in PostFrameCallback
  void useOnInit(Function action) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // ignore: avoid_dynamic_calls
        action();
      },
    );
  }
}
