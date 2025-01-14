import 'package:alura_lista_tarefas_flutter/components/task.dart';
import 'package:alura_lista_tarefas_flutter/data/task_dao.dart';
import 'package:alura_lista_tarefas_flutter/screens/form_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
        backgroundColor: Colors.blue,
        title: const Text('Tarefas', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                      child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando...")
                    ],
                  ));
                  break;
                case ConnectionState.waiting:
                  return Center(
                      child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando...")
                    ],
                  ));
                  break;
                case ConnectionState.active:
                  return Center(
                      child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando...")
                    ],
                  ));
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task task = items[index];
                          return task;
                        },
                      );
                    }
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 128,
                          ),
                          Text('Não há nenhuma Tarefa',
                              style: TextStyle(fontSize: 32))
                        ],
                      ),
                    );
                  }
                  return Text("Erro ao carregar Tarefas");
                  break;
              }
              return Text("Erro desconhecido");
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.blue)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contextNew) => FormScreen(
                        taskContext: context,
                      ))).then((value) async {
            if (value == true) {
              await TaskDao().findAll();
              setState(() {
                print("Recarregando a tela inicial");
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
