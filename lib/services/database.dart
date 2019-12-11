import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCalls {
  final CollectionReference testCollection =
      Firestore.instance.collection("test");

  void createUser(String uid) async {
    // remove pre-made tasks when all functions are finished
    return await testCollection.document(uid).setData({
      "test": "test",
      "preferences": {
        "colorScheme": "1",
        "speechToText": false,
        "taskAssistant": false
      },
      "categories": {
        "general": [
          {
            "taskName": "clean kitchen",
            "completed": false,
            "dueDate": 1575800147000 //very overdue
          },
          {
            "taskName": "clean bedroom",
            "completed": false,
            "dueDate": 1575972947020 // overdue
          },
          {
            "taskName": "clean bathroom",
            "completed": false,
            "dueDate": 1575972947030 // overdue
          },
          {
            "taskName": "clean my room",
            "completed": false,
            "dueDate": 1575972947040 // overdue
          },
          {
            "taskName": "clean my room",
            "completed": false,
            "dueDate": 1576138547000 // today
          },
          {
            "taskName": "clean my room",
            "completed": false,
            "dueDate": 1576206947000 // tomrrow
          },
          {
            "taskName": "clean my room",
            "completed": false,
            "dueDate": 1576466147000 // later
          }
        ]
      }
    });
  }

  void addTask(uid,
      [category = "general",
      taskName = "learn to fly",
      dueDate = 1576231320851]) async {
    final snapshot = await this.getDocumentSnapshot(uid);
    final categoryArray = snapshot.data["categories"][category];

    bool taskDoesntExist =
        categoryArray.every((task) => task["taskName"] != taskName);

    if (taskDoesntExist) {
      try {
        final taskToAdd = {"taskName": taskName, "completed": false};
        testCollection.document(uid).updateData({
          "categories.$category": FieldValue.arrayUnion([taskToAdd])
        });
      } catch (err) {
        return err;
      }
    }
  }

  void timestampTest(uid, category, taskName, dueDate) async {
    dynamic dateNow = new DateTime.now().millisecondsSinceEpoch;
    // print(category);
    // print(taskName);
    // print(dateNow);
    // print(dueDate);

    print((dueDate - dateNow) / 3600000);

    final ds = await this.getDocumentSnapshot(uid);
    final currentCategoryObject = ds.data["categories"];
    var categoryArray = [];
    currentCategoryObject.forEach((key, value) => categoryArray.add(key));

    var allTaskArray = [];

    categoryArray.forEach((category) {
      final uncompletedTaskArray = currentCategoryObject[category]
          .where((task) => task["completed"] == false)
          .map((task) {
        task["category"] = category;
        return task;
      }).toList();
      uncompletedTaskArray.forEach((task) {
        // print(task);
        allTaskArray.add(task);
      });
    });

    print(allTaskArray);
    var vOverdueTasks =
        allTaskArray.where((task) => (task["dueDate"] - dateNow) < -172800000);
    var overdueTasks =
        allTaskArray.where((task) => (task["dueDate"] - dateNow) < 0);
    // var todayTasks =
    //     allTaskArray.where((task) => (dateNow - task["dueDate"]) < 86400000);
    // var tomorrowTasks =
    //     allTaskArray.where((task) => (dateNow - task["dueDate"]) < -86400000);
    // var laterTasks =
    //     allTaskArray.where((task) => (dateNow - task["dueDate"]) < -86400000);

    print(vOverdueTasks);
    print(overdueTasks);
  }

  void addCategory(uid, [category = "general"]) async {
    final snapshot = await this.getDocumentSnapshot(uid);
    final categoryObject = snapshot.data["categories"];

    if (categoryObject.containsKey(category) == false) {
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

  updatePreferences(uid, colorScheme, speechToText, taskAssistant) {
    final updatedPreferences = {
      'colorScheme': colorScheme,
      'speechToText': speechToText,
      'taskAssistant': taskAssistant
    };

    try {
      testCollection
          .document(uid)
          .updateData({"preferences": updatedPreferences});
      return {'status': 200, 'msg': 'Success'};
    } catch (err) {
      return err;
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

  void updateTaskName(uid,
      [category = "general",
      taskToUpdate = "clean bedroom",
      updatedTaskName = "clan kitchen"]) async {
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

  void completeTask(uid,
      [category = "general", taskName = "clean bedroom"]) async {
    print(uid);
    print(category);
    print(taskName);
    final ds = await this.getDocumentSnapshot(uid);
    final currentTaskArray = ds.data["categories"]
        [category]; //creates array of current tasks in given category

    final mappedArray = currentTaskArray.map((x) => x["taskName"]).toList();
    final taskIndex = mappedArray
        .indexOf(taskName); //finds the index of the task to be updated

    currentTaskArray[taskIndex]["completed"] = true;
    print(currentTaskArray);
    try {
      print("updating data...");
      testCollection
          .document(uid)
          .updateData({"categories.$category": currentTaskArray});
    } catch (err) {
      print(err);
    }
  }

  void resetTask(uid) async {
    //for testing purposes
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

  void deleteCategory(uid, [categoryToDelete = "general"]) async {
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
this takes a task out of categoryToTakeFrom and insterts it into categoryToInsertInto
*/

    this.deleteTask(uid, categoryToTakeFrom, taskName);
    this.addTask(uid, categoryToInsertInto, taskName);
  }

  dynamic getCategories(uid) async {
    final ds = await this.getDocumentSnapshot(uid);
    final currentCategoryObject = ds.data["categories"];
    var categoryArray = [];
    currentCategoryObject.forEach((key, value) => categoryArray.add(key));
    return categoryArray;
  }

  dynamic getTasksByCategory(uid, category) async {
    final ds = await this.getDocumentSnapshot(uid);
    final taskArray = ds.data["categories"][category].toList();

    final uncompletedTaskArray = taskArray
        .where((task) => task["completed"] == false)
        .map((task) => task["taskName"])
        .toList();

    return uncompletedTaskArray;
  }

  dynamic getPreferences(uid) async {
    final ds = await this.getDocumentSnapshot(uid);
    final preferences = ds.data["preferences"];
    return preferences;
  }

  dynamic getAllTasks(uid) async {
    final ds = await this.getDocumentSnapshot(uid);
    final currentCategoryObject = ds.data["categories"];
    var categoryArray = [];
    currentCategoryObject.forEach((key, value) => categoryArray.add(key));

    var allTaskArray = [];

    categoryArray.forEach((category) {
      final uncompletedTaskArray = currentCategoryObject[category]
          .where((task) => task["completed"] == false)
          .map((task) => task["taskName"])
          .toList();
      uncompletedTaskArray.forEach((task) {
        print(task);
        allTaskArray.add(task);
      });
    });

    return allTaskArray;
  }

  dynamic getAllTasksWithCategories(uid) async {
    final ds = await this.getDocumentSnapshot(uid);
    final currentCategoryObject = ds.data["categories"];
    var categoryArray = [];
    currentCategoryObject.forEach((key, value) => categoryArray.add(key));

    var allTaskArray = [];

    categoryArray.forEach((category) {
      final uncompletedTaskArray = currentCategoryObject[category]
          .where((task) => task["completed"] == false)
          .map((task) {
        task["category"] = category;
        return task;
      }).toList();
      uncompletedTaskArray.forEach((task) {
        print(task);
        allTaskArray.add(task);
      });
    });

    print(allTaskArray);
    return allTaskArray;
  }
}
