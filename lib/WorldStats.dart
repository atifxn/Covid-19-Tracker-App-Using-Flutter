import 'package:covid_tracker/Model/WorldStatsModel.dart';
import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/coutries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  var formatter = NumberFormat('##,000');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xffABE9ED),
    Color(0xffBCE5BA),
    Color(0xffFFB4B1),

  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [

            FutureBuilder(
                future: statsServices.fetchWorldStatsRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        child: SpinKitFadingCircle(
                      color: Colors.teal,
                      size: 50.0,
                      controller: _controller,
                    ));
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                height: 60,
                                image: AssetImage('images/trackerlogo.png')),

                          ],),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: colorList,
                          chartType: ChartType.ring,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: Duration(milliseconds: 2000),
                          chartRadius: MediaQuery.of(context).size.width / 3.7,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/cases.png',
                                color: Color(0xffABE9ED),
                                width: 320,
                                name: 'Confirmed \nCases',
                                data: formatter.format(snapshot.data!.cases),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/death.png',
                                color: Color(0xffFFB4B1),
                                name: 'Total \nDeaths',
                                 data: formatter.format(snapshot.data!.deaths),
                              ),
                              DataBox(
                                image: 'images/recover.png',
                                color: Color(0xffBCE5BA),
                                name: 'Total \nRecovered',
                                data: formatter.format(snapshot.data!.recovered),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/active.png',
                                color: Color(0xffABE9ED).withOpacity(0.7),
                                name: 'Active \nCases',
                                data: formatter.format(snapshot.data!.active),
                              ),
                              DataBox(
                                image: 'images/critical.png',
                                color: Color(0xffF3D9BE),
                                name: 'Critical \nCases',
                                data: formatter.format(snapshot.data!.critical),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/death.png',
                                color: Color(0xffFFB4B1).withOpacity(0.7),
                                name: 'Today \nDeaths',
                                data: formatter.format(snapshot.data!.todayDeaths),
                              ),
                              DataBox(
                                image: 'images/recover.png',
                                color: Color(0xffBCE5BA).withOpacity(0.7),
                                name: 'Today \nRecovered',
                                data: formatter.format(snapshot.data!.todayRecovered),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .005,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class DataBox extends StatefulWidget {
  String name, data;
  double width;
  var color, image;
  DataBox(
      {Key? key,
      required this.name,
      required this.data,
      this.width = 155,
      required this.color,
      required this.image})
      : super(key: key);

  @override
  State<DataBox> createState() => _DataBoxState();
}

class _DataBoxState extends State<DataBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 18),
                ),
                Image(height: 60, width: 60, image: AssetImage(widget.image))
              ],
            ),
            Text(
              widget.data,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  String title, value;
  ReuseRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value, textAlign: TextAlign.center),
              SizedBox(
                height: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
