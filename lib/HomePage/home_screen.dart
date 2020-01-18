import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AddProperty/MyProperties.dart';
import 'package:flutter_app/AddProperty/addProperty.dart';
import 'package:flutter_app/Chat/ChatPage.dart';
import 'package:flutter_app/Contract/contract_template_screen.dart';
import 'package:flutter_app/HomePage/apartment_carousel.dart';
import 'package:flutter_app/HomePage/office_carousel.dart';
import 'package:flutter_app/Payment/passcode_screen.dart';
import '../Payment/MyCardPage.dart';
import 'package:flutter_app/ListOfrequests.dart';

import '../AddProperty/propertyForm.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBEDEF),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              iconSize: 26,
              color: Color(0xFF354241),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF50A0A0),
                    Colors.white,
                  ],
                ),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 25,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          'images/assets/pp.jpg',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Rania Jamal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomListTile(Icons.person, 'Profile', () => {}),
            CustomListTile(
                Icons.home,
                'My Properties',
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListProperty()))
                    }),
            CustomListTile(
                Icons.person_add,
                'Requests',
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Listrequest()))
                    }),
            CustomListTile(
                Icons.library_books,
                'Contracts',
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TemplatePage()))
                    }),
            SizedBox(height: 70),
            CustomListTile(
                Icons.info,
                'About Us',
                () => {
                      showAboutDialog(
                          context: context,
                          applicationIcon: FlutterLogo(),
                          applicationName: 'AJAR',
                          applicationVersion: '0.1',
                          applicationLegalese:
                              'Deveoloped By AJAR Team Khattab, Rania and Marah ',
                          children: <Widget>[
                            Text(
                                "AJAR application is a platforms that offer properties realestate services offcharge to each individual asking for it.  "),
                            Text(
                                "Providing many servies to ensure a complete,safe experiecnce for both Landlords and Tenants  "),
                            Text(
                                "Allowing the landlords to monitor their properties and advertising them to an increasing number of audience "),
                            Text(
                                "Tenants will be able to rent a property, sign it's contract and pay the owner with a safe and legitmate process all through AJAR "),
                          ]),
                    }),
            CustomListTile(Icons.receipt, 'Terms & Conditions', () => {}),
            CustomListTile(Icons.lock, 'Log Out', () => {}),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 120.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                      text: 'What are you looking for?',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF354241),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: ('Search by area...'),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            ApartmentsCarousel(),
            SizedBox(height: 20.0),
            OfficeCarousel(),
          ],
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFB2DFDB),
        height: 50,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Color(0xFF354241),
          ),
          IconButton(
            icon: Icon(
              Icons.chat_bubble_outline,
              size: 30,
              color: Color(0xFF354241),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Color(0xFF354241),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (RequestForm())));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.payment,
              size: 30,
              color: Color(0xFF354241),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PassCodeScreen()));
            },
          ),
          Icon(
            Icons.insert_drive_file,
            size: 30,
            color: Color(0xFF354241),
          ),
        ],
        animationDuration: Duration(milliseconds: 250),
        onTap: (index) {
          setState(() {
            _page = index;
          });
          //Handle button tap
        },
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black26))),
        child: InkWell(
          splashColor: Color(0xFF354241),
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Icon(
                  (icon),
                  color: Color(0xFF354241),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF354241),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
