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
      final category = "schoolwork";

      testCollection.document(uid).updateData({
        "categories.$category": FieldValue.arrayUnion(["write a book"])
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
    } catch(err) {
      print(err);
    }
  }
}
