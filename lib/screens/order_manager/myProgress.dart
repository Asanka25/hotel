import 'package:flutter/material.dart';
import 'package:hotel/services/auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:hotel/services/orderManager_database.dart';


class MyProgress extends StatefulWidget {
  @override
  Map count;
  MyProgress({this.count});
  _MyProgressState createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  final AuthService _auth = AuthService();
  List<charts.Series<Task, String>> _seriesPieData;
  

  _generateData() async{

    List<Task> pieData=[];
     widget.count.forEach((k,v) { 
       pieData.add(Task(task: k,taskvalue: v));
     });

    _seriesPieData.add(
      charts.Series(
          data: pieData,
          domainFn: (Task task, _) => task.task.toString(),
          measureFn: (Task task, _) => task.taskvalue,
          id: 'Task',
          // colorFn: (_, __) =>charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn: (Task row, _) => '${row.taskvalue}'),
    );
  }

  @override
  void initState() {
    super.initState();
    

    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'My progress',
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.blue,
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<int>>[
                  PopupMenuItem(
                    value: 0,
                    child: FlatButton.icon(
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Logout',
                        //  style: TextStyle(color: Colors.blue)
                      ),
                      onPressed: () async {
                        await _auth.signOut();
                      },
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            // Text("progres"),
            SizedBox(height: 45.0),
            Expanded(
                child: charts.PieChart(
              _seriesPieData,
              animate: true,
              animationDuration: Duration(seconds: 5),
              behaviors: [
                charts.DatumLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: false,
                    desiredMaxRows: 2,
                    cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                    entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                        // fontFamily: 'Georgia',
                        fontSize: 11))
              ],
              defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 200,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.inside)
                  ]),
            )),
          ],
        )));
  }
}

class Task {
  String task;
  int taskvalue;

  Task({this.task, this.taskvalue});
}
