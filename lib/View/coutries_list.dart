
import 'package:intl/intl.dart';
import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  var myFormat = NumberFormat('##,000');
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.teal,),
      body: SafeArea(child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            cursorColor: Colors.teal,
            cursorHeight: 20,
            controller: textController ,
         onChanged: (value){setState(() {

         });},
          decoration: InputDecoration(focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50),borderSide: BorderSide(color: Colors.teal)),hintText: 'Search by country',contentPadding: EdgeInsets.symmetric(horizontal: 20),border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
          ),
        ),
        Expanded(child: FutureBuilder(
          future: statsServices.countriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
            if(!snapshot.hasData){
              return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return Shimmer.fromColors(child: Column(children: [
                      ListTile(
                        subtitle: Container(height: 10,width: 89,color: Colors.white,),
                        title : Container(height: 10,width: 89,color: Colors.white,),
                        leading: Container(height: 50,width: 50,color: Colors.white,),

                            ),

                    ],),
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade100);

                  }


              );
            }else
            {
               return ListView.builder(
                   itemCount: snapshot.data!.length,
                   itemBuilder: (context, index){
                     String name =snapshot.data![index]['country'];
                     if (textController.text.isEmpty) {
                       return Column(children: [
                         InkWell(
                           onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                               name: snapshot.data![index]['country'],
                               image: snapshot.data![index]['countryInfo']['flag'],
                               totalCases: myFormat.format(snapshot.data![index]['cases']),
                               totalDeaths: myFormat.format(snapshot.data![index]['deaths']),
                               totalRecovers: myFormat.format(snapshot.data![index]['recovered']),
                               active: myFormat.format(snapshot.data![index]['active']),
                               critical: myFormat.format(snapshot.data![index]['critical']),
                               todayRecovered: myFormat.format(snapshot.data![index]['todayRecovered']),
                               test: myFormat.format(snapshot.data![index]['tests']))));
                             },
                           child: ListTile(
                               subtitle: Text(myFormat.format(snapshot.data![index]['cases'])) ,
                               title : Text(snapshot.data![index]['country']),
                               leading: Image( height : 50,width: 50,
                                   image: NetworkImage(snapshot.data![index]['countryInfo']['flag']))

                           ),
                         )
                       ],);
                     } else if (name.toLowerCase().contains(textController.text.toLowerCase())) {
                       return Column(children: [
                         InkWell(
                           onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                               name: snapshot.data![index]['country'],
                               image: snapshot.data![index]['countryInfo']['flag'],
                               totalCases: myFormat.format(snapshot.data![index]['cases']),
                               totalDeaths: myFormat.format(snapshot.data![index]['deaths']),
                               totalRecovers: myFormat.format(snapshot.data![index]['recovered']),
                               active: myFormat.format(snapshot.data![index]['active']),
                               critical: myFormat.format(snapshot.data![index]['critical']),
                               todayRecovered: myFormat.format(snapshot.data![index]['todayRecovered']),
                               test:myFormat.format(snapshot.data![index]['tests']))));},
                           child: ListTile(
                               subtitle: Text(myFormat.format(snapshot.data![index]['cases'])) ,
                               title : Text(snapshot.data![index]['country']),
                               leading: Image( height : 50,width: 50,
                                   image: NetworkImage(snapshot.data![index]['countryInfo']['flag']))

                           ),
                         )
                       ],);
                     } else {
                       return Container();
                     }

    }


            );
        }
        })
      ,
  ),
  ]),
    ));
  }
}
