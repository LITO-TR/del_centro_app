import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomerOptions extends StatefulWidget {
  const CustomerOptions({Key? key}) : super(key: key);

  @override
  State<CustomerOptions> createState() => _CustomerOptionsState();
}
// EN PROCESO PARA OBTIMIZAR CODIGO
// HACER UN BUTTON Q SELECCIONE SI EL CLIENTE ESTA REGISTRADO O ES NUEVO;
class _CustomerOptionsState extends State<CustomerOptions> {

    bool isRegistered = false;
   late Color iconEnabled;
  late Color iconDisabled;
    late Color buttonDisabled;
    late Color buttonEnabled;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    iconEnabled = Styles.scaffoldBackgroundColor;
    iconDisabled= Styles.blueDark;
    buttonEnabled = Styles.blueDark;
    buttonDisabled = Styles.scaffoldBackgroundColor;

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Styles.backgroundOrange,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    label: const Text(''),
                    onPressed: (){
                      setState(() {
                        iconDisabled = iconEnabled;
                        buttonDisabled = buttonEnabled;
                      });

                    },
                    icon: Icon(
                        Icons.person,
                        color:iconDisabled),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonDisabled,
                      padding:  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    )

                ),
                ElevatedButton.icon(
                    label: Text(''),
                    onPressed: (){
                      setState(() {

                        iconEnabled = iconDisabled;
                        buttonEnabled = buttonDisabled;


                      });

                      },
                    icon: Icon(Icons.radar,color: iconEnabled,),
                    style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled, padding:  const EdgeInsets.symmetric(horizontal: 24, vertical: 16), )

                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
