import 'package:flutter/material.dart';
import 'package:movies_app/main.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = <String>[
      "Cargando Peliculas",
      "Comprando palomitas de maiz",
      "Cargando Populares",
      "Llamando a mi novia",
      "Ya mero",
      "Esto esta tardando mas de lo esperado"

    ];

Stream <String> getLoadingMenssages(){
  return Stream.periodic(Duration(milliseconds: 1200), (step) {
    return messages[step];
  }).take(messages.length);
}

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      
      CircularProgressIndicator(),
      SizedBox(height: 10,),
      StreamBuilder(stream: getLoadingMenssages(), builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Cargando");
        return(Text(snapshot.data!));
      },)
      
      
    ] );
  }
}