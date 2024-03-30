import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.index});
  final int index;
  onNavigation(BuildContext context, int index){
    switch(index) {
      case 0:
      context.go("/home/0");
      break;
      case 1:
      context.go("/home/1");
      break;
      case 2:
      context.go("/home/2");
      break;
      default: context.go("/home/0");
      
    }
  }
  @override
  Widget build(BuildContext context) {


    return BottomNavigationBar(
      onTap: (value) => onNavigation(context, value),
      currentIndex: index,
      elevation: 0,
      items: [

       BottomNavigationBarItem(
        
        icon: Icon(Icons.home_max),
       label: "Inicio"
       ),
      BottomNavigationBarItem(icon: Icon(Icons.label_outline),
      label: "Categorias"
      ),
      BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),
       label: "Favoritos"
       ),
    ]);
  }
}