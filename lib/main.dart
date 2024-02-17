import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projecthack/Authentication/registerUsingEmail.dart';
import 'package:projecthack/Sections/Dashboard/dashboard.dart';
import 'package:projecthack/Sections/UpiParser/upiParserScreen.dart';

import 'Authentication/loginPage.dart';
import 'Sections/Porfile/profilePage.dart';
import 'Sections/Stats/stats1.dart';
import 'Sections/addExpense/addExpUi.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LandingPage(),
  ));
}


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  bool registerPage=true;
  bool loginPage = true;
  void switchBetweenRegisterLogin(){
    
  }
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    DashboardUi(),
    UpiScreenParser(),
    Statistics(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex<=1?FloatingActionButton(


      backgroundColor: Colors.black,onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpenseScreen(),));
      },child:_selectedIndex==1?Icon(Icons.chat,color: Colors.white,):_selectedIndex==0?Icon(Icons.add,color: Colors.white,):null,):null,
      bottomNavigationBar: BottomNavigationBar(



      fixedColor: Colors.black,

      onTap: _onItemTapped,currentIndex: _selectedIndex,items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,color: Colors.black,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera,color: Colors.black),
          label: 'Pay',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph_sharp,color: Colors.black),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,color: Colors.black),
          label: 'Profile',
        ),
      ])
      ,body: _pages.elementAt(_selectedIndex),
      // ,body: SafeArea(child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Center(child: Text("Welcome to the homePage")),
      //    SizedBox(height: 10,),
      //    ElevatedButton(onPressed: (){
      //        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardUi(),));
      //    }, child: Text("Dashboard")),
      //    Container(
      //      child: Row(
      //        // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //        mainAxisAlignment: MainAxisAlignment.center,
      //        children: [
      //          ElevatedButton(onPressed: (){
      //            Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardUi(),));
      //          }, child: Text("Register")),
      //          SizedBox(width: 20,),
      //          ElevatedButton(onPressed: (){
      //            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      //          }, child: Text("Login Page"),),
      //        ],
      //      ),
      //    )
      //
      //   ],
      // )),
    );
  }
}
