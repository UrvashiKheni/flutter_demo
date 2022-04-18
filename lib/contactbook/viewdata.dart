import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/contactbook/insertdata.dart';
import 'package:getwidget/getwidget.dart';

class viewdata extends StatefulWidget {
  const viewdata({Key? key}) : super(key: key);

  @override
  _viewdataState createState() => _viewdataState();
}

class _viewdataState extends State<viewdata> {
  getalldata() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook");

    DatabaseEvent event = await ref.once();

    Map m = event.snapshot.value as Map;

    List<Map> list = [];

    m.forEach((key, value) {
      list.add(value);
    });
    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getalldata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List list = snapshot.data as List;
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            child: ListTile(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Update or Delete"),
                                      content:
                                          Text("Please select your choice..."),
                                      actions: [
                                        TextButton.icon(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              String newname = "urvi";
                                              String newcontact = "1236548792";
                                              String userid =
                                                  list[index]['userid'];

                                              DatabaseReference ref =
                                                  FirebaseDatabase.instance
                                                      .ref("contactbook")
                                                      .child(userid);

                                              Map m = {
                                                "userid": userid,
                                                "name": newname,
                                                "contact": newcontact
                                              };

                                              await ref.set(m);
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.edit),
                                            label: Text("Update")),
                                        TextButton.icon(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              String userid =
                                                  list[index]['userid'];

                                              DatabaseReference ref =
                                                  FirebaseDatabase.instance
                                                      .ref("contactbook")
                                                      .child(userid);

                                              await ref.remove();
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.delete),
                                            label: Text("Delete")),
                                      ],
                                    );
                                  },
                                );
                              },
                              tileColor: Colors.black12,
                              // leading: Text(
                              //   "${list[index]['userid']}",
                              //   style: TextStyle(fontSize: 18),
                              // ),
                              title: Text("${list[index]['name']}",
                                  style: TextStyle(fontSize: 18)),
                              subtitle: Text("${list[index]['contact']}",
                                  style: TextStyle(fontSize: 18)),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("no data found"),
                      );
                    }
                  }

                  return Center(
                    child: GFLoader(type: GFLoaderType.circle),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return insertdata();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
