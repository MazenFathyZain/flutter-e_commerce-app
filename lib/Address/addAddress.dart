import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Models/address.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {

final formKey = GlobalKey <FormState>();
final scaffoldKey = GlobalKey <ScaffoldState>();
final cName = TextEditingController();
final cPhoneNumber = TextEditingController();
final cFlatHomeNumber = TextEditingController();
final cCity = TextEditingController();
final cStreet = TextEditingController();
final cState = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: scaffoldKey,
      child: Scaffold(
        appBar: MyAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            if(formKey.currentState.validate()){
              final model = AddressModel(
                name: cName.text.trim(),
                street: cStreet.text.trim(),
                phoneNumber: cPhoneNumber.text,
                flatNumber: cFlatHomeNumber.text,
                state: cState.text,
                city: cCity.text.trim(),
              ).toJson();

              EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                  .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .document(DateTime.now().millisecondsSinceEpoch.toString())
                  .setData(model)
                  .then((value){
                    final snack = SnackBar(content: Text("New Address added successfully."));
                    // scaffoldKey.currentState.showSnackBar(snack);
                    FocusScope.of(context).requestFocus(FocusNode());
                    formKey.currentState.reset();
              });
              Route route = MaterialPageRoute(builder: (context) => Address());
              Navigator.pushReplacement(context, route);
            }
          },
          label: Text("Done"),
          backgroundColor: Colors.blue,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Add New Address",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                      hint: "Name",
                      controller: cName,
                    ),
                    MyTextField(
                      hint: "Phone Number",
                      controller: cPhoneNumber,
                    ),
                    MyTextField(
                      hint: "Flat Number / House Number",
                      controller: cFlatHomeNumber,
                    ),
                    MyTextField(
                      hint: "City",
                      controller: cCity,
                    ),
                    MyTextField(
                      hint: "Street",
                      controller: cStreet,
                    ),
                    MyTextField(
                      hint: "State",
                      controller: cState,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  MyTextField({Key key, this.controller,this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val) => val.isEmpty ? "Field can'\t be empty." : null,
      ),
    );
  }
}
