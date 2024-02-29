import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/movies/movies_providers.dart';

  final initialLoadingProvider = Provider<bool>((ref) {
    final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
    final step2 = ref.watch(popularMoviesProvider).isEmpty;
    final step3 = ref.watch(upComingProvider).isEmpty;
    final step4 = ref.watch(topRatedProvider).isEmpty;

    if (step1 || step2 || step3 || step4) return true;
    return false;

});