import 'package:flutter/material.dart';
import 'package:supabase_pro2/supabse_manger.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SupabaseManger supabaseManger = SupabaseManger();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home screen"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Logout',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: supabaseManger.readData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData != null) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 80.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.purple.shade300,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200.0,
                          child: Center(
                            child: Text(
                              snapshot.data[index]['name'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        //Update
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.purple.shade200,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                supabaseManger.updateData(
                                  snapshot.data[index]['id'],
                                  "Ali",
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.done_all,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.purple.shade200,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                supabaseManger.deleteData(
                                  snapshot.data[index]['id'],
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 1.5,
                    color: Colors.grey,
                  ),
                );
              },
              itemCount: snapshot.data?.length ?? 0,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Container(
        padding: EdgeInsetsDirectional.only(
          start: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.purple.shade200,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: nameController,
                onChanged: (value) {
                  nameController.text = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your name !',
                ),
              ),
            ),
            SizedBox(width: 10.0),
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.purple.shade300,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    supabaseManger.addData(nameController.text);
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.purple.shade300,
              child: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        supabaseManger.logout(context);
        break;
    }
  }
}
