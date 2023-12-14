
//Oculus' are a more difficult yet infrequent enemy
//They don't speed up, instead moving at a constant, faster speed
//Additionally, whenever targetted, they'll attempt to move away from the mouse's position.
class Oculus extends Enemy {

  //Initializes the oculus
  Oculus() {
    super();
    randRange = 80; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 10 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 2; //the default weight of the enemy spawns

    //Sets the oculus' speed
    enemySpeed.x = 0.6;
    enemySpeed.y = 0.6;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 25;
    enemyWidth = 15;
  }

  @Override void resetEnemy() {
    enemySpeed.x = 0.6;
    enemySpeed.y = 0.6;
    points = int(random(0 + randRange, 10 + randRange)); //Resets how many points the enemy gives
    health = 1; //resets the enemy's health
  }

  //Draws the oculus
  @Override void drawEnemy() {

    fill(156, 8, 8);; //blood red
    quad(enemyPos.x - 10, enemyPos.y - 20, enemyPos.x + 10, enemyPos.y - 25, enemyPos.x + 15, enemyPos.y, enemyPos.x - 15, enemyPos.y); //Top trapezoid
    quad(enemyPos.x - 10, enemyPos.y + 15, enemyPos.x + 10, enemyPos.y + 10, enemyPos.x + 15, enemyPos.y, enemyPos.x - 15, enemyPos.y); //bottom trapezoid

    fill(245); //greyish white for the eyes
    circle(enemyPos.x - 8, enemyPos.y - 5, 25); //first eye
    circle(enemyPos.x + 15, enemyPos.y - 12, 20); //second eye
    circle(enemyPos.x + 10, enemyPos.y + 7, 15); //third eye

    fill(0);
    circle((player.playerPos.x/30)+(enemyPos.x - 18), (player.playerPos.y/30)+(enemyPos.y - 10), 5); // first pupil (looks towards the player instead of the mouse)
    circle((mouseX/50)+(enemyPos.x + 12), (mouseY/50)+(enemyPos.y - 15), 10); // second pupil (looks towards the mouse)
    circle((mouseX/55)+(enemyPos.x + 7), (mouseY/55)+(enemyPos.y + 5), 5); // third pupil (looks towards the mouse)
    
    //The pupils works the same way as the froggyFly pupils.
  }

  //Moves the Oculus
  //Credit to Lucas for helping me understand how to pull this off.
  @Override void move() {
    //Set the vectors that will be used in the calculation for movement
    PVector towardsPos = new PVector(); //towards the player
    PVector awayPos = new PVector(); //away from the sniper mark

    //Sets the mouse's position vector
    PVector mouse = new PVector();

    //sets the x and y of said vector to mouseX and mouseY
    mouse.x = mouseX;
    mouse.y = mouseY;
    //adds the next position that the enemy should be at given the directional vector
    //However, this vector also accounts for the position of the mouse, and will attempt to move away from the mouse while still heading towards the center
    //It will do this by taking both vectors (one away from mouse position, and the other towards the center) and finding the vector in-between them
    //This makes its movement quite interesting, making it perhaps not a priority if stalled correctly, but still very scary if ignored
    towardsPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed)); //calculates the vector that goes towards the player
    awayPos.add(directionVector(mouse, this.enemyPos, this.enemySpeed)); //calculates the vector that goes away from the mark
    enemyPos.add(directionVector(towardsPos.mult(1.1), awayPos, this.enemySpeed)); //calculates both vectors to create oculus pathing.
  }
}
