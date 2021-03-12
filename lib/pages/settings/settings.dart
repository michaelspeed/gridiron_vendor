import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor_flutter/app_theme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Icon(FontAwesome.arrow_left, color: AppTheme.primaryColor),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Settings", style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
