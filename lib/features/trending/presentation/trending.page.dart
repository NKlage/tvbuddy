import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation.dart';

/// Trending Page
class TrendingPage extends ConsumerWidget {
  /// constructor
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('TV Buddy'),
        backgroundColor:
            Colors.transparent, // TODO(nk): add background color to theme
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 250, child: TrendingMovieList(isMovieList: false)),
              SizedBox(
                  height: 250, child: TrendingMovieList(isMovieList: true)),
              Center(
                child: Text('Trending'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
