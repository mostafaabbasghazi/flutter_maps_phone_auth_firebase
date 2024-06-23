import 'package:flutter/material.dart';
import 'package:map/const/colors.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

   GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  TextEditingController phoneNumber=TextEditingController();
  Widget biuldHightText(){
    return Column(
      children: [
        Text("What Is Your Phone Number",style: TextStyle(fontSize: 20,color: Colors.black),),
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Text("What Is Your Number",style: TextStyle(fontSize: 18,color: Colors.black)),
        )
      ],
    );
  }

  Widget biuldPhoneForm(){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5EFFD)),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(biuldFlage()+" +20",style: TextStyle(fontSize: 20,letterSpacing: 2)),
          )),
          SizedBox(width: 16,),
          Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.lightBlue),
              borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              key: globalKey,
              autofocus: true,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                
              ),
              cursorColor:Colors.black,
              keyboardType: TextInputType.number,
              validator: (value) {
                if(value!.isEmpty){
                  return "please enter your number";
                }if (value.length < 11) {
                  return "please enter 11 number";
                } 
                return null;
              },
              onSaved: (newValue) {
                phoneNumber.value=newValue.toString() as TextEditingValue;
              },
            )
          )),
      ],
    );
  }

  String biuldFlage(){
    String countryCode="eg";
    String flage=countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), (replace)=>String.fromCharCode(replace.group(0)!.codeUnitAt(0) +127397));
    return flage;
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
         child: Text("Next",style: TextStyle(fontSize: 16,color: Colors.black),)),
         
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: UniqueKey(),
          child:Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                biuldHightText(),
                SizedBox(height: 130,),
                biuldPhoneForm(),
                biuldTextButton()
              ],
            ),
          )),
      ),
    );
  }
}