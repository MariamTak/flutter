
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist_app/models/task.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

Future<void> addTask(Task task) async {
  await FirebaseFirestore.instance.collection('tasks').add({
    'taskTitle': task.title,
    'taskDesc': task.description,
    'taskDate': task.date.toIso8601String(),
    'taskCategory': task.category.name,
  });
}


 Stream <QuerySnapshot> getTasks()
{
final taskStream= tasks.snapshots();
return taskStream;
}
Future<int> deleteTaskByTitle(String taskTitle) async {
  QuerySnapshot querySnapshot = await tasks.where('taskTitle', isEqualTo: taskTitle).get();
  int deletedCount = 0;
  for (var doc in querySnapshot.docs) {
    await doc.reference.delete();
    deletedCount++;
  }
  return deletedCount;
}

}
  /*
Future<int> deleteTaskByTitle(String taskTitle) async {
  QuerySnapshot querySnapshot = await tasks.where('taskTitle', isEqualTo:taskTitle).get();
  int deletedCount = 0;
  for (var doc in querySnapshot.docs){
    await doc.reference.delete();
    deletedCount++;
  }
  return deletedCount



}*/