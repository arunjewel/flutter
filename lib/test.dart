import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart' as main;
class Job {
  final int id;
  final String name;
  final String image;
  final String msg;
  Job({this.id, this.name, this.image, this.msg});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      msg: json['note'],
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
            child: _buildWidget( data[index].name,data[index].image,data[index].msg,1),
            onTap: () => setState(() => dat=!dat),
          );
       // return _tile( data[index].name,data[index].image);
        },
      separatorBuilder: (context, index) {
        return Divider();
      },);
  }


  Widget _buildWidget(String na,String img,String msg,int index){
    bool isSelected = false;
    return new Container (


      child: ListTile(

        onLongPress: () {  dat=!dat;
          print(dat);
         {
          if(2 == 2){
            return  PopupMenuButton<String>(

        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        CheckedPopupMenuItem<String>(


        child: Text('fg', style: Theme.of(context).textTheme.body1),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
        value: 'Get Link',
        child: ListTile(
        leading: Icon(Icons.phonelink),
        title: Text('Get link', style: Theme.of(context).textTheme.body1),
        )
        )]);
          }
          }
        },
        title: Text(na,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),

        ),

        subtitle: Text(msg,
          overflow: TextOverflow.ellipsis,),
        trailing: Text('just now'),

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

