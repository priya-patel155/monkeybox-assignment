import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/database/database_helper.dart';
import '../controllers/providers/workouts_providers.dart';
import '../model/Exerise_Model.dart';
import 'addExerise_Screen.dart';
import 'home_screen.dart';
class ExerisesFilterSCreen extends StatefulWidget {
  final int?  WorkoutId;
  final String?  Workoutname;
  const ExerisesFilterSCreen({super.key , this.WorkoutId , this.Workoutname});

  @override
  State<ExerisesFilterSCreen> createState() => _ExerisesFilterSCreenState();
}

class _ExerisesFilterSCreenState extends State<ExerisesFilterSCreen> {
  TextEditingController _searchController = TextEditingController();


  List<ExerciseModel> selectedExercises = [];

  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<WorkoutProvider>(context, listen: false);
     provider.loadJsonData();
    super.initState();
  }
  void _showMusclesBottomSheet(BuildContext context, Set<String> muscles) {
    Set<String> selectedMuscles = Set();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: muscles.map((muscle) => ListTile(title: Text(muscle))).toList(),
        );
      },
    );
  }

  void _showEquipmentBottomSheet(BuildContext context, Set<String> equipment) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: equipment.map((equipment) => ListTile(title: Text(equipment))).toList(),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      body: Consumer<WorkoutProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10 , right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text('Cancel' , style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15),)),

                    GestureDetector(
                        onTap: (){
                          addSelectedExercisesToDatabase();
                        },
                        child: Text('Save',style: TextStyle(color: Colors.blue , fontWeight: FontWeight.w400 , fontSize: 15),))
                  ],
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              Center(child: Text('Library',style: TextStyle(color: Colors.black , fontWeight: FontWeight.w600 , fontSize: 20),)), SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10 , right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey, // Border color
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Exercises',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none, // Remove default border
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    ),
                    onChanged: (value) {
                      provider.filterExercises(value);
                    },
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10 , right: 10),
                child: Row(
                  children: [
                    Expanded(

                        child: GestureDetector(
                          onTap: (){
                            final muscles = Provider.of<WorkoutProvider>(context, listen: false).uniqueMuscleNames;
                            _showMusclesBottomSheet(context, muscles);
                          },
                          child: Container(
                                                padding: EdgeInsets.all(8),


                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.transparent),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                                                child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Icon(Icons.filter_list_outlined , color: Colors.black,),

                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.01,
                            ),
                            Text('All Groups',style: TextStyle(fontWeight: FontWeight.w600 , color: Colors.black),),

                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.01,
                            ),
                            Icon(Icons.arrow_forward_ios_outlined , color: Colors.grey,size: 20,)



                          ],
                                                ),
                                              ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.04,
                    ),
                    Expanded(

                        child: GestureDetector(
                          onTap: (){

                            final muscles = Provider.of<WorkoutProvider>(context, listen: false).uniqueEquipment;
                            _showEquipmentBottomSheet(context, muscles);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),

                            //margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.transparent),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Icon(Icons.filter_list_outlined , color: Colors.black,),

                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.01,
                                ),
                                Text('All Equipment',style: TextStyle(fontWeight: FontWeight.w600 , color: Colors.black),),

                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.01,
                                ),
                                Icon(Icons.arrow_forward_ios_outlined , color: Colors.grey,size: 20,)



                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10 , right: 10, top: 5),
                  child: ListView.builder(
                    itemCount:  provider.filteredExercises.length,
                    itemBuilder: (context, index) {
                      ExerciseModel exercise = provider.filteredExercises[index];
                      bool isSelected = selectedExercises.contains(exercise);
                      return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color:isSelected ? Colors.orange.withOpacity(0.1) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? Colors.orange : Colors.transparent),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [

                              Container(height: height*0.06,
                                  width: width*0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(
                                              0, 1), // changes position of shadow
                                        ),
                                      ],
                                    image: DecorationImage(
                                      image: NetworkImage(exercise.thumbImage.toString()),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                  //child: Image.network(exercise.thumbImage.toString() , fit: BoxFit.cover,)


                              ),

                              SizedBox(
                                width: width*0.05,
                              ),
                              Column(


                                children: [
                                  Text(exercise.name.toString()),

                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Spacer(),
                              Checkbox(
                                value: isSelected,
                                activeColor: Colors.orange,
                                checkColor: Colors.white,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedExercises.add(exercise);
                                    } else {
                                      selectedExercises.remove(exercise);
                                    }
                                  });
                                },
                              ),

                            ],
                          )
                      );


                      //   ListTile(
                      //   title: Text(exercise.name.toString()),
                      //
                      //   l
                      // );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
  void addSelectedExercisesToDatabase() async{
    for (ExerciseModel exercise in selectedExercises) {

      DataBaseHelper().insertExercise(exercise, widget.WorkoutId!);
    }

    selectedExercises.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected exercises added to database'),
      ),
    );

 await   Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
    );


  }
}
