import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCalls {
  final CollectionReference testCollection =
      Firestore.instance.collection("test");

  void createUser(String uid) async {
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

  void addTask(uid) {
//(#^.^#) i need some more arguments UwU
    print("this function is being called!!");
    print(uid);

    try {
//will take in category as an argument
      final category = "general";

      testCollection.document(uid).updateData({
        "categories.$category": FieldValue.arrayUnion(["learn to fly"])
      });
    } catch (err) {
      print(err);
    }
  }

  void addCategory(uid) {
    print("this function is being called!!");
    print(uid);

    /*--- this will overwrite an existing category
    even if it has tasks in it ¯\_(ツ)_/¯---*/
    final category = "shopping";
    try {
      testCollection.document(uid).updateData({"categories.$category": []});
    } catch (err) {
      print(err);
    }
  }

  dynamic getCategories(uid) {
    print("getting the tasks for user $uid");

    return testCollection.document(uid).get();
  }

  void updatePreferences(uid) {
    print("Preferences for $uid are being updated");

    final updatedPrefs = {
      "colorScheme": "notDefault",
      "speechToText": true,
      "taskAssistant": true
    };

    //updated preferences will be taken from state

    try {
      testCollection.document(uid).updateData({"preferences": updatedPrefs});
    } catch (err) {
      print(err);
    }
  }

  void deleteUser(uid) {
    //need to send user back to login screen. Must discuss best way to do this
    try {
      testCollection.document(uid).delete();
    } catch (err) {
      print(err);
    }
  }

  void editTask(uid) async {
    /*
    Hello! (=^・^=) 
    This function currently simply takes in the current list of tasks for a hard coded category
    and overwrites the final item in it (✿◠‿◠)

    it needs more arguments to be a better function, perhaps you could help?? (#^.^#)
    */

    final category = "general";
    final taskToUpdate = "clean kitchen";
    final newTask = "proof it works!";

    final ds = await this.getCategories(uid);
    final currentTaskArray = ds.data["categories"][category];
    final mappedArray = currentTaskArray.map((x) => x["taskName"]).toList();
    final taskIndex = mappedArray.indexOf(taskToUpdate);
    currentTaskArray[taskIndex]["taskName"] = newTask;

    try {
      print("updating data...");
      testCollection
          .document(uid)
          .updateData({"categories.$category": currentTaskArray});
    } catch (err) {
      print(err);
    }
  }

  void completeTask(uid) async {
/*
  (✿◠‿◠) Me again! category and taskName should again be taken in as arguments,
  somebody will have to update this later >^_^< unless, perhaps, you could do it? (^_-)-☆
*/
    final category = "general";
    final taskName = "clean kitchen";

    final ds = await this.getCategories(uid);
    final currentTaskArray = ds.data["categories"][category];
    final mappedArray = currentTaskArray.map((x) => x["taskName"]).toList();
    final taskIndex = mappedArray.indexOf(taskName);
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
    print('resetting task...');

    final obj = [
      {"taskName": "clean kitchen", "completed": false},
      {"taskName": "clean bedroom", "completed": false}
    ];

    await testCollection.document(uid).updateData({"categories.general": obj});
  }

  void deleteCategory(uid) async {
    final category = "general";

    final ds = await this.getCategories(uid);
    final currentTaskArray = ds.data["categories"][category];
    final mappedArray = currentTaskArray.map((x) => x["taskName"]).toList();

    print(mappedArray);
  }
}
