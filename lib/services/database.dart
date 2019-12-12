import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCalls {
  final CollectionReference testCollection =
      Firestore.instance.collection("test");

  void createUser(String uid) async {
    return await testCollection.document(uid).setData({
      "test": "test",
      "preferences": {
        "colorScheme": "1",
        "speechToText": false,
        "taskAssistant": false
      },
      "categories": {"general": []}
    });
  }

  addTask(uid,
      [category = "general",
      taskName = "learn to fly",
      dueDate = 1576231320851,
      taskLength]) async {
    final snapshot = await this.getDocumentSnapshot(uid);
    final categoryArray = snapshot.data["categories"][category];

    bool taskDoesntExist =
        categoryArray.every((task) => task["taskName"] != taskName);
    bool isTaskComplete = false;

    categoryArray.forEach((task) {
      if (task["taskName"] == taskName) {
        isTaskComplete = task["completed"];
      }
    });

    if (taskDoesntExist || isTaskComplete) {
      try {
        final taskToAdd = {
          "taskName": taskName,
          "completed": false,
          "taskLength": taskLength,
          "dueDate": dueDate
        };
        testCollection.document(uid).updateData({
          "categories.$category": FieldValue.arrayUnion([taskToAdd])
        });
      } catch (err) {
        return err;
      }
    } else {
      return 'Task already exists';
    }
  }

  dynamic getTaskBasket(uid) async {
    dynamic dateNow = new DateTime.now().millisecondsSinceEpoch;

    final ds = await this.getDocumentSnapshot(uid);
    final currentCategoryObject = ds.data["categories"];
    var categoryArray = [];
    currentCategoryObject.forEach((key, value) => categoryArray.add(key));

    var allTaskArray = [];
    var taskBasket = [];

    categoryArray.forEach((category) {
      final uncompletedTaskArray = currentCategoryObject[category]
          .where((task) => task["completed"] == false)
          .map((task) {
        task["category"] = category;
        return task;
      }).toList();
      uncompletedTaskArray.forEach((task) {
        allTaskArray.add(task);
      });
    });

    var vOverdueTasks =
        allTaskArray.where((task) => (task["dueDate"] - dateNow) < -172800000);
    var overdueTasks = allTaskArray.where((task) =>
        (task["dueDate"] - dateNow) < 0 &&
        (task["dueDate"] - dateNow) > -172800000);
    var todayTasks = allTaskArray.where((task) =>
        (task["dueDate"] - dateNow) < 86400000 &&
        (task["dueDate"] - dateNow) > 0);
    var tomorrowTasks = allTaskArray.where((task) =>
        (task["dueDate"] - dateNow) > 86400000 &&
        (task["dueDate"] - dateNow) < 172800000);
    var laterTasks =
        allTaskArray.where((task) => (task["dueDate"] - dateNow) > 172800000);

    taskBasket.addAll(vOverdueTasks);

    if (taskBasket.length < 3) taskBasket.addAll(overdueTasks);
    if (taskBasket.length < 3) taskBasket.addAll(todayTasks);
    if (taskBasket.length < 3) taskBasket.addAll(tomorrowTasks);
    if (taskBasket.length < 3) taskBasket.addAll(laterTasks);

    var count = 0;
    var updatedBasket = [];

    taskBasket.forEach((task) {
      if (count + task["taskLength"] <= 4 && updatedBasket.length < 3) {
        updatedBasket.add(task);
        count = count + task["taskLength"];
      }
    });

    return updatedBasket.toList();
  }

  addCategory(uid, [category = "general"]) async {
    final snapshot = await this.getDocumentSnapshot(uid);
    final categoryObject = snapshot.data["categories"];

    if (categoryObject.containsKey(category) == false) {
      try {
        testCollection.document(uid).updateData({"categories.$category": []});
      } catch (err) {
        print(err);
      }
    } else {
      return 'Category already exists.';
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

  dynamic isTooLong(string) {
    var wordsArray = string.split(" ");
    var bool;
    wordsArray.length < 6 ? bool = false : bool = true;
    print(wordsArray);
    return bool;
  }
}
