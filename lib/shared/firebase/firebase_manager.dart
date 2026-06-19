import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/Taskmodel.dart';

class FirebaseManager {
  static CollectionReference<Taskmodel> getTaaskCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<Taskmodel>(
          fromFirestore: (snapshot, _) {
            return Taskmodel.fromJson(snapshot.data()!);
          },
          toFirestore: (task, _) {
            return task.tojhson();
          },
        );
  }

  static Future<void> addTask(Taskmodel task) {
    var collection = getTaaskCollection();
    var docRef = collection.doc();
    task.Id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<Taskmodel>> getTask(DateTime date) {
    return getTaaskCollection()
        .where(
      'Date',
          isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch,
        )
        .snapshots();
  }
  static Future<void> deleteTask(String id){
   return getTaaskCollection().doc(id).delete();
  }
}
