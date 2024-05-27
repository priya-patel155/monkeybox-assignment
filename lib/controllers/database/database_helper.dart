import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/Exerise_Model.dart';

class DataBaseHelper {
  static const databaseName = "FitnessTraining.db";
  static const databaseVersion = 1;
  static const workoutsTable = "Workout";
  static const workoutId = "Workout_id";
  static const workoutName = "Workout_name";

  static const ExercisesTable = "Exercises";
  static const ExercisesId = "exercises_id";
  static const ExercisesName = "exercises_name";
  static const ExercisesThumb = "thumbImage";


  final String setsTable = 'sets';
  final String setId = 'setId';
  final String kgs = 'kgs';
  final String reps = 'reps';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);

    print('path==>${path}');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $workoutsTable (
      $workoutId INTEGER PRIMARY KEY AUTOINCREMENT,
      $workoutName TEXT
    )
  ''');

    await db.execute('''
      CREATE TABLE $ExercisesTable (
        $ExercisesId INTEGER PRIMARY KEY AUTOINCREMENT,
        $ExercisesName TEXT,
        $ExercisesThumb TEXT,
        $workoutId INTEGER,
        FOREIGN KEY ($workoutId) REFERENCES $workoutsTable($workoutId)
      )
    ''');


    await db.execute('''
          CREATE TABLE $setsTable (
            $setId INTEGER PRIMARY KEY AUTOINCREMENT,
            $kgs TEXT,
            $reps TEXT,
            $workoutId INTEGER,
            $ExercisesId INTEGER,
            FOREIGN KEY ($workoutId) REFERENCES $workoutsTable($workoutId),
            FOREIGN KEY ($ExercisesId) REFERENCES $ExercisesTable($ExercisesId)
          )
        ''');

  }

  Future<int> insertData(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert(workoutsTable, row);
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final db = await database;
    return await db.query(workoutsTable);
  }


  Future<void> insertExercise(ExerciseModel exercise, int workoutId) async {
    final db = await database;
    await db.insert(
      ExercisesTable,
      {

        'exercises_name': exercise.name,
        'thumbImage': exercise.thumbImage,
        'Workout_id': workoutId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ExerciseModel>> getExercisesByWorkoutId(int workoutId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      ExercisesTable,
      where: 'Workout_id = ?',
      whereArgs: [workoutId],
    );

    return List.generate(maps.length, (i) {
      return ExerciseModel(

        name: maps[i]['exercises_name'],
        thumbImage: maps[i]['thumbImage'],

      );
    });
  }


  Future<int> insertSet(int exerciseId, int workoutId, String kgs, String reps) async {
    Database db = await database;
    Map<String, dynamic> data = {
      'kgs': kgs,
      'reps': reps,
      'workoutId': workoutId,
      'ExercisesId': exerciseId,
    };
    return await db.insert(setsTable, data);
  }
  Future<int> deleteSet(int setId) async {
    Database db = await database;
    return await db.delete(setsTable, where: 'setId = ?', whereArgs: [setId]);
  }

  Future<int> deleteExersise(int exersieId) async {
    Database db = await database;
    return await db.delete(ExercisesTable, where: 'exercises_id = ?', whereArgs: [ExercisesId]);
  }



}
