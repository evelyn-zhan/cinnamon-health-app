import 'package:flutter/material.dart';
import 'package:health_mobile_app/providers/login_signup_provider.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';
import 'package:health_mobile_app/screens/index.dart';
import 'package:health_mobile_app/screens/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Future <void> toHome() async {
    if (context.read<LoginSignupProvider>().isLoginValid) {
      context.read<ProfileProvider>().setInfo(
        context.read<LoginSignupProvider>().usernameC.text, 
        context.read<LoginSignupProvider>().passwordC.text,
        context.read<LoginSignupProvider>().email,
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 100,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      errorText: (context.watch<LoginSignupProvider>().usernameErrorText == "" ? null : context.watch<LoginSignupProvider>().usernameErrorText),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                    ),
                    controller: context.watch<LoginSignupProvider>().usernameC,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    style: GoogleFonts.poppins(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      errorText: (context.watch<LoginSignupProvider>().passwordErrorText == "" ? null : context.watch<LoginSignupProvider>().passwordErrorText),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                    ),
                    controller: context.watch<LoginSignupProvider>().passwordC,
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E1E1E),
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                      ),
                      onPressed: () {
                        context.read<LoginSignupProvider>().login();
                        toHome();
                      }, 
                      child: Text("Login", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                    )
                  ),  
                  SizedBox(height: 30,),  
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: GoogleFonts.poppins(color: Colors.grey)),
                        GestureDetector(
                          onTap: () {
                            context.read<LoginSignupProvider>().clearController();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                          },
                          child: Text("Sign up", style: GoogleFonts.poppins(color: Color(0xFF1E1E1E), fontWeight: FontWeight.w600, decoration: TextDecoration.underline))
                        )
                      ],
                    )
                  ),   
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}