void main() {
  // add your new code here.
  //Call helloFunction
  helloFunction("hi", 10);
  helloFunction(null, 10); //error param can't be null
  //(add ? in the function param to allow string param to be null)

  helloFunction3();

  printThree(first: "Hello", second: "Fall", third: "Season");
  printThree(
    third: "Season",
    first: "Hello",
    second: "Fall",
  ); //change in order results in same output as the params are named

  printThree(
      second: "Hello"); //allowing nulls for 1st and 3rd but 2nd is required

  //MYCODE
  print("\n1.)");
  addThree(1, 2, 3);

  print("\n2.)");
  print(joinStrings(null, "random", "orange"));

  print("\n3.)");
  print(hiLow(20.5, 25.2, 50.1));

  print("\n4.)");
  print(makeCharacter("Napolian", "Student", 3000));
}

///MY CODE
// 1. Create a new function called addThree, as the function name
//implies, pass in 3 int named parameters, add them and print them.
addThree(int first, int second, int third) {
  print("$first + $second + $third = ${first + second + third}");
}

// 2. Create a function that does the following:
// - returns a String.
// - named joinStrings.
// - takes in named string parameters.
// - allow the first 2 parameters to be null.
// - make the last 2 parameteres optional with default values.
// - Don't print nulls, and combine all the strings into one and return.
joinStrings(String? first, String? second,
    [String third = "apple", String fourth = "bee"]) {
  String myStrings = ""; //create an empty string
  //Create a list to store the params
  List<String?> strings = [first, second, third, fourth]; //? required
  strings.forEach((string) {
    //if this string is null, will make it "" empty string
    if (string == null) string = "";
    //add string to myString
    myStrings += string;
  });

  return myStrings;
}

// 3. Create a function that does the following:
// - returns an Map.
// - named hiLow.
// - takes in 3 floating point numbers.
// - Add the numbers together. Store in our return map as sum.
// - Round the result upward and downward. Store in our return map with keys high and low.
hiLow(double num1, double num2, double num3) {
  var tempMap = Map();
  double sum = num1 + num2 + num3;
  int high = sum.ceil();
  int low = sum.floor();

  tempMap['sum'] = sum;
  tempMap['high'] = high;
  tempMap['low'] = low;
  return tempMap;
}

// 4. Create a function that does the following:
// - returns an Map.
// - named makeCharacter.
// - takes in 4 named parameters; name, playerClass, mp, hp.
// - if mp or hp is null, give them a default value.
// - Add to the map xp and level with some default value.
makeCharacter(String? name, String? playerClass, [int mp = 500, int hp = 200]) {
  var tempMap = Map();
  tempMap['name'] = name;
  tempMap['playerClass'] = playerClass;
  tempMap['mp'] = mp;
  tempMap['hp'] = hp;
  tempMap['xp'] = 100;
  tempMap['level'] = 5;

  return tempMap;
}

///////////////////////////////////
///CLASS CODE
///Returns nothing but takes in a string and an integer param
///Prints params out
void helloFunction(String? a, int b) {
  print("$a, $b");
}

///Function param can be made optional by using [] but requires default value
void helloFunction3([String a = "hi", int b = 10]) {
  print("$a, $b");
}

///Named Param that send params into a function in a more readable way
// void printThree({String? first, String? second, String? third}) {
//   print("$first, $second, $third");
// }

///Require Params(if a param is required, ? is not necessary since there is
///no potential of a missing paramter, even a null is considered a valid parameter. )
void printThree({String? first, required String second, String? third}) {
  print("$first, $second, $third");
}
