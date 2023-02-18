import 'package:del_centro_app/src/features/balance/balance_page.dart';
import 'package:del_centro_app/src/features/balance/screens/day_detail.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

class MonthDetail extends StatelessWidget {
  const MonthDetail({Key? key, required this.objMonth}) : super(key: key);
  final MONTHS objMonth;

  @override
  Widget build(BuildContext context) {
    final  date = DateTime.now();

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text(objMonth.name),),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 110,
                crossAxisCount: 7,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1,
              ),
              itemCount: objMonth.numberOfDays,
              itemBuilder: (BuildContext context, int index) {
                Color backgroundColor = Colors.transparent;
                if(date.day.toString() == (index+1).toString() && date.month.toString() == objMonth.id.toString() ){
                  backgroundColor = Colors.green;
                }
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                           builder: (context) => DayDetail(objMonth: objMonth, day: index+1)));
                  },
                  child: Container(

                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Styles.blueDark),

                      ),
                      child: Column(

                        children: [
                            Align(alignment: AlignmentDirectional.topEnd ,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text((index+1).toString(),style:  TextStyle(fontSize: 25,color: Styles.backgroundOrange),),
                                )),
                        ],
                      )),
                );
              },



            ),
      ),
    );
  }
}
