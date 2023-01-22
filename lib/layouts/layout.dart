import 'package:del_centro_app/src/features/shared/widgets/avatar.dart';
import 'package:del_centro_app/src/features/credit/credit_page.dart';
import 'package:del_centro_app/src/features/customers/customer_page.dart';
import 'package:del_centro_app/src/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:del_centro_app/src/styles/styles.dart';
class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    CreditPage(),
    CustomerPage()
  ];
    int _selectedIndex = 0;
    NavigationRailLabelType labelType = NavigationRailLabelType.selected;
    double groupAlignment = 0.0;
    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: Row(
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
              leading: Avatar(),
              destinations:  <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard',style: TextStyle(color: Styles.backgroundOrange),),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.credit_card),
                  selectedIcon: Icon(Icons.credit_card),
                  label: Text('Credito',style: TextStyle(color: Styles.backgroundOrange),),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Clientes',style: TextStyle(color: Styles.backgroundOrange),),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(child: _widgetOptions.elementAt(_selectedIndex)),

          ],
        ),
      );
    }
  }
