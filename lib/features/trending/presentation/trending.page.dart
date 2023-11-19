import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared.dart' show TrendingProviders;

/// Trending Page
class TrendingPage extends ConsumerWidget {
  /// constructor
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingService = ref.read(TrendingProviders.trendingService);

    trendingService.dailyTvShows(page: 1).then(
          (value) => debugPrint(
            value.tvShows.toString(),
          ),
        );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('TV Buddy'),
        backgroundColor: Colors.transparent,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Trending'),
        ),
      ),
    );
  }
}
