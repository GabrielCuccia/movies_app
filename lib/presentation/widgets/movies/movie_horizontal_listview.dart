
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/helpers/human_formats.dart';

class MovieHorizontalListview extends StatefulWidget {
  const MovieHorizontalListview({super.key, required this.movies, this.title, this.subTitle, this.loadNextPage});
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    
    super.initState();
    

    scrollController.addListener(() {
    if (widget.loadNextPage == null) return;
    if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent ){
      print("Hey");
      widget.loadNextPage!();
    }
    });

  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(

        children: [
          if(widget.title != null || widget.subTitle != null )
          _Title(title: widget.title, subTitle: widget.subTitle,),

          Expanded(child: 
          ListView.builder(
            controller: scrollController,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
            return _Slide(movie: widget.movies[index],);
          },)
          )

        ],
        
      ),
    );
  }
}




class _Slide extends StatelessWidget {


  final Movie movie;


  const _Slide({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(


        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(movie.posterPath,
            fit: BoxFit.cover,
            width: 150,
            loadingBuilder: (context, child, loadingProgress) {


              if (loadingProgress != null){
                return Center(child: CircularProgressIndicator(strokeWidth: 2,));
              }
              return FadeIn(child: child);
            },
            ))
          
        ),

        SizedBox(
          height: 5,
        ),


        SizedBox(
          width: 150,
          child: Text(movie.title, maxLines: 2, style: textStyles.titleSmall,),
          
        ),

        SizedBox(
          width: 150,
          child: Row(
            
            children: [
            Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
            SizedBox(width: 3,),
            Text( movie.voteAverage.toStringAsFixed(1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
        
            Spacer(),
            Text("${HumanFormats.number(movie.popularity)}", style: textStyles.bodySmall,)
          ],),
        )

        ]),
    );
  }
}



class _Title extends StatelessWidget {
  const _Title({super.key, this.title, this.subTitle});
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
          Text(title!, style: titleStyle,),
          const Spacer(),
          if(subTitle != null)
          FilledButton.tonal(onPressed: () {},
           child: Text(subTitle!),
           style: ButtonStyle(visualDensity: VisualDensity.compact),
           )
        ],
      ),
    );
  }
}