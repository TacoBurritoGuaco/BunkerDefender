public class Player {
  PVector playerPos = new PVector(); //the position vector of the player

  //Initializes the player to (200, 200) by default
  Player() {
    this.playerPos.x = 200;
    this.playerPos.y = 200;
  }

  void drawPlayer() {
    
    //flag
    fill(240, 20, 20);
    rect(playerPos.x, playerPos.y - 55, 20, 10);
    //draws the stick
    strokeWeight(5);
    stroke(#3B3B3B);
    line(playerPos.x, playerPos.y - 35, playerPos.x, playerPos.y - 55);
    noStroke(); //resets back to no stroke
    
    fill(128);
    quad(playerPos.x - 15, playerPos.y - 35, playerPos.x +15, playerPos.y - 35, playerPos.x + 35, playerPos.y, playerPos.x - 35, playerPos.y); //bunker body
    
    fill(0);
    triangle(playerPos.x, playerPos.y -20, playerPos.x +10, playerPos.y, playerPos.x -10, playerPos.y); //bunker entrance
    
    //Drawing the legs of the bunker defender
    
    //left circle
    fill(#3B3B3B);
    circle(playerPos.x - 7, playerPos.y + (12 + ((float) Math.sin(frameCount * 0.10) * 5)), 15);
    //right circle
    fill(#525252);
    circle(playerPos.x + 7, playerPos.y + (12 - ((float) Math.sin(frameCount * 0.10) * 5)), 15);
    
    //left leg section
    fill(#3B3B3B);
    rect(playerPos.x - 15, playerPos.y, 15, 15 +((float) Math.sin(frameCount * 0.10) * 5));
    //right leg section
    fill(#525252);
    rect(playerPos.x, playerPos.y, 15, 15 -((float) Math.sin(frameCount * 0.10) * 5));

    //animated using framecount the same way it was done with froggyfly
  }

  void movePlayer(char theKey) {
    switch(theKey) {
      case('w'):
      this.playerPos.y -= 1;
      break;
      case('W'):
      this.playerPos.y -= 1;
      break;

      case('s'):
      this.playerPos.y += 1;
      break;
      case('S'):
      this.playerPos.y += 1;
      break;

      case('a'):
      this.playerPos.x -= 1;
      break;
      case('A'):
      this.playerPos.x -= 1;
      break;

      case('d'):
      this.playerPos.x += 1;
      break;
      case('D'):
      this.playerPos.x += 1;
      break;
    }
  }
}
