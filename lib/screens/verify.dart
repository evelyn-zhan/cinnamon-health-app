import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/providers/login_signup_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class Verify extends StatefulWidget {
  Verify({super.key, required this.email});

  String email;

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  TextEditingController pinC = TextEditingController();

  String? checkIsMatch() {
    if (pinC.text != "123456") {
      pinC.text = "";
      return "Code not Match";      
    }
    else {
      context.read<LoginSignupProvider>().addNewUser();
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          pinC.clear();
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20)),  
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Expanded(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            )
          ),
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("We have sent a verification code to ${widget.email}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),),
              SizedBox(height: 80,),
              Pinput(
                length: 6,
                showCursor: true,
                controller: pinC,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent
                  ),
                  textStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)
                ),
                validator: (value) => checkIsMatch(),
                errorTextStyle: TextStyle(
                  color: Colors.redAccent
                ),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive the code? ", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),),
                  GestureDetector(onTap: () {}, child: Text("Resend", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),))
                ],
              )
            ]
          ),
        ),
      )
    );
  }
}