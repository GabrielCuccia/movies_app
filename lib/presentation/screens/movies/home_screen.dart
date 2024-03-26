import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/movies/initial_loading_provider.dart';
import 'package:movies_app/presentation/providers/movies/movies_providers.dart';
import 'package:movies_app/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:movies_app/presentation/views/home_views/home_view.dart';
import 'package:movies_app/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:movies_app/presentation/widgets/movies/movies_slideshow.dart';
import 'package:movies_app/presentation/widgets/shared/custom_app.dart';
import 'package:movies_app/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:movies_app/presentation/widgets/shared/full_screen_loader.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.childView});

  static const name = "home-screen";
  final Widget childView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: childView
    );
  }
}

