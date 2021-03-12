import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/component/list/list_item.dart';

class Agreements extends StatefulWidget {
  @override
  _AgreementsState createState() => _AgreementsState();
}

class _AgreementsState extends State<Agreements> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Agreements", style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                          )
                      ),
                    ],
                  ),
                ),
                ListItem(title: "Agreement 1", subtitle: "subtitle 1", id: "1")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
