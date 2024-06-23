import 'package:flutter/material.dart';
import 'package:map/const/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key});

   String phoneNumber="01030920974";
   TextEditingController textEditingController=TextEditingController();

    Widget biuldHightText(){
    return Column(
      children: [
        Text("What Is Your Pin Code",style: TextStyle(fontSize: 20,color: Colors.black),),
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text:TextSpan(
              text: "Enter Your Code Number sent to ",
              style: TextStyle(fontSize: 20,color: Colors.black),
              children: <TextSpan>[TextSpan(text: "$phoneNumber",style: TextStyle(fontSize: 20,color:Colors.redAccent))]
            )
          )
        )
      ],
    );
  }

   Widget biuldTextButton(){
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          minimumSize: Size(120, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          
        ),
        onPressed: (){},
         child: Text("Confirm",style: TextStyle(fontSize: 16,color: Colors.black),)),
         
    );
  }

  Widget biuldTextPinCode(BuildContext context){
    return Container(
      child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    obscuringWidget: const FlutterLogo(
                      size: 24,
                    ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      inactiveColor: MyColors.lightBlue,
                      inactiveFillColor: Colors.lightBlue,
                      selectedFillColor: Colors.white
                      
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                     
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:Container(
          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          child: ListView(
            children: [
               biuldHightText(),
               SizedBox(height: 80,),
               biuldTextPinCode(context),
               SizedBox(height: 60,),
               biuldTextButton()

          ],),
        ) ,
      ),
    );
  }
}