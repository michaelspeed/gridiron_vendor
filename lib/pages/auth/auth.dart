import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/constants.dart';
import 'package:vendor_flutter/db/_databaseService.dart';
import 'package:vendor_flutter/db/entity/user.dart';
import 'package:vendor_flutter/gql/client_provider.dart';
import 'package:vendor_flutter/gql/mutations.dart';
import 'package:vendor_flutter/gql/query.dart';
import 'package:vendor_flutter/pages/home/home.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: ClientProvider(
        uri: mainApi,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Query(
                    options: QueryOptions(
                      document: gql(defaultStore),
                      pollInterval: Duration(seconds: 10),
                    ),
                    builder: (
                        QueryResult result,
                        { VoidCallback refetch, FetchMore fetchMore }
                        ) {
                      if (result.hasException) {
                        return Container(child: Text(result.exception.toString()));
                      }
                      if (result.isLoading) {
                        return Container(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        child: Column(
                          children: [
                            Container(child: result.data['GetDefaultStore']['logo'] != null ? Image.network("${assetURL}${result.data['GetDefaultStore']['logo']['source']}", height: 100,width: 100): Container()),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(child: Text("Welcome to", style: GoogleFonts.poppins(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold)))
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(child: Text("${result.data['GetDefaultStore']['storeName']}", style: GoogleFonts.poppins(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold)))
                                ]
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: TextField(
                        controller: _emailController,
                        style: GoogleFonts.poppins(),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: GoogleFonts.poppins(color: Colors.white),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.nearlyWhite, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.nearlyWhite, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: TextField(
                        style: GoogleFonts.poppins(),
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: GoogleFonts.poppins(color: Colors.white),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.nearlyWhite, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.nearlyWhite, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Mutation(
                      options: MutationOptions(
                        document: gql(login),
                        onCompleted: (dynamic resultData) async {
                          if (resultData != null) {
                            print(resultData);
                            User user = User(resultData['administratorLogin']['user']['id'], resultData['administratorLogin']['token'], null);
                            await _databaseService.saveLogin(user);
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                          }
                        }
                      ),
                      builder: (
                          RunMutation runMutation,
                          QueryResult queryResult
                          ){
                        /*if (queryResult.hasException) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(queryResult.exception.toString())));
                          return Container(
                            child: ElevatedButton(
                              child: Text("Login", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                              onPressed: () {
                                runMutation({
                                  'email': _emailController.text,
                                  'password': _passwordController.text
                                });
                                //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                              },
                            ),
                          );
                        }*/
                        if (queryResult.isLoading) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Container(
                          child: ElevatedButton(
                            child: Text("Login", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              runMutation({
                                'email': _emailController.text,
                                'password': _passwordController.text
                              });
                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                            },
                          ),
                        );
                      }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
