import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'main.dart' as main;
class Job {
  final int id;
  final String name;
  final String image;
  Job({this.id, this.name, this.image});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class JobsListView extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends  State <JobsListView> {
  int _languageIndex = -1;
bool dat=true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchUrl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data;
          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Job>> _fetchUrl() async {

    final myurl = 'https://elephant-api.herokuapp.com/elephants/';
    final response = await http.get(myurl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  ListView _jobsListView(data) {
    return ListView.separated(


        itemCount: 20,
        itemBuilder: (context, index) {
      return   GestureDetector(
            child: _buildWidget( data[index].name,data[index].image,1),
            onTap: () => setState(() => dat=!dat),
          );
       // return _tile( data[index].name,data[index].image);
        },
      separatorBuilder: (context, index) {
        return Divider();
      },);
  }

//ListTile _tile(String na, String img) =>_buildWidget(na, img);

  // ListTile(
  //
  //   title: Text(na,
  //       style: TextStyle(
  //         fontWeight: FontWeight.w500,
  //         fontSize: 20,
  //       )),
  //   // subtitle: Text(name),
  //
  //    leading: ClipOval(
  //        child: Image.network(
  //          img,
  //          fit: BoxFit.cover,
  //          width: 60.0,
  //          height: 90.0,
  //        )
  //    ),
  //
  // );
  Widget _buildWidget(String na,String img,int index){
    bool isSelected = false;
    return new Container (


      child: ListTile(

        onLongPress: () {  dat=!dat;
          print(dat);
        },
        title: Text(na,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),

        ),

        // subtitle: Text(name),

        leading: ClipOval(
            child: Image.network(
              img,
              fit: BoxFit.cover,
              width: 60.0,
              height: 90.0,
            )
        ),),
      decoration:  BoxDecoration (
          color:  dat ? Colors.white54.withOpacity(0.8) : Colors.grey[700]
      ),
    );
  }
}