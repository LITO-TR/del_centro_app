
import 'package:del_centro_app/src/features/balance/screens/month_detail.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';


const List<String> namesMonths = [
  "ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"
];
class MONTHS{
  MONTHS(this.id, this.name,this.year){
    _numbersOfDaysByMonth();
  }
  final int id;
  final String name;
  final String year;

  int _numberOfDays = 0;

  int get numberOfDays => _numberOfDays;
  set numberOfDays (value){
    _numberOfDays = value;
  }

   _numbersOfDaysByMonth(){
    if(name =='ABRIL'|| name == 'JUNIO' || name == 'SEPTIEMBRE' || name == 'NOVIEMBRE'){
      numberOfDays = 30;
    }
    else if(name == 'FEBRERO'){
      numberOfDays = 28;
    }
    else {
      numberOfDays = 31;
    }
  }
}

class BalancePage extends StatelessWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  date = DateTime.now();
    return ListView(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('ARQUEO (${date.year})',style: TextStyle( fontSize: 20,color: Styles.blueDark,fontWeight: FontWeight.bold),),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.9,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 140,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      final objMonth = MONTHS(index+1, namesMonths[index],date.year.toString());
                      Color color = Styles.blueDark;
                      if(date.month.toString() == objMonth.id.toString()){
                        color = Styles.backgroundOrange;
                      }
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MonthDetail(objMonth: objMonth,)));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text(objMonth.name,style: const TextStyle(fontSize: 25,color: Colors.white)))),
                      );
                    },

                  ),
                )
              ],
            )
        ),
      ],
    );
  }
}
