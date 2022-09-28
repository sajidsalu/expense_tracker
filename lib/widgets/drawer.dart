import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/modules/expense/list/expense_list.dart';
import 'package:expense_tracker/modules/login/login.dart';
import 'package:expense_tracker/services/Utils/authentication.dart';
import 'package:expense_tracker/services/data_manager.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  // String username = DataManager.instance.username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Image.asset("assets/images/user-avatar.png",height: 50,width: 50,),
                SizedBox(height: 10,),
                Text("Sajid", style: TextStyle(fontSize: 24,color: Colors.white),),
              ],
            ),
          ),
          ListTile(
            title: const Text('All Transactions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> ExpenseListingScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: ()async {
              // Update the state of the app
              // ...
              // Then close the drawer
              await Authentication.signOut(context: context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
