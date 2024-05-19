import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maristcommerce/BottomNavBar/custom_scaffold.dart';
import 'package:maristcommerce/BottomNavBar/list_option.dart';
import 'package:maristcommerce/screens_auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maristcommerce/screen_pages/home_screen.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String? _displayName;
  String? _email;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayName = prefs.getString('displayName');
      _email = prefs.getString('email');
      _photoUrl = prefs.getString('photoUrl');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.green[700]),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    _photoUrl != null && _photoUrl!.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(_photoUrl!),
                            radius: 30,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Icon(Icons.person,
                                size: 30, color: Colors.green[700]),
                          ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayName ?? 'User Name',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _email ?? 'user@example.com',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              'images/m3.jpg',
              height: 150,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'My Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ListOfOption(
              icon: Icon(Icons.person_2_outlined, color: Colors.green),
              title: 'Home',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListOfOption(
              icon: Icon(Icons.location_city_outlined, color: Colors.green),
              title: 'Address',
              onTap: () {},
            ),
            ListOfOption(
              icon: Icon(Icons.payment_outlined, color: Colors.green),
              title: 'Payment',
              onTap: () {},
            ),
            ListOfOption(
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.green),
              title: 'Orders',
              onTap: () {},
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ListOfOption(
              icon: Icon(Icons.language_outlined, color: Colors.green),
              title: 'Language',
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Sign Out'),
              trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
              onTap: () async {
                await GoogleSignIn().signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      showBottomNavBar: true,
      initalIndex: 3,
    );
  }
}
