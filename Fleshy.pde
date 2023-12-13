
//Fleshy's are the strongest, yet most infrequent enemy
//They can take 3 bullet shots, and while the move slow, their acceleration is very high, only remedied by their method of movement
//Rather than move diagonally, fleshy's move horizontally and vertically.
class Fleshy extends Enemy {

  //Initializes the fleshy
  Fleshy() {
    super();
    health = 2; //sets the fleshy's health to 2
    randRange = 200; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 10 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 6; //the default weight of the enemy spawns

    //Sets the fleshy's speed
    enemySpeed.x = 0.001;
    enemySpeed.y = 0.001;
    
    //Sets the fleshy's acceleration
    enemyAcc.x = 0.005;
    enemyAcc.y = 0.005;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 40;
    enemyWidth = 40;
    
    behavior = false; //sets behavior boolean
  }
  
  @Override void resetEnemy() {
    //resets to default speed
    enemySpeed.x = 0.001;
    enemySpeed.y = 0.001;
    points = int(random(0 + randRange, 5 + randRange)); //Resets how many points the enemy gives
    health = 2; //resets the enemy's health
  }

  //Draws the fleshy
  @Override void drawEnemy() {
    rectMode(CENTER);//Sets to center to more easily determine where fleshy should be drawn

    fill(136, 8, 8); //blood red
    rect(enemyPos.x, enemyPos.y, 40, 40); //body

    //side triangles

    //mouth
    fill(0);
    rect(enemyPos.x, enemyPos.y, 20, 20); //mouth (with no teeth)

    fill(255); //pearly whites!
    rect(enemyPos.x, enemyPos.y + random(8, 10), 20, 5); //bottom teeth
    rect(enemyPos.x, enemyPos.y - random(8, 10), 20, 5); //upper teeth
    //Note: these teeth clatter just like the ones in goopLab (using random)

    rectMode(CORNER);//resets back to default corner
  }

  //Moves the fleshy (This is the part where I die)
  @Override void move() {
    
    //checks if gameTime is divisible by 180
    if (gameTime % 60 == 0){
      
      //if else statement that switches between the two different behavior modes for the fleshy
      if (behavior == false){
        behavior = true;
      } else {
        behavior = false;
      }
    }
    
    //Movement changes depending on behavior between two different movement posibilities.
    //In fleshy's case, it either moves only vertically, or moves only horizontally
    if (behavior == false){
      enemySpeed.add(enemyAcc.x, 0);
      enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed).x, 0);
    }
    if (behavior == true){
      enemySpeed.add(0, enemyAcc.y);
      enemyPos.add(0, directionVector(player.playerPos, this.enemyPos, this.enemySpeed).y);
    }
    
  }
}
