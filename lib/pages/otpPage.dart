import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Otppage extends StatefulWidget {
  final number_Phone;
  @override
  final int hashCode ;

  const  Otppage({super.key, required this.number_Phone, required this.hashCode});
  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
 
  getback() {
    Navigator.of(context).pop();
  }
  

  @override
  Widget build(BuildContext context) {




    //final Size screenSize = MediaQuery.of(context).size;
    //final double maxContentWidth = 600.0;


    //otpcode input field
    final defaultPinTheme = PinTheme( 
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );


    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: getback, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(widget.number_Phone),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text(
                "please enter the otp sent to your phone number it must be 6 digits",
              ),
              SizedBox(height: 20),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                onChanged: (value) {
                
                },
                onCompleted: (value){
                  //validate otp here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
