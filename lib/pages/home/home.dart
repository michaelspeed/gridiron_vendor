import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/component/home/agreement.dart';
import 'package:vendor_flutter/component/home/orders.dart';
import 'package:vendor_flutter/component/home/products.dart';
import 'package:vendor_flutter/constants.dart';
import 'package:vendor_flutter/db/_databaseService.dart';
import 'package:vendor_flutter/db/entity/user.dart';
import 'package:vendor_flutter/gql/client_provider.dart';
import 'package:vendor_flutter/gql/query.dart';
import 'package:vendor_flutter/pages/settings/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final PageController controller = PageController(initialPage: 0);
  DatabaseService _databaseService = DatabaseService();
  User user;

  String token;


  @override
  void initState() {
    super.initState();
    _statup();
  }

  _statup() async {
    _databaseService.getToken()
        .then((value) {
          setState(() {
            token = value;
          });
    }).onError((error, stackTrace) {
      if (error != null) {
        Navigator.of(context).pushReplacementNamed("/");
      }
    });
    _databaseService.findOneUser()
    .then((value) {
      setState(() {
        user = value;
      });
    });
  }

  _updateUser(String storeId) async {
    User _user = User(user.id, user.token, storeId);
    _databaseService.updateUser(_user);
  }

  void _onItemTapped(int index) {
    controller.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token == null && user == null) {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Container(
      child: ClientProvider(
        uri: mainApi,
        token: token,
        child: Scaffold(
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
                          child: Query(
                            options: QueryOptions(
                              document: gql(vendorInfo),
                            ),
                            builder: (
                              QueryResult result,
                              { VoidCallback refetch, FetchMore fetchMore }
                            ) {
                              if (result.isLoading) {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (result.hasException) {
                                return Container(
                                  child: Center(
                                    child: Text(result.exception.toString()),
                                  ),
                                );
                              }
                              _updateUser(result.data["GetVendorInfo"]["store"]["id"]);
                              return Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text("Hello, ${result.data["GetVendorInfo"]["vendorName"]}", style: GoogleFonts.nunito(
                                              color: AppTheme.darkerText,
                                              fontSize: 40
                                          )),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Card(
                                        color: Colors.blueGrey.shade50,
                                        /*decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade50,
                                          borderRadius: BorderRadius.circular(12),
                                        ),*/
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
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("₹ ${result.data["GetVendorInfo"]["store"]["balance"]["balance"]}", style: GoogleFonts.nunito(
                                                      fontSize: 30, fontWeight: FontWeight.bold, color: AppTheme.primaryColor
                                                  )),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Text("Balance Volume", style: GoogleFonts.nunito()),
                                                        Text("₹ ${result.data["GetVendorInfo"]["store"]["balance"]["balanceVolume"]}", style: GoogleFonts.nunito()),
                                                      ],
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
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
                icon: Icon(AntDesign.dotchart),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.database),
                label: 'Stocks',
              ),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.cloudo),
                label: 'Billing Agreements',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
