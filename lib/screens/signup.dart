import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/providers/login_signup_provider.dart';
import 'package:health_mobile_app/screens/verify.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
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
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign up", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20,),
                  TextField(
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      errorText: (context.watch<LoginSignupProvider>().newEmailErrorText == "" ? null : context.watch<LoginSignupProvider>().newEmailErrorText),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                    ),
                    controller: context.watch<LoginSignupProvider>().newEmailC,
                    
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      errorText: (context.watch<LoginSignupProvider>().newUsernameErrorText == "" ? null : context.watch<LoginSignupProvider>().newUsernameErrorText),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                    ),
                    controller: context.watch<LoginSignupProvider>().newUsernameC,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    style: GoogleFonts.poppins(),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      errorText: (context.watch<LoginSignupProvider>().newPasswordErrorText == "" ? null : context.watch<LoginSignupProvider>().newPasswordErrorText),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                    ),
                    controller: context.watch<LoginSignupProvider>().newPasswordC,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    style: GoogleFonts.poppins(),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      errorText: (context.watch<LoginSignupProvider>().confirmNewPasswordErrorText == "" ? null : context.watch<LoginSignupProvider>().confirmNewPasswordErrorText),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1E1E1E))
                      ),
                    ),
                    controller: context.watch<LoginSignupProvider>().confirmNewPasswordC,
                  ),
                  SizedBox(height: 30,),
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
                      onPressed: ()  {
                        context.read<LoginSignupProvider>().signup();
                        if (context.read<LoginSignupProvider>().isSignupValid) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(email: context.watch<LoginSignupProvider>().newEmailC.text)));
                        }
                      },
                      child: Text("Sign up", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                    )
                  ),  
                  SizedBox(height: 30,),  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account? ", style: GoogleFonts.poppins(color: Colors.grey)),
                      GestureDetector(
                        onTap: () {
                          context.read<LoginSignupProvider>().clearController();
                          Navigator.pop(context);
                        },
                        child: Text("Log in", style: GoogleFonts.poppins(color: Color(0xFF1E1E1E), fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
                      )
                    ],
                  )  
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}