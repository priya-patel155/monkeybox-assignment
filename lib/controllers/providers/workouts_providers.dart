import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/Exerise_Model.dart';
import '../database/database_helper.dart';


class WorkoutProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _workouts = [];

  List<Map<String, dynamic>> get workouts => _workouts;

  List<ExerciseModel> _exercises = [];

  List<ExerciseModel> get exercises => _exercises;
  List<ExerciseModel> _filteredExercises = [];
  List<ExerciseModel> get filteredExercises => _filteredExercises;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final DataBaseHelper _dbHelper = DataBaseHelper();
  List<ExerciseModel> _selectedExercises = [];

  List<ExerciseModel> get selectedExercises => _selectedExercises;
  Map<int, List<Map<String, String>>> exerciseSets = {};



  Set<String> uniqueMuscleNames = {};
  Set<String> uniqueEquipment = {};





  WorkoutProvider() {
    _loadWorkouts();

  }

  Future<void> _loadWorkouts() async {
    _workouts = await _dbHelper.fetchData();
    notifyListeners();
  }

  Future<void> addWorkout(String name) async {
    await _dbHelper.insertData({DataBaseHelper.workoutName: name});
    _loadWorkouts();
  }



  Future<void> loadJsonData() async {
    if (_exercises.isNotEmpty) {

      return;
    }

    _isLoading = true;


    try {
      final jsonString = await rootBundle.loadString('assets/exercises.json');
      final jsonResponse = jsonDecode(jsonString);
      final List<dynamic> data = jsonResponse['data'];
      _exercises = data.map((e) => ExerciseModel.fromJson(e)).toList();
      _filteredExercises = _exercises;

      Set<String> uniqueMuscles = {};
      Set<String> uniqueEquipments = {};

      for (var exercise in _exercises) {
        for (var muscle in exercise.mainMuscles!) {
          if (uniqueMuscles.add(muscle.name!)) {
            if (kDebugMode) {
              print('mainMuscles => ${muscle.name}');

            }
          }
        }
      }

      for (var exercise in _exercises) {
        for (var equipments in exercise.equipments!) {
          if (uniqueEquipments.add(equipments.name!)) {
            if (kDebugMode) {
              print('equipments => ${equipments.name}');

            }
          }
        }
      }
      uniqueMuscleNames = uniqueMuscles;

      uniqueEquipment= uniqueEquipments;

     notifyListeners();
    } catch (error) {
      print("Error loading JSON data: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterExercises(String query) {
    if (query.isEmpty) {
      _filteredExercises = _exercises;
    } else {
      _filteredExercises = _exercises
          .where((exercise) => exercise.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> loadExercises(int workOutId) async {
    _selectedExercises = await DataBaseHelper().getExercisesByWorkoutId(workOutId);
    notifyListeners();
  }






  void addSet(int exerciseIndex) {
    if (exerciseSets[exerciseIndex] == null) {
      exerciseSets[exerciseIndex] = [];
    }
    exerciseSets[exerciseIndex]!.add({'kgs': '', 'reps': ''});
    notifyListeners();
  }

  void removeSet(int exerciseIndex, int setIndex) {
    exerciseSets[exerciseIndex]?.removeAt(setIndex);
    notifyListeners();
  }

  void updateSet(int exerciseIndex, int setIndex, String kgs, String reps) {
    if (exerciseSets[exerciseIndex] != null && setIndex < exerciseSets[exerciseIndex]!.length) {
      exerciseSets[exerciseIndex]![setIndex] = {'kgs': kgs, 'reps': reps};
      notifyListeners();
    }
  }

  List<Map<String, String>> getSets(int exerciseIndex) {
    return exerciseSets[exerciseIndex] ?? [];
  }

  void initializeSets() {
    if (selectedExercises.isNotEmpty) {
      for (int i = 0; i < selectedExercises.length; i++) {
        exerciseSets[i] = [{'kgs': '', 'reps': ''}];
      }
    }
  }

  void deleteExercise(int index) {
    _dbHelper.deleteExersise(index);
    selectedExercises.removeAt(index);
    notifyListeners();
  }




}


