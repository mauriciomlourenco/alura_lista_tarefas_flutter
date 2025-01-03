import 'package:flutter/material.dart';
import 'package:alura_lista_tarefas_flutter/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.blue,
        title: const Text('Tarefas', style: TextStyle(color: Colors.white)),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: [
            Task(
                "Aprender Flutter",
                "https://miro.medium.com/v2/resize:fit:1400/0*vowtRZE_wvyVA7CB",
                3),
            Task(
                "Andar de Bike",
                "https://savancini.cdn.magazord.com.br/img/2023/08/blog/9958/andar-de-bike.jpg",
                2),
            Task(
                "Meditar",
                "https://organicsnewsbrasil.com.br/wp-content/uploads/2016/04/benef%C3%ADcios-da-ioga.jpg",
                5),
            Task(
                "Ler",
                "https://i0.wp.com/www.sabra.org.br/site/wp-content/uploads/2020/03/x-livros-para-quem-nao-tem-habito-de-ler-comecar-20200110125630.jpg.jpg?fit=800%2C530&ssl=1",
                4),
            Task(
                "Jogar",
                "https://cdn.ome.lt/n6vUMdfCKyMRwczLg4QUCQ57ebo=/970x360/smart/uploads/conteudo/fotos/01cpp01-fifa-20.jpg",
                1),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.blue)),
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
