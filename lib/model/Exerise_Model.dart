class ExerciseModel {
  String? id;
  String? description;
  bool? isAccessoryMuscle;
  bool? isCore;
  bool? isFront;
  bool? isPull;
  bool? isPush;
  bool? isUpperBody;
  String? name;
  double? utilityPercentage;
  String? referenceId;
  String? thumbImage;
  String? imageImage;
  String? createdAt;
  String? updatedAt;
  ExerciseSecondaryMuscleGroups? exerciseSecondaryMuscleGroups;
  List<Equipments>? equipments;
  List<MainMuscles>? mainMuscles;

  ExerciseModel(
      {this.id,
        this.description,
        this.isAccessoryMuscle,
        this.isCore,
        this.isFront,
        this.isPull,
        this.isPush,
        this.isUpperBody,
        this.name,
        this.equipments,
        this.utilityPercentage,
        this.referenceId,
        this.thumbImage,
        this.imageImage,
        this.createdAt,
        this.updatedAt,
        this.mainMuscles,
        this.exerciseSecondaryMuscleGroups});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    //var list = json['equipments'] as List;
    // List<EquipmentModel> equipmentsList = list.map((i) => EquipmentModel.fromJson(i)).toList();
    id = json['id'];
    description = json['description'];
    isAccessoryMuscle = json['isAccessoryMuscle'];
    isCore = json['isCore'];
    isFront = json['isFront'];
    isPull = json['isPull'];
    isPush = json['isPush'];
    isUpperBody = json['isUpperBody'];
    name = json['name'];
    utilityPercentage = json['utilityPercentage'];
    referenceId = json['referenceId'];
    thumbImage = json['thumbImage'];
    imageImage = json['imageImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['equipments'] != null) {
      equipments = <Equipments>[];
      json['equipments'].forEach((v) {
        equipments!.add(new Equipments.fromJson(v));
      });
    }
    if (json['mainMuscles'] != null) {
      mainMuscles = <MainMuscles>[];
      json['mainMuscles'].forEach((v) {
        mainMuscles!.add(new MainMuscles.fromJson(v));
      });
    }
    exerciseSecondaryMuscleGroups =json['ExerciseSecondaryMuscleGroups'] != null? new ExerciseSecondaryMuscleGroups.fromJson(json['ExerciseSecondaryMuscleGroups']): null;
    // equipments =json['equipments'] != null? new EquipmentModel.fromJson(json['equipments']): null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['isAccessoryMuscle'] = this.isAccessoryMuscle;
    data['isCore'] = this.isCore;
    data['isFront'] = this.isFront;
    data['isPull'] = this.isPull;
    data['isPush'] = this.isPush;
    data['isUpperBody'] = this.isUpperBody;
    data['name'] = this.name;
    data['utilityPercentage'] = this.utilityPercentage;
    data['referenceId'] = this.referenceId;
    data['thumbImage'] = this.thumbImage;
    data['imageImage'] = this.imageImage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.exerciseSecondaryMuscleGroups != null) {
      data['ExerciseSecondaryMuscleGroups'] =
          this.exerciseSecondaryMuscleGroups!.toJson();
    }
    if (this.equipments != null) {
      data['equipments'] = this.equipments!.map((v) => v.toJson()).toList();
    }
    if (this.mainMuscles != null) {
      data['mainMuscles'] = this.mainMuscles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Equipments {
  String? id;
  String? description;
  String? thumbImage;
  String? name;
  String? referenceId;
  String? createdAt;
  String? updatedAt;
  ExerciseEquipment? exerciseEquipment;

  Equipments(
      {this.id,
        this.description,
        this.thumbImage,
        this.name,
        this.referenceId,
        this.createdAt,
        this.updatedAt,
        this.exerciseEquipment});

  Equipments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    thumbImage = json['thumbImage'];
    name = json['name'];
    referenceId = json['referenceId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    exerciseEquipment = json['ExerciseEquipment'] != null
        ? new ExerciseEquipment.fromJson(json['ExerciseEquipment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['thumbImage'] = this.thumbImage;
    data['name'] = this.name;
    data['referenceId'] = this.referenceId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.exerciseEquipment != null) {
      data['ExerciseEquipment'] = this.exerciseEquipment!.toJson();
    }
    return data;
  }
}

class ExerciseEquipment {
  String? id;
  String? exerciseId;
  String? equipmentId;
  String? createdAt;
  String? updatedAt;

  ExerciseEquipment(
      {this.id,
        this.exerciseId,
        this.equipmentId,
        this.createdAt,
        this.updatedAt});

  ExerciseEquipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseId = json['exerciseId'];
    equipmentId = json['equipmentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exerciseId'] = this.exerciseId;
    data['equipmentId'] = this.equipmentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ExerciseSecondaryMuscleGroups {
  String? id;
  String? exerciseId;
  String? muscleGroupId;
  String? createdAt;
  String? updatedAt;

  ExerciseSecondaryMuscleGroups({this.id,
    this.exerciseId,
    this.muscleGroupId,
    this.createdAt,
    this.updatedAt});

  ExerciseSecondaryMuscleGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseId = json['exerciseId'];
    muscleGroupId = json['muscleGroupId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exerciseId'] = this.exerciseId;
    data['muscleGroupId'] = this.muscleGroupId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}


class MainMuscles {
  String? id;
  Null? description;
  bool? isAccessoryMuscle;
  bool? isCore;
  bool? isFront;
  bool? isPull;
  bool? isPush;
  bool? isUpperBody;
  String? name;
  double? utilityPercentage;
  String? referenceId;
  String? thumbImage;
  Null? imageImage;
  String? createdAt;
  String? updatedAt;
  ExerciseMainMuscleGroups? exerciseMainMuscleGroups;

  MainMuscles(
      {this.id,
        this.description,
        this.isAccessoryMuscle,
        this.isCore,
        this.isFront,
        this.isPull,
        this.isPush,
        this.isUpperBody,
        this.name,
        this.utilityPercentage,
        this.referenceId,
        this.thumbImage,
        this.imageImage,
        this.createdAt,
        this.updatedAt,
        this.exerciseMainMuscleGroups});

  MainMuscles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    isAccessoryMuscle = json['isAccessoryMuscle'];
    isCore = json['isCore'];
    isFront = json['isFront'];
    isPull = json['isPull'];
    isPush = json['isPush'];
    isUpperBody = json['isUpperBody'];
    name = json['name'];
    utilityPercentage = json['utilityPercentage'];
    referenceId = json['referenceId'];
    thumbImage = json['thumbImage'];
    imageImage = json['imageImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    exerciseMainMuscleGroups = json['ExerciseMainMuscleGroups'] != null
        ? new ExerciseMainMuscleGroups.fromJson(
        json['ExerciseMainMuscleGroups'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['isAccessoryMuscle'] = this.isAccessoryMuscle;
    data['isCore'] = this.isCore;
    data['isFront'] = this.isFront;
    data['isPull'] = this.isPull;
    data['isPush'] = this.isPush;
    data['isUpperBody'] = this.isUpperBody;
    data['name'] = this.name;
    data['utilityPercentage'] = this.utilityPercentage;
    data['referenceId'] = this.referenceId;
    data['thumbImage'] = this.thumbImage;
    data['imageImage'] = this.imageImage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.exerciseMainMuscleGroups != null) {
      data['ExerciseMainMuscleGroups'] =
          this.exerciseMainMuscleGroups!.toJson();
    }
    return data;
  }
}

class ExerciseMainMuscleGroups {
  String? id;
  String? exerciseId;
  String? muscleGroupId;
  String? createdAt;
  String? updatedAt;

  ExerciseMainMuscleGroups(
      {this.id,
        this.exerciseId,
        this.muscleGroupId,
        this.createdAt,
        this.updatedAt});

  ExerciseMainMuscleGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseId = json['exerciseId'];
    muscleGroupId = json['muscleGroupId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exerciseId'] = this.exerciseId;
    data['muscleGroupId'] = this.muscleGroupId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

// class EquipmentModel {
//   final String id;
//   final String name;
//   final String description;
//
//   EquipmentModel({required this.id, required this.name, required this.description});
//
//   factory EquipmentModel.fromJson(Map<String, dynamic> json) {
//     return EquipmentModel(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//     );
//   }
//}