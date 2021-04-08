import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/constants.dart';
import 'package:vendor_flutter/db/_databaseService.dart';
import 'package:vendor_flutter/gql/client_provider.dart';
import 'package:vendor_flutter/gql/query.dart';

class OrderLinePage extends StatefulWidget {
  String id;

  OrderLinePage({Key key, this.id}): super(key: key);

  @override
  _OrderLineState createState() => _OrderLineState();
}

class _OrderLineState extends State<OrderLinePage> {
  DatabaseService _databaseService = DatabaseService();
  String token;

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return ClientProvider(child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: widget.id != null ? Container(
              child: Query(
                options: QueryOptions(
                    document: gql(getSingleOrderLine),
                    variables: {
                      "id": widget.id
                    },
                    pollInterval: Duration(seconds: 2)
                ),
                builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
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
                  print(result.data);
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order from", style: GoogleFonts.nunito(fontSize: 20, color: AppTheme.primaryColor)),
                        Row(
                          children: [
                            Flexible(
                              child: Text("${result.data["orderLine"]["order"]["user"]["firstName"]} ${result.data["orderLine"]["order"]["user"]["lastName"]}", style: GoogleFonts.nunito(
                                  color: AppTheme.darkerText,
                                  fontSize: 40
                              )),
                            )
                          ],
                        ),
                        Text(result.data["orderLine"]["order"]["user"]["phoneNumber"], style: GoogleFonts.nunito(fontSize: 15, color: Colors.blueGrey.shade400)),
                        Divider(height: 10, thickness: 1, color: Colors.blueGrey.shade100),
                        Container(
                          decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade50,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(result.data["orderLine"]["order"]["address"], style: GoogleFonts.nunito(fontSize: 15, color: Colors.blueGrey.shade800)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(result.data["orderLine"]["stage"], style: GoogleFonts.nunito(fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ) : Container(child: Center(child: CircularProgressIndicator(),),),
          ),
        )
    ), uri: mainApi, token: token);
  }

  @override
  void initState() {
    super.initState();
    _startup();
  }

  _startup() async {
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
  }
}
