import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextField & DropDown Buttons',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Cool Game Beta Signup Form'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //VARIABLES
  String displayText = "Your Awesome Personal Data will show here!";
  // void displayChangedText(String newText) {
  //   displayText = newText;
  // }

  String email_ = '';
  String name_ = '';
  String phoneNumber_ = '';
  String dob_ = '';
  List<String> listOfItems = <String>[
    "In-Person",
    "Email",
    "Voice Call",
    "Text Message"
  ];
  String contactPref_ = "In-Person";

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  void submitForm() {
    displayText =
        "Name: $name_\nEmail: $email_\nDOB: $dob_\nPhone: $phoneNumber_\nContact Pref $contactPref_";
  }

  void changeEmail(TextEditingController tec) {
    email_ = tec.text;
  }

  ///style custom text
  Text myText(String textString, double fontsize_,
      [fontWeight_ = FontWeight.normal,
      fontColor_ = Colors.black,
      textHeight_ = 1.2]) {
    return Text(textString,
        style: TextStyle(
            fontSize: fontsize_,
            fontWeight: fontWeight_,
            color: fontColor_,
            height: textHeight_));
  }

  SizedBox inputTextField(IconData icon_, String text_, TextInputType inputType,
      TextEditingController inputController, Function(String) onChanged_) {
    return SizedBox(
      child: TextField(
          keyboardType: inputType,
          controller: inputController,
          obscureText: false,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
              labelText: text_,
              icon: Icon(icon_,
                  size: 40, color: Colors.grey), //Add icon before textfield
              //X icon to clear inputted values
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => {
                  setState(() {
                    inputController.text = '';
                    onChanged_(
                        ''); //without this, when clearing, there exists previous set value which is never cleared
                  }),
                }, //clears the input
              )),
          onChanged:
              onChanged_), //calls function which changes the string text ie. Email, to user inputs
    );
  }

  SizedBox dropDownButton() {
    return SizedBox(
        width: 400,
        child: DropdownButton<String>(
          menuWidth: 400,
          isExpanded: true, //sends dropdown carrot to the foremost right
          value: contactPref_,
          underline: Container(), //hide bottom shadow
          items: listOfItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child:
                  Text(value, style: TextStyle(fontWeight: FontWeight.normal)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              contactPref_ = value!;
            });
          },
        ));
  }

  ////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //blue background
        backgroundColor: Color(0xff3f51b6),
        title: myText(widget.title, 20, FontWeight.w600, Colors.white),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0), //outside padding
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Welcome
                Container(
                  padding: EdgeInsets.all(15),
                  child: myText("Welcome to your Doom!", 28, FontWeight.bold),
                ),
                //Text Output
                Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black, width: 3), //add border
                      borderRadius: BorderRadius.circular(10)), //round edge
                  padding: EdgeInsets.all(10), //for text
                  child: myText(displayText, 22),
                ),
                //Text instruction
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: myText(
                      "Enter your information to get the latest news on our awesome game!",
                      20),
                ),
                //Information Column
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    inputTextField(Icons.person_rounded, "Name",
                        TextInputType.name, nameController, (value) {
                      setState(() {
                        name_ = value;
                      });
                    }),
                    inputTextField(Icons.email, "Email",
                        TextInputType.emailAddress, emailController, (value) {
                      setState(() {
                        email_ = value;
                      });
                    }),
                    inputTextField(Icons.date_range, "Date of Birth",
                        TextInputType.datetime, dobController, (value) {
                      setState(() {
                        dob_ = value;
                      });
                    }),
                    inputTextField(Icons.phone, "Phone", TextInputType.phone,
                        phoneNumberController, (value) {
                      setState(() {
                        phoneNumber_ = value;
                      });
                    }),
                    Row(children: [
                      Icon(
                        Icons.contact_support,
                        size: 55,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: EdgeInsets.fromLTRB(10, 05, 10, 0),
                          child: dropDownButton(),
                        ),
                      )
                    ]),
                  ],
                ),

                //Reset&Submit Button
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Colors.deepOrange,
                          ),
                          icon: Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              displayText = "";
                            });
                          },
                          label: Text("Reset Form",
                              style: TextStyle(color: Colors.white))),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Color(0xff3f51b6),
                          ),
                          icon: Icon(Icons.check, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              submitForm();
                            });
                          },
                          label: Text("Submit Form",
                              style: TextStyle(color: Colors.white)))
                    ],
                  ),
                ),

                //
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
