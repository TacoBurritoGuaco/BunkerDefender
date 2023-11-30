public class Player {
  PVector playerPos = new PVector(); //the position vector of the player

  //Initializes the player to (200, 200) by default
  Player() {
    this.playerPos.x = 200;
    this.playerPos.y = 200;
  }

  void drawPlayer() {
  }

  void movePlayer(char theKey) {
    switch(theKey) {
      case('w'):
      this.playerPos.y -= 2;
      case('W'):
      this.playerPos.y -= 2;

      case('s'):
      this.playerPos.y += 2;
      case('S'):
      this.playerPos.y += 2;

      case('a'):
      this.playerPos.x -= 2;
      case('A'):
      this.playerPos.x -= 2;

      case('d'):
      this.playerPos.x += 2;
      case('D'):
      this.playerPos.x += 2;
    }
  }
}
