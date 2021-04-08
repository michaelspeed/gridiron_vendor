import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/component/list/list_item.dart';
import 'package:vendor_flutter/db/_databaseService.dart';
import 'package:vendor_flutter/gql/query.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String storeId;
  DatabaseService _databaseService = DatabaseService();
  int start = 10;
  int offset = 0;
  final f = new DateFormat('dd-MM-yyyy');


  @override
  void initState() {
    super.initState();
    _startup();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: storeId != null ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            elevation: 3,
            color: Colors.blueGrey.shade50,
            /*decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),*/
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(label: Text("Orders", style: GoogleFonts.poppins(color: Colors.white)), backgroundColor: AppTheme.primaryColor),
                    ],
                  ),
                ),
                Container(
                  child: Query(
                    options: QueryOptions(
                      document: gql(getOrderLines),
                      variables: {
                        "id": this.storeId,
                        "limit": this.start,
                        "offset": this.offset
                      },
                      pollInterval: Duration(seconds: 2)
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
                        if (storeId == null) {
                          return Container();
                        }
                        return Container(
                          child: ListView.builder(
                            itemCount: result.data["orderLines"].length,
                            shrinkWrap: true,
                              itemBuilder: (BuildContext context, int position) {
                                return ListItem(title: result.data["orderLines"][position]["order"]["user"]["firstName"], subtitle: f.format(DateTime.parse(result.data["orderLines"][position]["createdAt"])), id: result.data["orderLines"][position]["id"], data: result.data["orderLines"][position],);
                              }),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ) : Container(),
    );
  }

  _startup() async {
    final user = await _databaseService.findOneUser();
    setState(() {
      storeId = user.store;
    });
  }
}
