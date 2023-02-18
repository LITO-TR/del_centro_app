import 'package:del_centro_app/src/features/balance/balance_page.dart';
import 'package:del_centro_app/src/features/shared/widgets/avatar.dart';
import 'package:del_centro_app/src/features/credits/credit_page.dart';
import 'package:del_centro_app/src/features/customers/customer_page.dart';
import 'package:flutter/material.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import '../src/features/payments/payments_page.dart';
class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    CreditPage(),
    CustomerPage(),
    BalancePage(),
  ];
    int _selectedIndex = 0;
    NavigationRailLabelType labelType = NavigationRailLabelType.selected;
    double groupAlignment = 0.0;
    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: SafeArea(
          child: Row(
            children:[
              NavigationRail(
                selectedIconTheme: IconThemeData(color: Styles.backgroundOrange),
                backgroundColor: Styles.blueDark,
                selectedIndex: _selectedIndex,
                groupAlignment: groupAlignment,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: labelType,
                leading: const Avatar(),
                destinations:  <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: const Icon(Icons.monetization_on),
                    selectedIcon: const Icon(Icons.monetization_on),
                    label: Text('Cobrar',style: TextStyle(color: Styles.backgroundOrange),),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.credit_card),
                    selectedIcon: const Icon(Icons.credit_card),
                    label: Text('Credito',style: TextStyle(color: Styles.backgroundOrange),),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.person_outline),
                    selectedIcon: const Icon(Icons.person),
                    label: Text('Clientes',style: TextStyle(color: Styles.backgroundOrange),),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.balance_outlined),
                    selectedIcon: const Icon(Icons.balance),
                    label: Text('Cuadrar',style: TextStyle(color: Styles.backgroundOrange),),
                  ),

                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
                  Expanded(
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        children: [
                          _widgetOptions.elementAt(_selectedIndex),
                        ],
                      )
                  ),
            ],
          ),
        ),
      );
    }
  }
