import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/movies/initial_loading_provider.dart';
import 'package:movies_app/presentation/providers/movies/movies_providers.dart';
import 'package:movies_app/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:movies_app/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:movies_app/presentation/widgets/movies/movies_slideshow.dart';
import 'package:movies_app/presentation/widgets/shared/custom_app.dart';
import 'package:movies_app/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:movies_app/presentation/widgets/shared/full_screen_loader.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = "home-screen";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Center(
        child: HomeView(),
      ),
    );
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
  }
  @override
  Widget build(BuildContext context) {
    final isInitialLoadingReady = ref.watch(initialLoadingProvider);
    final moviesSlidesShow = ref.watch(MoviesSlidesShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upComingProvider);
    final topRatedMovies = ref.watch(topRatedProvider);
    if (nowPlayingMovies.length == 0) return const CircularProgressIndicator();
    return isInitialLoadingReady ? FullScreenLoader() : 
     CustomScrollView(

      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppBar(),
          ),

        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          return  Column(
          
          
          
          children: [
            
          
            MoviesSlidesShow(movies: moviesSlidesShow),
          
            MovieHorizontalListview(
              movies: nowPlayingMovies,
               title: "En cines",
                subTitle: "Lunes 12",
                loadNextPage: () {
                  
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  
                }
                ),
                MovieHorizontalListview(
                movies: upComingMovies,
                title: "Proximamente",
                subTitle: "En este mes",
                loadNextPage: () {
                  ref.read(upComingProvider.notifier).loadNextPage();
                 
                  
                }
                ),
                MovieHorizontalListview(
                movies: popularMovies,
                title: "Populares",
                
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                  
                }
                ),
                MovieHorizontalListview(
                movies: topRatedMovies,
                title: "Mejor calificadas",
                
                loadNextPage: () {
                  ref.read(topRatedProvider.notifier).loadNextPage();
                  
                }
                ),
                SizedBox(height: 50,)
            
          ],
        );

        }, childCount: 1))
      ],
         
      );
  }
}