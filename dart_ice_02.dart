void main() {
  //////////////////////////
  ///Exercise
  //////////////////////////
  // 1.) Create a new fixed size array called myList1 with five 0's inside, hint, use var for the data type. Then change item 2 to 1, and print it.
  print("1.)");
  var myList1 = List.filled(5, 0, growable: false);
  print(myList1);
  myList1[1] = 1;
  //Print
  print(myList1);

  // 2.) Create a loosely typed growable list called myList2. Add one of every data type into the list (String, number, double, boolean), and print it.
  print("2.)");
  var myList2 = [];
  //add data types
  myList2.add("A String");
  myList2.add(9);
  myList2.add(99.9);
  myList2.add(false);
  //Print
  print(myList2);

  // 3.) Insert IGME into myList2 in the second array position, and print it.
  print("3.)");
  myList2.insert(1, "IGME"); //2nd position is list[1]
  //print
  print(myList2);

  // 4.) Create a new list called myList3 that contains ['item1', 'item2', 'item3'], then add it all into myList2 and print it.
  print("4.)");
  var myList3 = ['item1', 'item2', 'item3'];
  myList2.addAll(
      myList3); //'add' adds the list as a item whereas addAll add the list3 components as individual items
  print(
      myList2); //the instruction is worded weirdly and is so vague. Does it want me to print myList2 or myList3?

  // 5.) Create a new list called myList4 that contains [123.4, 'item 6', false] and insert it into the very beginning of myList2 and print it.
  print("5.)");
  var myList4 = [123.4, 'item 6', false];
  myList2.insertAll(0, myList4); //add to the beginning
  print(myList2);

  // 6.) Create a new growable String array called myList5, and add a few items to it and print it.
  print("6.)");
  var myList5 = List.filled(0, "", growable: true);
  myList5.add("item1");
  myList5.add("item2");
  myList5.add("item3");
  myList5.add("item4");

  print(myList5);

  // 7.) Remove the 3rd item from myList5, and print the result.
  print("7.)");
  myList5.removeAt(2);
  print(myList5);

  // 8.) Remove the last item from myList5, and print the result.
  print("8.)");
  myList5.removeLast();
  print(myList5);

  // 9.) Remove items 2 to 5 in myList2, and print the result.
  print("9.)");
  print(myList2);
  int start = 1;
  int end = 5;
  myList2.removeRange(start, end);
  print(myList2);
}
