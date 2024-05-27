import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/database/database_helper.dart';
import '../controllers/providers/workouts_providers.dart';
import '../model/Exerise_Model.dart';
import 'exerises_filter_screen.dart';

class AddExersiseScreen extends StatefulWidget {
  final String? WorkOutName;
  final int? WorkoutId;
  const AddExersiseScreen({super.key, this.WorkOutName, this.WorkoutId});

  @override
  State<AddExersiseScreen> createState() => _AddExersiseScreenState();
}

class _AddExersiseScreenState extends State<AddExersiseScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<WorkoutProvider>(context, listen: false);
    if (widget.WorkoutId != null) {

      provider.loadExercises(widget.WorkoutId!);
    }
    provider.initializeSets();
    super.initState();
  }
  Future<void> saveSetsToDatabase(BuildContext context, int workoutId) async {
    final setsProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final db = DataBaseHelper();


    for (int exerciseIndex = 0; exerciseIndex < setsProvider.selectedExercises.length; exerciseIndex++) {
      final sets = setsProvider.getSets(exerciseIndex);
      for (int setIndex = 0; setIndex < sets.length; setIndex++) {
        await db.insertSet(
          workoutId,
          exerciseIndex,
          sets[setIndex]['kgs']!,
          sets[setIndex]['reps']!,
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print('${widget.WorkOutName}');
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '${widget.WorkOutName.toString()}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              actions: [
                GestureDetector(
                  onTap: (){
                    saveSetsToDatabase(context, widget.WorkoutId!);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.WorkOutName.toString()}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Start by adding an exercise to custimize a personal workout plan',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Consumer<WorkoutProvider>(
                      builder: (context, provider, child) {

                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                            itemCount: provider.selectedExercises.length + 1,
                            itemBuilder: (context, index) {
                              if (index == provider.selectedExercises.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 15),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExerisesFilterSCreen(
                                                          WorkoutId:
                                                              widget.WorkoutId,
                                                        )));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Add  exercise',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                                Icon(Icons.add,
                                                    color: Colors.white),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  Colors.red.withOpacity(0.1)),
                                          child: Center(
                                            child: Text(
                                              'Delete WorkOut',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: height * 0.06,
                                            width: width * 0.1,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                    image: NetworkImage(provider
                                                        .selectedExercises[
                                                            index]
                                                        .thumbImage
                                                        .toString()),
                                                    fit: BoxFit.cover)),
                                            //child: Image.network(exercise.thumbImage.toString() , fit: BoxFit.cover,)
                                          ),
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          Text(provider
                                              .selectedExercises[index].name
                                              .toString()),
                                          Spacer(),

                                          PopupMenuButton<String>(
                                            onSelected: (String result) {
                                              switch (result) {
                                                case 'Edit':

                                                  break;
                                                case 'Delete':
                                                  provider.deleteExercise(index);
                                                  break;
                                                case 'Reorder':

                                                  break;
                                              }
                                            },
                                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                              const PopupMenuItem<String>(
                                                value: 'Edit',
                                                child: Text('Edit'),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'Delete',
                                                child: Text('Delete'),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'Reorder',
                                                child: Text('Reorder'),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Divider(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Consumer<WorkoutProvider>(
                                        builder: (context, setsProvider, child) {
                                          var sets = setsProvider.getSets(index);

                                          bool isTextFieldEmpty = sets.any((set) => set['kgs']!.isEmpty || set['reps']!.isEmpty);
                                          return Column(
                                            children: [
                                              for (int i = 0; i < sets.length; i++)
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                                  child: Row(
                                                    children: [
                                                      Text('${i + 1}.', style: TextStyle(fontSize: 16)),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: Container(

                                                          height: height*0.06,
                                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: TextField(
                                                            decoration: InputDecoration(
                                                              labelText: 'KGs',
                                                              border: InputBorder.none,
                                                              contentPadding: EdgeInsets.only(left: 10 , right: 10)
                                                            ),
                                                            keyboardType: TextInputType.number,
                                                            controller: TextEditingController(
                                                              text: sets[i]['kgs'],
                                                            ),
                                                            onChanged: (value) {
                                                              setsProvider.updateSet(index, i, value, sets[i]['reps']!);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: Container(
                                                          height: height*0.06,
                                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: TextField(
                                                            decoration: InputDecoration(
                                                              labelText: 'Reps',
                                                              border: InputBorder.none,
                                                            ),
                                                            keyboardType: TextInputType.number,
                                                            controller: TextEditingController(
                                                              text: sets[i]['reps'],
                                                            ),
                                                            onChanged: (value) {
                                                              setsProvider.updateSet(index, i, sets[i]['kgs']!, value);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(Icons.remove_circle_outline_outlined , color: Colors.red,),
                                                        onPressed: () {
                                                          setsProvider.removeSet(index, i);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: GestureDetector(
                                                  onTap: () async {
    isTextFieldEmpty ? null :
    setsProvider.addSet(index);

                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(20),
                                                        color: isTextFieldEmpty ? Colors.grey.withOpacity(0.2) : Colors.black),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          'Add Set',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 15,
                                                              color: isTextFieldEmpty ? Colors.black : Colors.white),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )



                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
