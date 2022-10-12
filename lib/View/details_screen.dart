import 'package:covid_tracker/WorldStats.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String image ;
  String name;
  var totalCases,totalDeaths,totalRecovers,active,critical,todayRecovered,test;
  DetailsScreen({Key? key,required this.name,required this.image,required this.totalCases,required this.totalDeaths,
  required this.totalRecovers,required this.active,required this.critical,required this.todayRecovered,required this.test
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(widget.name + ' Stats'),centerTitle: true,elevation: 0,backgroundColor: Colors.teal,),
      body: SafeArea(

        child:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(

                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 85),
                          child: DataBox(
                            image: 'images/cases.png',
                            color: Color(0xffABE9ED),
                            width: 320,
                            name: 'Confirmed \nCases',
                            data: widget.totalCases,
                          ),
                        ),
                          CircleAvatar(radius: 50,backgroundImage: NetworkImage(widget.image) ,)



                      ],  ),
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
                      data: widget.totalDeaths,
                    ),
                    DataBox(
                      image: 'images/recover.png',
                      color: Color(0xffBCE5BA),
                      name: 'Total \nRecovered',
                      data: widget.totalRecovers,
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
                      data: widget.active,
                    ),
                    DataBox(
                      image: 'images/critical.png',
                      color: Color(0xffF3D9BE),
                      name: 'Critical \nCases',
                      data: widget.critical,
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
                      image: 'images/recover.png',
                      color: Color(0xffFFB4B1).withOpacity(0.7),
                      name: 'Today \nRecovered',
                      data: widget.todayRecovered,
                    ),
                    DataBox(
                      image: 'images/critical.png',
                      color: Color(0xffBCE5BA).withOpacity(0.7),
                      name: 'Total \nTests',
                      data: widget.test,
                    ),
                  ],
                ),
              ),
          ],),
        ),
      ),
    );
  }
}
