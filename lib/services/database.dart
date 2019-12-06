import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCalls {
  final CollectionReference testCollection =
      Firestore.instance.collection("test");

  void createUser(String uid) async {

    // remove pre-made tasks when all functions are finished
    return await testCollection.document(uid).setData({
      "test": "test",
      "preferences": {
        "colorScheme": "default",
        "speechToText": false,
        "taskAssistant": false
      },
      "categories": {
        "general": [
          {"taskName": "clean kitchen", "completed": false},
          {"taskName": "clean bedroom", "completed": false}
        ]
      }
    });
  }

  void addTask(uid, [category = "general", taskName = "learn to fly"]) {
    final taskToAdd = {"taskName": taskName, "completed": false};

    try {
      testCollection.document(uid).updateData({
        "categories.$category": FieldValue.arrayUnion([taskToAdd])
      });
    } catch (err) {
      print(err);
    }
  }

  void addCategory(uid, [category = "general"]) async {

    final snapshot = await this.getDocumentSnapshot(uid);
    final categoryObject = snapshot.data["categories"];

    if(categoryObject.containsKey(category) == false) {
    try {
      testCollection.document(uid).updateData({"categories.$category": []});
    } catch (err) {
      print(err);
    }
    } else {
/*
We need to give user feedback that a category already exists
*/
      print("Category already exists");
    }


  }

  dynamic getDocumentSnapshot(uid) {
    return testCollection.document(uid).get();
  }

  void updatePreferences(uid, [updatedPreferences = const {
      "colorScheme": "notDefault",
      "speechToText": true,
      "taskAssistant": true
    }]) {
    try {
      testCollection.document(uid).updateData({"preferences": updatedPreferences});
    } catch (err) {
      print(err);
    }
  }

  void deleteUser(uid) {
    //need to send user back to login screen. Must discuss best way to do this. User feedback
    try {
      testCollection.document(uid).delete();
    } catch (err) {
      print(err);
    }
  }

  void updateTaskName(uid, [category = "general", taskToUpdate = "clean kitchen", updatedTaskName = "clan kitchen"]) async {
    
    final ds = await this.getDocumentSnapshot(uid);
    final currentTaskArray = ds.data["categories"][category];
    final mappedArray = currentTaskArray.map((x) => x["taskName"]).toList();
    final taskIndex = mappedArray.indexOf(taskToUpdate);
    print(taskIndex);
    currentTaskArray[taskIndex]["taskName"] = updatedTaskName;

    try {
      print("updating data...");
      testCollection
          .document(uid)
          .updateData({"categories.$category": currentTaskArray});
    } catch (err) {
      print(err);
    }
  }

  void completeTask(uid, [category = "general", taskName = "clean bedroom"]) async {
/*
  (✿◠‿◠) Me again! category and taskName should again be taken in as arguments,
  somebody will have to update this later >^_^< unless, perhaps, you could do it? (^_-)-☆
*/
  print(category);
  print(taskName);

    final ds = await this.getDocumentSnapshot(uid);
    final currentTaskArray = ds.data["categories"][category];
    final mappedArray = currentTaskArray.map((x) => x["taskName"]).toList();
    final taskIndex = mappedArray.indexOf(taskName);
    print(taskIndex);
    currentTaskArray[taskIndex]["completed"] = true;

    print(currentTaskArray);
    // try {
    //   print("updating data...");
    //   testCollection
    //       .document(uid)
    //       .updateData({"categories.$category": currentTaskArray});
    // } catch (err) {
    //   print(err);
    // }
  }

  void resetTask(uid) async {
    print('resetting task...');

    final obj1 = [
      {"taskName": "clean kitchen", "completed": false},
      {"taskName": "clean bedroom", "completed": false},
      {"taskName": "study maths", "completed": false}
    ];
    final obj2 = [
      {"taskName": "study english", "completed": false},
      {"taskName": "study french", "completed": false}
    ];

    await testCollection.document(uid).updateData({"categories.general": obj1});
    await testCollection.document(uid).updateData({"categories.school": obj2});
  }

  void deleteCategory(uid) async {
    final categoryToDelete = "general";
/*        ^^^^^^^^^^^^^^^^
ヽ(´ー｀)ﾉ A hard coded value, could it be true ? 
          Who could update this, could it be you ? ヽ(^o^)丿
*/

    final ds = await this.getDocumentSnapshot(uid);
    final currentCategories = ds.data["categories"];
    currentCategories.remove(categoryToDelete);

    try {
      print("updating data...");
      testCollection
          .document(uid)
          .updateData({"categories": currentCategories});
    } catch (err) {
      print(err);
    }
  }

  void deleteTask(uid,
      [category = "general", taskToDelete = "learn to fly"]) async {
    final ds = await this.getDocumentSnapshot(uid);
    final currentTaskArray = ds.data["categories"][category];
    final mappedArray = currentTaskArray.map((x) => x).toList();
    final updatedArray =
        mappedArray.where((x) => x["taskName"] != taskToDelete).toList();

    try {
      print("updating data...");
      testCollection
          .document(uid)
          .updateData({"categories.$category": updatedArray});
    } catch (err) {
      print(err);
    }
  }

  void changeTaskCategory(uid,
      {categoryToTakeFrom = "general",
      taskName = "study maths",
      categoryToInsertInto = "school"}) async {
/*
some function description here
*/

    this.deleteTask(uid, categoryToTakeFrom, taskName);
    this.addTask(uid, categoryToInsertInto, taskName);
  }
}
