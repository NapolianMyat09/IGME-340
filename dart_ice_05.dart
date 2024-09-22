/// our list of monsters
List<dynamic> monsters = [];

///
/// Our Base Monster class
///
// class Monster {
//   String? name;
//   int? hp;
//   int? speed;
//   int? score;
// }

class Monster {
  String name;
  int hp;
  int speed;
  int score;

  /// constructor
  // Monster(String name, int hp, int speed, int score) {
  //   this.name = name;
  //   this.hp = hp;
  //   this.speed = speed;
  //   this.score = score;
  // }
  //Alternative
  Monster({this.name = "", this.hp = 0, this.speed = 0, this.score = 0});

  /// class method
  void status() {
    print("name: $name, hp: $hp, speed: $speed, score: $score");
  }
}

void main() {
  Monster myGoomba = Monster(hp: 50, name: 'John', score: 200, speed: 20);
  myGoomba.status();

  //MyCode
  print("\nExercise");
  print("1-2.)");
  // 2.) Use your Player class and create a player called Mario and
  //give him some data. Call the status function and then level him
  //up 10x (hint, use a loop).
  Player myPlayer = Player(name: "Mario", lives: 5);
  myPlayer.status();
  for (int i = 0; i < 10; i++) {
    myPlayer.levelUp();
  }
  // 4.) Create a new List of Treasure, and add 5 treasure items to
  //it, then loop through the list and report each item's status.
  print("\n3-4.)");
  List<Treasure> listTreasure = [
    Treasure(),
    Treasure("Golden Apple", 3000, "Legendary", "Food"),
    Treasure("The Holy Grail", 2000, "Epic", "Misc"),
    Treasure("Pandora's Box", 2500, "Epic", "Loot Box"),
    Treasure("Excalibur", 3000, "Legendary", "Weapon")
  ];
  listTreasure.forEach((treasure) {
    treasure.status();
  });

  // 5.) Use Cascading/Chaining to create a new Player and add a new item to the
  //treasures list. At the end of the chain call the status method to output the
  //results. For the new treasure item, output the entire list.
  // ** HINT: You will need to alter the Treasure class.
  print("\n5.)");
  Treasure("Philosopher's Stone", 3200, "Mythic", "Tool")
      .createPlayer("Alvin")
      .addTreasureToList(listTreasure)
      .status();

  print("");
  listTreasure.forEach((treasure) {
    treasure.status();
  });
}

///////////////
///MYCODE
///////////////
/// 1.) Create a Player class, and do the following:
/// Add fields for name, lives, score, xpand speed
/// create a constructor and use named parameters.
/// create a method called status, which outputs the object fields.
/// create another method called levelUp which adds 100 to xp,
/// increases speed by 10, and adds 500 to score. The method should also call the status method.
class Player {
  String name;
  int lives;
  int score;
  int xp;
  int speed;

  //Constructor
  Player(
      {this.name = "Player1",
      this.lives = 3,
      this.score = 0,
      this.xp = 0,
      this.speed = 0});

  // Class Methods
  void status() {
    print("name: $name, lives: $lives, score: $score, xp: $xp, speed: $speed");
  }

  void levelUp() {
    this.xp += 100;
    this.speed += 10;
    this.score += 500;
    status();
  }
}

// 3.) Create a Treasure class and do the following:
// Add fields for name, value, rarity, and type. Use default values.
// create a constructor without using named parameters.
// create a method called status, which outputs the object fields.
class Treasure {
  String name;
  int value;
  String rarity;
  String type;

  Treasure(
      [this.name = "Artifact1",
      this.value = 10,
      this.rarity = "Common",
      this.type = "Decoration"]);

  Treasure status() {
    print("name: $name, value: $value, rarity: $rarity, type: $type");
    return this;
  }

  //5.) Portions
  Treasure addTreasureToList(List<Treasure> tempListTreasure) {
    tempListTreasure.add(this);
    return this; //cascade //chaining
  }

  Treasure createPlayer(
      [playerName = "Player1", lives = 5, score = 0, xp = 0, speed = 0]) {
    Player scopedPlayer = Player(
        name: playerName, lives: lives, score: score, xp: xp, speed: speed);
    scopedPlayer.status();
    return this;
  }
}
