var player01 = {
  'name': 'Leeroy Jenkins',
  'sex': 'M',
  'class': 'Knight',
  'hp': 1000
};

Map player02 = {
  'name': 'Jarod Lee Nandin',
  'sex': 'M',
  'class': 'Overlord',
  'hp': 9000
};
  
Map <String, dynamic> player03 = {
  'name': 'Samantha Evelyn Cook',
  'sex': 'F',
  'class': 'Gunter',
  'hp': 5000
};

void main() {
  //1.)
  print("\n1.)");
  print (player01);
  print ("${player01.runtimeType}");
  print (player02);
  print ("${player02.runtimeType}");
  print (player03);
  print ("${player03.runtimeType}");

  //2.)
  print("\n2.)");
  var player04 = Map();
  player04['name'] = 'Gordon Freeman';
  player04['sex'] = 'M';
  player04['class'] = 'Scientist';
  player04['hp']= 6000;

  print ("player04: $player04");
  print ("player04: ${player04.runtimeType}");

  //3.) Create a new map called player05, give it the same keys as the other players. 
  //Use whichever creation method you want, and populate it with data. Print the map.
  print("\n3.)");
  var player05 = Map();
  player05['name'] = 'Napolian Myat';
  player05['sex'] = 'M';
  player05['class'] = 'Student';
  player05['hp']= 200;

  print ("player05: $player05");
  print ("player05: ${player05.runtimeType}");

  //4.) Add a new key to player05 called armor, give it a value, and then remove hp. Print the results.
  print("\n4.)");
  player05['armour'] = '50';
  player05.remove('hp');
  print("player05: $player05");

// 5.) Create a new map called moreStuff with the following keys, mp, money, xp, and level. 
//Add whatever values you want for these. Add moreStuff to all the player maps.
  print("\n5.)");
  var moreStuff = Map();
  moreStuff['mp'] = 2000;
  moreStuff['money'] = 5000;
  moreStuff['xp'] = 4000;
  moreStuff['level'] = 46;

  player01.addAll(moreStuff.cast());
  player02.addAll(moreStuff.cast());
  player03.addAll(moreStuff.cast());
  player04.addAll(moreStuff.cast());
  player05.addAll(moreStuff.cast());

  print(player01);
  print(player02);
  print(player03);
  print(player04);
  print(player05);

// 6.) Print all the keys from player05.
print("\n6.)");
print(player05.keys);

// 7.) Print all the values from player05.
print("\n7.)");
print(player05.values);

// 8.) Create a new List of Maps, called playerList, and add our player maps to this list, then print it.
print("\n8.)");
var playerList = [];
playerList.add(player01);
playerList.add(player02);
playerList.add(player03);
playerList.add(player04);
playerList.add(player05);

print(playerList);

// 9.) Get the second player from the playerList and output the name.
print("\n9.)");
var secondPlayer = playerList[1];
print(secondPlayer['name']);
//or
print(playerList[1]['name']);

// 10.) Loop through our playerList and output all the player names and classes.
print("\n10.)");
for(int i=0; i<playerList.length; i++)
{
  print("Name: ${playerList[i]['name']}, Class: ${playerList[i]['class']}");
}

// 11.) Clear player01, and output the result.
print("\n11.)");
player01.clear();
print(player01);

}
