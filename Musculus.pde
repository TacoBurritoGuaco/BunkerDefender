//Musculus are one of two projectile shooting enemies
//They take more shots, but move veeery very slowly towards the player
//They shoot projectiles towards the player semi-infrequently that moves towards the last position the player was in.
class Musculus extends Enemy {

  //Initializes the oculus
  Musculus() {
    super();
    health = 2; //health is set to 2
    randRange = 100; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 100 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 8; //the default weight of the enemy spawns

    //Sets the oculus' speed
    enemySpeed.x = 0.2;
    enemySpeed.y = 0.2;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 25;
    enemyWidth = 15;
  }

  @Override void resetEnemy() {
    enemySpeed.x = 0.2;
    enemySpeed.y = 0.2;
    points = int(random(0 + randRange, 10 + randRange)); //Resets how many points the enemy gives
    health = 2; //resets the enemy's health
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
  
    if ((this.enemyPos.x <= width + 20 && this.enemyPos.x >= 0 - 20) && (this.enemyPos.y <= height + 30 && this.enemyPos.y >= 0 - 30)) { //only shoots when on-screen
      if (gameTime % (points + 260) == 0){ //randomized using points, changing when the projectile is shot slightly
        shootProjectile();
      }
    }
    enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed)); //moves very very very slowly towards the player
  }
  
  @Override void shootProjectile(){
    projList.add(new Projectile(enemyPos.x, enemyPos.y, player.playerPos.copy()));
  }
}
