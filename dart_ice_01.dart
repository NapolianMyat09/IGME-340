void main() {
  int myNumber = 1234;
  double myFloat = 1234.6234;
  String myString = "Hello World";
  bool myBoolean = false;
  const myConst = "I don't change";
  final iAmFinal;
  dynamic iAmDynamic;
  var iAmVar;

  // add your new code here.
  //1.i.
  //myConst = "changed const"; //error
  //1.ii.
  iAmFinal = "My Final Offer";
  //1.iii.
  //iAmFinal = "I changed my Mind!"; //error

  //2.i.
  iAmVar =
      12345; //we haven't assigned a type so Dart converts this to a dynamic
  print(iAmVar);
  iAmVar = "I am String now";
  print(iAmVar);

  //2.ii. alter the declaration of our dynamic and give it a number
  iAmDynamic = 9;
  print(iAmDynamic);
  //iAmDynamic = "I am String now"; error still?
  print(iAmDynamic);

  print("$myConst, $myBoolean, $myNumber, $iAmFinal");
  //print ("some text " + dbl.toString());
  //print ("some text $variable");
  //print ("some text ${variable.function()}");

  /////////////////////////////////////////////////
  //Exercise
  print("=============================");
  print("Exercise Output");
  //1. Use interpolation and output myString along with myFloat.
  print("1.) $myString ${myFloat.toString()}");

  //2. Use interpolation and output myString, but make all the characters uppercase.
  print("2.) ${myString.toUpperCase()}");

  //3. Use interpolation and output both the value of myFloat rounded up and down.
  print(
      "3.) Number: $myFloat, Rounded Up: ${myFloat.ceil()}, Rounded Down: ${myFloat.floor()}");

  //4. Use interpolation to print out the number of seconds that have passed since 1970 - use the DateTime library.

  print(
      "4.) Time Passed Since 1970: ${DateTime.now().difference(DateTime(1970)).inSeconds} seconds"); //get the difference between the time now and the year 1970 in seconds

  //5. Print out the absolute value of -999.
  int num = -999;
  print("5.) Absolute value of $num is ${num.abs()}");

  //6. Create a new dynamic variable. Assign it initially to 1234, print it, then assign to "Hello there!", and print it.
  dynamic newVar = 1234;
  print("6.) New dynamic variable initial value = $newVar");
  newVar = "Hello there!";
  print("New dynamic variable value is changed to \"$newVar\"");

  //7. Create a for loop that prints 0 to 20.
  print("7.) For Loop: ");

  String numForLoop = "";
  for (int i = 0; i <= 20; i++) {
    //if i is greater than 10, will break out from for loop
    if (i > 10) {
      break;
    }
    numForLoop += "$i, "; //add num iteration to forloop string
  }

  print(numForLoop);

  //8. Perform the same operation as above but using a while loop.
  print("8.) While Loop:");

  String numWhileLoop = "";
  int i = 0;
  while (i <= 20) {
    //if i is greater than 10, will break out from while loop
    if (i > 10) {
      break;
    }
    numWhileLoop += "$i, ";
    i++;
  }
  print(numWhileLoop);

  //9. Modify both the for loop and while loop and break out of the loop once the counter reaches 10.
}
