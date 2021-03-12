import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/component/home/agreement.dart';
import 'package:vendor_flutter/component/home/orders.dart';
import 'package:vendor_flutter/component/home/products.dart';
import 'package:vendor_flutter/pages/settings/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final PageController controller = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    controller.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                child: _selectedIndex == 0 ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dashboard", style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                          Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: Icon(FontAwesome5.user_circle, color: AppTheme.primaryColor),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Settings()));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Container(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text("Hello, Michael Speed", style: GoogleFonts.nunito(
                                  color: AppTheme.darkerText,
                                  fontSize: 50
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(FontAwesome5.money_bill_alt, color: AppTheme.primaryColor),
                                title: Text("Account Balance", style: GoogleFonts.nunito(
                                    fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkerText
                                ))
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("₹ 0", style: GoogleFonts.nunito(
                                      fontSize: 30, fontWeight: FontWeight.bold, color: AppTheme.primaryColor
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ) : Container(),
              ),
              Container(
                child: Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    children:  <Widget>[
                      Orders(),
                      Products(),
                      Agreements()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.primaryColor,
        selectedItemColor: AppTheme.white,
        unselectedItemColor: AppTheme.lightText,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.area_chart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.database),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.paragraph),
            label: 'Billing Agreements',
          ),
        ],
      ),
    );
  }
}
