import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/pages/orderLine/order_line.dart';

class ListItem extends StatefulWidget {
  String title;
  String subtitle;
  String id;
  dynamic data;

  ListItem({Key key, this.title, this.subtitle, this.id, this.data}): super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderLinePage(id: widget.id)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkerText
                  )),
                  Text("${widget.subtitle} - ${widget.data["stage"]}", style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.normal, color: AppTheme.darkerText
                  )),
                ],
              ),
              trailing: Icon(FontAwesome5.arrow_alt_circle_right, color: AppTheme.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
