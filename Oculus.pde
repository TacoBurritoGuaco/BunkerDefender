
//Oculus' are a more difficult yet infrequent enemy
//They don't speed up, instead moving at a constant, faster speed
//Additionally, whenever targetted, they'll attempt to move away from the mouse's position.
class Oculus extends Enemy {

  //Initializes the oculus
  @Override Enemy() {
    super();
    randRange = 80; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 10 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 2; //the default weight of the enemy spawns

    //Sets the oculus' speed
    enemySpeed.x = 0.5;
    enemySpeed.y = 0.5;

    //sets the enemy's location
    enemyPos.x = enemyLoc(randRange, weightChance).x;
    enemyPos.y = enemyLoc(randRange, weightChance).y;

    //sets to default enemy length and width
    enemyLength = 25;
    enemyWidth = 15;
  }

  @Override void resetEnemy() {
    enemySpeed.x = 0.5;
    enemySpeed.y = 0.5;
    points = int(random(0 + randRange, 10 + randRange)); //Resets how many points the enemy gives
    health = 1; //resets the enemy's health
  }

  //Draws the oculus
  @Override void drawEnemy() {

    fill(136, 8, 8); //blood red
    quad(ocPos.x - 15, ocPos.y, ocPos.x, ocPos.y - 25, ocPos.x + 15, ocPos.y, ocPos.x, ocPos.y + 25); //diamond drawn behind the eye of the oculus

    fill(245); //greyish white for the eye

    circle(ocPos.x, ocPos.y, 30); //eye

    fill(0);
    circle((mouseX/20)+(ocPos.x - 9), (mouseY/20)+(ocPos.y - 9), 5); //pupil
    //The pupil works the same way as the froggyFly pupils.
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
    towardsPos.add(directionVector(playerPos, this.enemyPos, this.enemyspeed*1.5)); //calculates the vector that goes towards the player
    awayPos.add(directionVector(mouse, this.enemyPos, this.enemyspeed)); //calculates the vector that goes away from the mark
    enemyPos.add(directionVector(towardsPos, awayPos, this.enemyspeed)); //calculates both vectors to create oculus pathing.
  }
}
