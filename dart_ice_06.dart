/// our list of monsters
List<dynamic> monsters = [];

///
/// Our Base Monster class
///
class Monster {
  String name;
  int hp;
  int speed;
  int score;
  // 1.) Add a type proprety to the Monster class.
  String type;

  /// constructor
  Monster(
      {this.name = "",
      this.hp = 0,
      this.speed = 0,
      this.score = 0,
      this.type = ""}); //1.) also fix any issues that arise.

  /// class method
  void status() {
    //1.) //Be sure to output this new property,
    print("name: $name, hp: $hp, speed: $speed, score: $score, type: $type");
  }
}

class Goomba extends Monster {
  String color;
  int dmg;
  Goomba(
      {super.name,
      super.hp,
      super.speed,
      super.score,
      super.type = "Goomba", //1.) Make the Goomba add a value to this property.
      this.color = "brown",
      this.dmg = 20});

  @override
  void status() {
    print(
        //1.) //Be sure to output this new property,
        "name: $name, hp: $hp, speed: $speed, score: $score, type: $type, color: $color, dmg: $dmg");
  }
}

///////////////////////
///MYCODE
///////////////////////
// 2.) Create a new class called Boo that inherits everything from Monster.
//Add an mp property and a new constructor.
class Boo extends Monster {
  int mp;
  // int originalMp;
  Boo(
      {super.name,
      super.hp,
      super.speed,
      super.score,
      super.type = "Boo",
      this.mp = 200});

  // 3.) Add a function called castSpell to Boo which takes in an
  //integer and reduces the Boo mp by that amount, it should also
  //write something to console.
  void castSpell(int decreaseAmount) {
    this.mp -= decreaseAmount;
    print("$name's mp is decreased by $decreaseAmount to $mp mp");
  }

  // 4.) Override the Monster status class in Boo to return all
  //the stats, including mp.
  @override
  void status() {
    print(
        "name: $name, hp: $hp, speed: $speed, score: $score, type: $type, mp: $mp");
  }
}

/// 5.) Create a makeSomeMonsters function and add a number of
/// Goombas and Boos to the monster list. Call this function
/// from main.
void makeSomeMonsters() {
  for (int i = 1; i <= 5; i++) {
    monsters.add(Goomba(name: "Goomba$i"));
  }
  for (int i = 1; i <= 3; i++) {
    monsters.add(Goomba(name: "Boo$i"));
  }
}

// 6.)Finally, create a showMonsters function can take a specific
//type of monster and goes through our list of monsters, when
//that type is encountered, call its status function. Call this
//function from main once for Boos and once for Goombas.
void showMonsters(String type) {
  for (var monster in monsters) {
    if (monster.type == type) {
      monster.status();
    }
  }
}

void main() {
  Goomba myGoomba = Goomba(name: "Pinky", hp: 50, speed: 5, score: 100);
  myGoomba.status();

  Boo myBoo = Boo(name: "Casper", speed: 200, mp: 2000);
  myBoo.castSpell(20);
  myBoo.status();

  //5.)
  makeSomeMonsters();
  //6.)
  showMonsters("Goomba");
  showMonsters("Boo");
}
