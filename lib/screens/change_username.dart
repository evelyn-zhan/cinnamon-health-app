import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/components/change_user_info_field.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20)
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Edit Username", style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700)),
              SizedBox(height: 15),
              ChangeUserInfoField(
                inputType: "username",
                inputTitle: "New username",
                controller: context.watch<ProfileProvider>().usernameC,
                errorMessage: context.watch<ProfileProvider>().usernameErrorMessage
              ),
              SizedBox(height: 15),
              ChangeUserInfoField(
                inputType: "password",
                inputTitle: "Current password",
                controller: context.watch<ProfileProvider>().passwordC,
                errorMessage: context.watch<ProfileProvider>().passwordErrorMessage
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  onPressed: () { 
                    context.read<ProfileProvider>().confirmCurrentPassword(); 
                    context.read<ProfileProvider>().checkUsernameValidity();
                    bool isChanged = context.read<ProfileProvider>().changeUsername();
                    if (isChanged) {
                      Navigator.pop(context);
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E1E1E),
                    padding: EdgeInsets.fromLTRB(16, 15, 18, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  child: Text("Change", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600))
                )
              )
            ]
          )
        )
      )
    );
  }
}