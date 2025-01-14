import 'package:alura_lista_tarefas_flutter/components/task.dart';
import 'package:alura_lista_tarefas_flutter/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT NOT NULL,'
      '$_difficulty INTEGER NOT NULL,'
      '$_image TEXT NOT NULL)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print("Convertendo to List:");
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in mapaDeTarefas) {
      final Task task = Task(row[_name], row[_image], row[_difficulty]);
      tasks.add(task);
    }

    print("Lista de tarefas: $tasks");
    return tasks;
  }

  Map<String, dynamic> toMap(Task task) {
    print("Convertendo tarefa em Map:");
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = task.nomeTarefa;
    mapaDeTarefas[_difficulty] = task.dificuldade;
    mapaDeTarefas[_image] = task.foto;
    print("Mapa de tarefas: $mapaDeTarefas");
    return mapaDeTarefas;
  }

  save(Task tarefa) async {
    print('Acessando o save: $_tableName');
    final Database bancoDeDados = await getDatabase();
    Map<String, dynamic> taskMap = toMap(tarefa);

    var itemExists = await find(tarefa.nomeTarefa);

    if (itemExists.isEmpty) {
      print("A tarefa não existia, então vamos inserir");
      return await bancoDeDados.insert(_tableName, taskMap);
    } else {
      print("A tarefa existia, então vamos atualizar");
      return await bancoDeDados.update(
        _tableName,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nomeTarefa],
      );
    }
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll: $_tableName');

    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableName);
    print('Procurando dados no banco de dados... Encontrado $result');

    return toList(result);
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando o find: $_tableName');

    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tableName, where: '$_name = ?', whereArgs: [nomeDaTarefa]);

    var resultList = toList(result);
    print('Procurando dados no banco de dados... Encontrado: $resultList');

    return resultList;
  }

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');

    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados
        .delete(_tableName, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}
