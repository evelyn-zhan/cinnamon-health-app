import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';
import 'package:health_mobile_app/screens/change_password.dart';
import 'package:health_mobile_app/screens/change_username.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50, height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                              SizedBox(height: 16),
                              Container(width: double.infinity, height: 1.5, color: Color(0xFFC8C8C8)),
                              SizedBox(height: 16),
                              ExpansionTile(
                                shape: Border(),
                                backgroundColor: Theme.of(context).canvasColor,
                                title: Row(
                                  children: [
                                    Icon(Icons.account_circle_outlined, color: Theme.of(context).iconTheme.color),
                                    SizedBox(width: 8),
                                    Text("Account Information", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600))
                                  ]
                                ),
                                children: [
                                  ListTile(
                                    title: Text("Username", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                                    subtitle: Text(context.watch<ProfileProvider>().username, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13)),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeUsername()));
                                      },
                                      child: Text("Edit username", style: GoogleFonts.poppins(fontSize: 12))
                                    )
                                  ),
                                  ListTile(
                                    title: Text("E-mail", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                                    subtitle: Text(context.watch<ProfileProvider>().email, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13))
                                  ),
                                  ListTile(
                                    title: Text("Password", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                                    subtitle: Row(
                                      children: List.generate(10, (index) {
                                        return Container(width: 8, height: 8, 
                                          margin: EdgeInsets.fromLTRB(0, 5, 3, 5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(8)
                                          )
                                        );
                                      })
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                                      },
                                      child: Text("Change password", style: GoogleFonts.poppins(fontSize: 12))
                                    )
                                  )
                                ]
                              ),
                              ListTile(
                                leading: Icon(Icons.dark_mode_rounded, size: 20),
                                title: Text("Dark Mode", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                                trailing: Switch(
                                  activeColor: Color(0xFF0369A1),
                                  value: context.watch<ProfileProvider>().isDark,
                                  onChanged: (bool value) => context.read<ProfileProvider>().switchMode(value),
                                )
                              ),
                              ListTile(
                                leading: Icon(Icons.notifications_rounded, size: 20),
                                title: Text("Enable Notification", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                                trailing: Switch(
                                  activeColor: Color(0xFF0369A1),
                                  value: context.watch<ProfileProvider>().isNotificationOn,
                                  onChanged: (bool value) => context.read<ProfileProvider>().switchNotification(value),
                                )
                              )
                            ]
                          )
                        )
                      )
                    )
                  )
                ]
              )
            )
          )
        ]
    );
  }
}