import 'package:flutter/material.dart';

import 'features/core/shared/localized_build_context.dart';

///
class AppPlaceholder extends StatelessWidget {
  ///
  const AppPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.coreLocalizations.tmdbAttribution),
      ),
    );
  }
}
