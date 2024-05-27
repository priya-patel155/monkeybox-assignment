import 'package:flutter/material.dart';

import '../controllers/providers/workouts_providers.dart';
import 'package:provider/provider.dart';

import 'addExerise_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _showAddWorkoutDialog() async {
    String workoutName = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors
              .black,
          title: Text(
            'Add Workout',
            style: TextStyle(
                color: Colors.white),
          ),
          content: TextField(
            onChanged: (value) {
              workoutName = value;
            },
            style: TextStyle(
                color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter workout name",
              hintStyle: TextStyle(
                  color: Colors
                      .white70),
              filled: true,
              fillColor:
                  Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none, // Remove the border
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (workoutName.isNotEmpty) {
                  await Provider.of<WorkoutProvider>(context, listen: false)
                      .addWorkout(workoutName);
                  Navigator.of(context).pop();
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddExersiseScreen(WorkOutName: workoutName,)));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Activity',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Workout Plans',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Strenght Training',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),


                  Consumer<WorkoutProvider>(
                      builder: (context, provider, child) {
                        if(provider.workouts.isNotEmpty){
                    return Text(
                      '${provider.workouts.length} Workouts',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15 , color: Colors.grey),
                    );} else{
                          return Container();
                        }
                  }),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: Consumer<WorkoutProvider>(
                builder: (context, provider, child) {

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView.builder(
                      itemCount: provider.workouts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == provider.workouts.length) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 15),
                            child: GestureDetector(
                              onTap: () {
                                _showAddWorkoutDialog();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add Workouts Plans',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Icon(Icons.add, color: Colors.black),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        print('workout erise ==>${provider.workouts[index]
                        ['Workout_name']}');

                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddExersiseScreen(WorkOutName:provider.workouts[index]['Workout_name'].toString(),WorkoutId: provider.workouts[index]['Workout_id'],)));
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(provider.workouts[index]
                                          ['Workout_name'])
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
