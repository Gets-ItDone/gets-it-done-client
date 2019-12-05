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
      "categories": {"general": []}
    });
  }

  void addTask(uid) {
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

    /*---^_^ this will overwrite an existing category
    even if it has tasks in it ¯\_(ツ)_/¯---*/
    final category = "schoolwork";
    try {
      testCollection.document(uid).updateData({"categories.$category": []});
    } catch (err) {
      print(err);
    }
  }

  void getTasks(uid) {
    print("getting the tasks for user $uid");

    testCollection.document(uid).get().then((DocumentSnapshot ds) {
      var unknown = ds.data;
      print(unknown);
    });
  }
}
