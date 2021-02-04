import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fashion_world/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fashion_world/models/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInformation extends StatefulWidget{
  UserInformation({Key key}):super(key: key);

  @override
  UserInformationState createState()=>new UserInformationState();
}
class UserInformationState extends State<UserInformation> {
  bool username_enabled=false,email_enabled=false,phone_no_enabled=false;
  FocusNode username_focus=new FocusNode();
  FocusNode _last_name_focus=new FocusNode();
  FocusNode _email_focus=new FocusNode();
  FocusNode _phone_number_focus=new FocusNode();
  SharedPreferences pref;
  TextEditingController last_name_controller;
  TextEditingController email_controller;
  TextEditingController phone_number_controller;
  TextEditingController username_controller;
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  final GlobalKey<FormState> _regissterFormKey=GlobalKey<FormState>();
  Validation validation=new Validation();

  @override
  void initState() {
    username_focus.addListener(() {
      setFirstNameEnabled();
    });

    _last_name_focus.addListener(() {
      setLastNameEnabled();
    });

    _email_focus.addListener(() {
      setEmailEnabled();
    });

    _phone_number_focus.addListener(() {
      setPhoneNoEnabled();
    });
    username_controller=new TextEditingController();
    last_name_controller=new TextEditingController();
    email_controller=new TextEditingController();
    phone_number_controller=new TextEditingController();
    initializePref();
    super.initState();
  }

  Future<void> initializePref() async{
    pref= await _prefs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(220, 153, 89, 0.1),
      child: GestureDetector(
        child: Hero(
          tag: 'personalInfoHero',
          child: SingleChildScrollView(
            child:  Column(
              children: [

                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *1/2,

                    child: Form(
                      key: _regissterFormKey,
                      child:  Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                            child: Row(
                              children: [
                                Text('Personal Information',style: TextStyle(color: Color.fromRGBO(214,24,195,1),fontWeight: FontWeight.w600,
                                    fontSize: 16,fontFamily: 'Open Sans'),)
                              ],
                            ),
                          ),
                          Divider(indent: 20,color: Colors.black12,),
                          Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),

                            child: TextFormField(
                              style: TextStyle(fontSize: 14.0),
                              autofocus: false,
                              controller: username_controller,
                              focusNode: username_focus,
                              validator: validation.nameValidator,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]|[\s@]"))
                              ],
                                keyboardType: TextInputType.text,
                              decoration: InputDecoration(hintText: 'Enter your Username',
                                suffixIcon: Padding(
                                  padding: EdgeInsetsDirectional.only(start: 0.0),
                                  child: Icon(Icons.person,
                                    color:username_enabled ? Color.fromRGBO(214,24,195,1):Colors.black54,),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                filled: true,
                                fillColor: Colors.transparent,
                                //  fillColor: Color.fromRGBO(220, 153, 89,0.1),
                                focusedBorder:new UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(214,24,195,1),
                                        //    width: 1.0,
                                        style: BorderStyle.solid
                                    )
                                ),
                                border: new UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54,
                                        //    width: 1.0,
                                        style: BorderStyle.solid
                                    )
                                ),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54,//Color.fromRGBO(214,24,195,1),
                                        //   width: 1.0,
                                        style: BorderStyle.solid
                                    )
                                ),
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                            child: Column(children: [
                              TextFormField(
                                style: TextStyle(fontSize: 14.0),
                                autofocus: false,
                                controller: email_controller,
                                focusNode: _email_focus,
                                validator: validation.emailValidator,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(hintText: 'Enter your email(Optional)',
                                  suffixIcon: Padding(
                                    padding: EdgeInsetsDirectional.only(start: 0.0),
                                    child: Icon(Icons.email,
                                      color:email_enabled ? Color.fromRGBO(214,24,195,1):Colors.black54,
                                    ),),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(214,24,195,1),
                                          //    width: 1.0,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  border: new UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54,
                                          //    width: 1.0,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54,//Color.fromRGBO(214,24,195,1),
                                          //   width: 1.0,
                                          style: BorderStyle.solid
                                      )
                                  ),

                                ),

                              ),
                            ],),

                          ),

                          Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                            child: Column(children: [
                              TextFormField(
                                style: TextStyle(fontSize: 14.0),
                                autofocus: false,
                                controller: phone_number_controller,
                                focusNode: _phone_number_focus,
                                keyboardType: TextInputType.phone,
                                validator: validation.phoneValidator,
                                decoration: InputDecoration(hintText: 'Enter your Mpesa Number',
                                  suffixIcon: Padding(
                                    padding: EdgeInsetsDirectional.only(start: 0.0),
                                    child: Icon(Icons.phone,
                                      color:phone_no_enabled ? Color.fromRGBO(214,24,195,1):Colors.black54,),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  focusedBorder:  new UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(214,24,195,1),
                                          //    width: 1.0,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  border: new UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54,
                                          //    width: 1.0,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54,//Color.fromRGBO(214,24,195,1),
                                          //   width: 1.0,
                                          style: BorderStyle.solid
                                      )
                                  ),

                                ),

                              ),
                            ],),

                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                            child: RaisedButton(
                              color: Color.fromRGBO(214,24,195,1),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              onPressed: (){
                                if(_regissterFormKey.currentState.validate()){
                                  setUserInformation(Provider.of<User>(context,listen: false));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('SAVE'),
                            ),
                          )
                        ],
                      ),
                    )

                  )
                  ,),
              ],
            ),
          )
        ),
      ),
    );
  }

  setFirstNameEnabled(){
   setState(() {
     username_enabled=true;
    // last_name_enabled=false;
     email_enabled=false;
     phone_no_enabled=false;
   });
  }

  setLastNameEnabled(){
   setState(() {
     username_enabled=false;
    // last_name_enabled=true;
     email_enabled=false;
     phone_no_enabled=false;
   });
  }

  setEmailEnabled(){
    setState(() {
      username_enabled=false;
     // username_enabled=false;
      email_enabled=true;
      phone_no_enabled=false;
    });
  }

  setPhoneNoEnabled(){
   setState(() {
     username_enabled=false;
  //   last_name_enabled=false;
     email_enabled=false;
     phone_no_enabled=true;
   });
  }

  setUserInformation(User user){
    user.username=username_controller.text;
    user.fname=username_controller.text;
    user.lname=username_controller.text;
    user.email=email_controller.text;
    user.phone=phone_number_controller.text;
    pref.setString('username',username_controller.text);
    pref.setString('email', email_controller.text);
    pref.setString('phone', phone_number_controller.text);
  }

}