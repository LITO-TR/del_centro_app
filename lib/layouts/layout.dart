import 'package:del_centro_app/components/avatar.dart';
import 'package:del_centro_app/pages/customers_page.dart';
import 'package:del_centro_app/src/features/credit/credit_page.dart';
import 'package:del_centro_app/src/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    CreditPage(),
    Text(
      'Index 3: Settings',
    ),
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
              selectedIndex: _selectedIndex,
              groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: labelType,
              leading: Avatar(),
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.credit_card),
                  selectedIcon: Icon(Icons.credit_card),
                  label: Text('Credito'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Third'),
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
