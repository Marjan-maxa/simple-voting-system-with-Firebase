import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_firebase/login_screen.dart';

class TaskManager extends StatelessWidget {
   TaskManager({super.key});

   TextEditingController titleController=TextEditingController();
   TextEditingController descriptionController=TextEditingController();

   CollectionReference tasks=FirebaseFirestore.instance.collection('tasks');

   Future<void> updateTask(String id,bool completed) async {

     await tasks.doc(id).update(
       {
         'title':titleController.text,
         'description':descriptionController.text,
         'completed':completed,
       }
     );
   }
   Future<void> updateTaskStatus(String id,bool completed) async {

     await tasks.doc(id).update(
       {
         'completed':completed,
       }
     );
   }

   Future<void> deleteTask(String id)async {
     await tasks.doc(id).delete();
   }

   Future<void> addTaskFirebase()async {
    await tasks.add(
       {
         'title':titleController.text,
         'description':descriptionController.text,
         'completed':false,

       }
     );
   }

  
  
  void showDialogbox(BuildContext context, [DocumentSnapshot? doc]){
     if(doc!=null){
       titleController.text=doc['title'];
       descriptionController.text=doc['description'];
     }else{
       titleController.clear();
       descriptionController.clear();
     }
    showDialog(context: context, builder: (_)=>AlertDialog(
      title: Text(doc!=null ?'Update task':'Add task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title'
            ),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description'
            ),
          )
        ],
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('cancel')),
        ElevatedButton(onPressed: (){
          doc!=null?updateTask(doc.id, doc['completed']):
          addTaskFirebase();
          Navigator.pop(context);
        }, child: Text('Add'))
      ],
    ));
  }

  // 32 minutes after start .........................

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          }, icon: Icon(Icons.logout))
        ],
        centerTitle: true ,
        backgroundColor: Colors.blue,
        title: Text('Task Manager',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: tasks.snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final task=snapshot.data!.docs;
          return ListView.builder(
            itemCount: task.length,
              itemBuilder: (context,index){
              final doc=task[index];
            return Slidable(
              key: ValueKey(doc.id),
              endActionPane: ActionPane(motion: DrawerMotion(), children: [
                SlidableAction(onPressed: (_){
                  deleteTask(doc.id);
                },
                backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                )
              ]),
              child: Card(
                child: ListTile(
                  title: Text(doc['title']),
                  subtitle: Text(doc['description']),
                  leading: Checkbox(value: doc['completed'], onChanged: (val){
                    updateTaskStatus(doc.id,val!);
                  }),
                  trailing: IconButton(onPressed: (){
                    showDialogbox(context,doc);
                  }, icon: Icon(Icons.edit)),
                ),
              ),
            );
          }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        onPressed: (){
          showDialogbox(context);
        },child: Icon(Icons.add),),
    );
  }
}
