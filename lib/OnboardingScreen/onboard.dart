
import 'package:animate_do/animate_do.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/UI/loginscreen.dart';
import 'package:flutter/material.dart';
class GetstartedScreen extends StatefulWidget {
  const GetstartedScreen({super.key});

  @override
  _GetstartedScreenState createState() => _GetstartedScreenState();
}

class _GetstartedScreenState extends State<GetstartedScreen>{



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FadeInDownBig(
          duration:Duration(milliseconds: 2000) ,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/get.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.4),
                  ]
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Give Blood,Save Life", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),),
                    const SizedBox(height: 20,),
                    Text("Its A Simple Yet Profound Way", style: TextStyle(color: Colors.white, fontSize: 16),),
                       Text("To Make A Difference", style: TextStyle(color: Colors.white, fontSize: 16),),
                  const SizedBox(height: 60,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginScreen()));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child:Text("Get Started", style: TextStyle(fontWeight: FontWeight.w900,color: appColor),)
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),
                    // FadeInUp(duration: Duration(milliseconds: 1700), child: Container(
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.white),
                    //     borderRadius: BorderRadius.circular(50)
                    //   ),
                    //   child: Center(
                    //     child: Text("Create Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    //   ),
                    // )),
                    const SizedBox(height: 30,),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
