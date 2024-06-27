import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map/main.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authphone_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;
  int? _resendToken;
  bool isOnline=false;
  List idGroup=[];
  

  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  File? file;
  TextEditingController userName=TextEditingController();

  bool userExist=false;
  String phone="";

  

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
   phone=phoneNumber;
    emit(Loading());

       await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      forceResendingToken: _resendToken,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
    }
   
    
   
  

  void verificationCompleted(PhoneAuthCredential credential) async {
    
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
  }
 

  void codeSent(String verificationId, int? resendToken) {
    print('codeSent');
    this.verificationId = verificationId;
    this._resendToken=resendToken;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try { 
          var collectionReference=await FirebaseFirestore.instance.collection("users");
    await collectionReference.get().then((onValue){
      onValue.docs.forEach((action){
       if(action.data()['userPhone']=="+2$phone"){
        userExist=true;
       }
      
      });
    });
    if(userExist ==true){
    await FirebaseAuth.instance.signInWithCredential(credential);
    emit(UserExist());
   
    }else{
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());}
    } catch (error) {
      emit(ErrorOccurred(errorMsg: "Try Again Letter"));
    }
  }
  Future<void> signInUserExist(PhoneAuthCredential credential) async {
    try { 
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccurred(errorMsg: "Try Again Letter"));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

  Future<void>selectImage()async{
    XFile? xFile=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xFile !=null){
      file=File(xFile.path);
      emit(SelectedImage(file: File(xFile.path)));
    }
  }

  void SendUserData()async{
    
   try {
    var collectionReference=await FirebaseFirestore.instance.collection("users");
   
    var id=Random().nextInt(1000000);
    var nameFile=basename(file!.path);
    Reference reference=await FirebaseStorage.instance.ref().child("usersImage").child("${id.toString()+nameFile}");
    UploadTask uploadTask=reference.putFile(File(file!.path));
    final downloadUrl=await(await uploadTask).ref.getDownloadURL();


    
    
     await collectionReference.add({
      "userPhone":FirebaseAuth.instance.currentUser!.phoneNumber,
      "userId":FirebaseAuth.instance.currentUser!.uid,
      "userNAme":userName.text,
      "userImage":downloadUrl,
      "isOnline":isOnline,
      "idGroup":idGroup
     });
     sharedPreferences.setString("phoneNumber",FirebaseAuth.instance.currentUser!.phoneNumber.toString());
     emit(UserDataUploaded());
   
    
   
    

   } catch (e) {
     emit(ErrorOccurred(errorMsg: e.toString()));
   }
}}