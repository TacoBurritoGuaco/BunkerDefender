
//Fleshy's are the strongest, yet most infrequent enemy
//They can take 3 bullet shots, and while the move slow, their acceleration is very high, only remedied by their method of movement
//Rather than move diagonally, fleshy's move horizontally and vertically, alternating between the two based on the current gameTime.
class Fleshy extends Enemy {

  //Initializes the fleshy
  Fleshy() {
    super();
    health = 3; //sets the fleshy's health to 3
    randRange = 400; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 10 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 6; //the default weight of the enemy spawns

    //Sets the fleshy's speed
    enemySpeed.x = 0.001;
    enemySpeed.y = 0.001;
    
    //Sets the fleshy's acceleration
    enemyAcc.x = 0.07;
    enemyAcc.y = 0.07;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 25;
    enemyWidth = 25;
    
    behavior = false; //sets behavior boolean
  }
  
  @Override void resetEnemy() {
    //resets to default speed
    enemySpeed.x = 0.001;
    enemySpeed.y = 0.001;
    points = int(random(0 + randRange, 5 + randRange)); //Resets how many points the enemy gives
    health = 3; //resets the enemy's health
  }

  //Draws the fleshy
  @Override void drawEnemy() {
    rectMode(CENTER);//Sets to center to more easily determine where fleshy should be drawn

    fill(156, 8, 8); //blood red
    rect(enemyPos.x, enemyPos.y, 40, 40); //body

    //side triangles
    fill(79, 121, 66);
    triangle(enemyPos.x - 20, enemyPos.y - 20, enemyPos.x - 15, enemyPos.y - 20, enemyPos.x - 20, enemyPos.y - 15);
    triangle(enemyPos.x + 20, enemyPos.y - 20, enemyPos.x + 15, enemyPos.y - 20, enemyPos.x + 20, enemyPos.y - 15);
    triangle(enemyPos.x - 20, enemyPos.y + 20, enemyPos.x - 15, enemyPos.y + 20, enemyPos.x - 20, enemyPos.y + 15);
    triangle(enemyPos.x + 20, enemyPos.y + 20, enemyPos.x + 15, enemyPos.y + 20, enemyPos.x + 20, enemyPos.y + 15);

    //mouth
    fill(0);
    quad(enemyPos.x - 5, enemyPos.y - 10, enemyPos.x + 5, enemyPos.y - 10, enemyPos.x + 15, enemyPos.y + 10, enemyPos.x - 15, enemyPos.y + 10); //mouth (with no teeth)

    fill(255); //pearly whites!
    rect(enemyPos.x, enemyPos.y + random(8, 10), 25, 5); //bottom teeth
    rect(enemyPos.x, enemyPos.y - random(8, 10), 10, 5); //upper teeth
    //Note: these teeth clatter just like the ones in goopLab (using random)

    rectMode(CORNER);//resets back to default corner
  }

  //Moves the fleshy (This is the part where I die)
  //Fleshy moves in an alternating grid like pattern, where he either moves only on the x-axis, or only on the y-axis
  //this alternating pattern changes based on the main game's timer, (specifically, whenever this timer is divisible by 30)
  @Override void move() {
    
    //checks if gameTime is divisible by 180
    if (gameTime % 40 == 0){
      
      //if else statement that switches between the two different behavior modes for the fleshy
      if (behavior == false){
        behavior = true;
      } else {
        behavior = false;
      }
    }
    
    //Movement changes depending on behavior between two different movement posibilities.
    //In fleshy's case, it either moves only vertically, or moves only horizontally
    if (behavior == false){ //Horizontal Movement
      enemySpeed.y = 0; //resets fleshy's vertical speed back to 0
      enemySpeed.add(enemyAcc.x, 0); //fleshy accelerates on the x axis and resets 
      enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed).x, 0); //sets the vertical speed of fleshy to 0, and moves towards the player on the x axis
      //print(enemyPos);
    }
    if (behavior == true){ //Vertical movement
      enemySpeed.x = 0; //resets fleshy's horizontal speed back to 0
      enemySpeed.add(0, enemyAcc.y);
      enemyPos.add(0, directionVector(player.playerPos, this.enemyPos, this.enemySpeed).y); //sets the Horizontal speed of fleshy to 0, and moves towards the player on the y axis
    }
    
  }
}
