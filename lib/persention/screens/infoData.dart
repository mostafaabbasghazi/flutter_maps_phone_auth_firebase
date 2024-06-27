


import 'dart:io';
import 'package:map/const/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map/bussnis_logic/auth/cubit/authphone_cubit.dart';

class InfoData extends StatelessWidget {
  
  InfoData({super.key});

 
  @override
  Widget build(BuildContext context) {
   
    
      return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login",style: TextStyle(fontSize: 30),),),
      //backgroundColor: Color(0xf2f2f2f2),
      body: BlocBuilder<PhoneAuthCubit,PhoneAuthState>(
        builder:(context,state){
        
          return  Container(
        child: ListView(children: [
          if(state is SelectedImage)
          
           CircleAvatar(
            radius: 100,
            backgroundColor: Colors.grey,
            backgroundImage:   (state).file != null
                ? FileImage((state).file as File)
                : null,
          ),
          TextButton.icon(
            onPressed: (){
              BlocProvider.of<PhoneAuthCubit>(context).selectImage();
            },
            icon: const Icon(Icons.image),
            label: const Text('Add Image'),),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key:  BlocProvider.of<PhoneAuthCubit>(context).globalKey,
              child: Column(children: [
             
              SizedBox(height: 20,),
              TextFormField(
              validator: (value) {
                if(value!.isEmpty && value!.length <5){
                  return "Email is Empty or length less than 5";
                }
              },
              controller: BlocProvider.of<PhoneAuthCubit>(context).userName,
              keyboardType: TextInputType.text,
              
              decoration: InputDecoration(
               hintText: "Enter Your UserName",
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text("UserName")),
            
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                
              ),
            SizedBox(height: 20,),
            
             InkWell(
              onTap: (){
                BlocProvider.of<PhoneAuthCubit>(context).SendUserData();
               
                Navigator.of(context).pushReplacementNamed(home);
                
              },
              child:Container(
              padding: EdgeInsets.all(6),
              width: MediaQuery.of(context).size.width,
              //margin: EdgeInsets.only(left: 40,right: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.redAccent
              ),
              child: Center(
                child: Text("Confirm",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),)
            ),
            )
          ],)),)
        ],),
      );
        } ,)
    );
    }
  }
