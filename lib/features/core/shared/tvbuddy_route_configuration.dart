import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Abstract Route Configuration
abstract class TvBuddyRouteConfiguration {
  /// List of GoRoute Configurations
  List<GoRoute> get routes;

  /// Stateful Shell Branch Configuration
  StatefulShellBranch get branch;

  /// Returns a [CupertinoPage] on iOS platforms, for all other platforms a
  /// [MaterialPage] is returned
  Page<T> getPage<T extends Widget>(T child) {
    return Platform.isIOS
        ? CupertinoPage(child: child)
        : MaterialPage(child: child);
  }
}
