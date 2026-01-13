import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});

  get docs => null;

  @override
  Widget build(BuildContext context) {

    voteCandidates(String id){
      FirebaseFirestore.instance.collection('Candidates').doc(id).update({
        'Votes':FieldValue.increment(1)
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Vote Center',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true ,
      ),

      body:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Candidates').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          final candidate=snapshot.data!.docs;
          return Center(
            child: GridView.builder(
              shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.55,

                ),
                itemCount: candidate.length,
                itemBuilder: (context,index){
                final doc =candidate[index];
                final  data=doc.data() as Map<String,dynamic>;
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Image.network(data['imageUrl'],fit: BoxFit.cover,
                          width: double.infinity,)),
                          Text(data['Name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Text(data['Votes'].toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white
                            ),
                              onPressed: ()=>voteCandidates(doc.id), child: Text('Given Vote'))
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        }
      ),
    );
  }
}
