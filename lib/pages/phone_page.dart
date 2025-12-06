import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../services/auth_service.dart';
import 'otpPage.dart';
class PhonePage extends StatefulWidget {
  PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final OtpService authService = OtpService();

  bool otpbtn = false;
  String   NUmPhone = "";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Get the screen size info
    final Size screenSize = MediaQuery.of(context).size;
    //naviagtor to otp page!
    getOtp() async {
      setState(() {

      });
      try {
        final String hashCode = await authService.sendOtp(NUmPhone);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return Otppage(number_Phone: NUmPhone, hashCode: identityHashCode(hashCode),  );
              hashCode :
              hashCode;
            })
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: , ${e.toString()}")),
        );
      } finally {
        setState(() {

        });
      }
    }

    // Define a maximum width for the content for large screens (e.g., tablets/web)
    final double maxContentWidth = 600.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Authentication Phone Number",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        // Center the content and limit its maximum width
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "for login you need to verify your phone number",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign
                        .center, // Added for better readability on narrow screens
                  ),

                  const SizedBox(height: 40),

                  InternationalPhoneNumberInput(
                    onInputValidated: (value) {
                      setState(() {
                        otpbtn = value;
                      });
                    },
                    onInputChanged: (value) {
                      setState(() {
                        NUmPhone = value.phoneNumber!;
                      });
                    },
                    initialValue: PhoneNumber(isoCode: 'IR'),
                    formatInput: true,
                    autoFocus: true,
                    keyboardType: TextInputType.phone,
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      showFlags: true,
                      useEmoji: true,
                      leadingPadding: 0,
                      trailingSpace: false,
                    ),
                    inputDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("phone number"),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      
                      onPressed: otpbtn ? getOtp : null,

                      child: const Text("Verify"),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "we will send you a verification code to this number",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ); 
  }
}
