//Musculus are one of two projectile shooting enemies
//They take more shots, but move veeery very slowly towards the player
//They shoot projectiles towards the player semi-infrequently that moves towards the last position the player was in.
class Musculus extends Enemy {

  //Initializes the Musculus
  Musculus() {
    super();
    health = 2; //health is set to 2
    randRange = 100; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 100 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 8; //the default weight of the enemy spawns

    //Sets the enemy' speed
    enemySpeed.x = 0.2;
    enemySpeed.y = 0.2;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 15;
    enemyWidth = 10;
  }

  @Override void resetEnemy() {
    enemySpeed.x = 0.2;
    enemySpeed.y = 0.2;
    points = int(random(0 + randRange, 10 + randRange)); //Resets how many points the enemy gives
    health = 2; //resets the enemy's health
  }

  //Draws the Musculus
  @Override void drawEnemy() {
    
    fill(79, 121, 66); //zombie green
    ellipse(enemyPos.x, enemyPos.y, 20, 25); //body
    circle(enemyPos.x - 15, enemyPos.y - 15, 10); //left ear
    circle(enemyPos.x + 15, enemyPos.y - 15, 10); //right ear
    
    fill(156, 8, 8); //blood red
    circle(enemyPos.x - 15, enemyPos.y - 15, 5); //left ear (inside)
    circle(enemyPos.x + 15, enemyPos.y - 15, 5); //right ear (inside)
    
    rectMode(CENTER);
    fill(255);
    rect(enemyPos.x, enemyPos.y + 11, 5, 5); //teeth
    rectMode(CORNER); //reset back to default
    noFill();
    stroke(0);
    strokeWeight(2);
    arc(enemyPos.x, enemyPos.y + 7, 10, 5, 0, PI); //smile
    noStroke();//reset back to default
    
    //Head Growths
    fill(201, 204, 63);
    circle(enemyPos.x, enemyPos.y - 5, 20 + ((float) Math.sin(frameCount * 0.15) * 2)); //pulsates
    circle(enemyPos.x - 10, enemyPos.y - 7, 15);
    circle(enemyPos.x + 10, enemyPos.y - 7, 15);
    fill(180, 196, 36);
    circle(enemyPos.x, enemyPos.y - 15, 12 + ((float) Math.sin(frameCount * 0.20) * 2)); //pulsates
    circle(enemyPos.x - 7, enemyPos.y - 14, 8);
    circle(enemyPos.x + 7, enemyPos.y - 14, 8);
    
  }

  //Moves the Musculus
  //Credit to Lucas for helping me understand how to pull this off.
  @Override void move() {
  
    if ((this.enemyPos.x <= width + 20 && this.enemyPos.x >= 0 - 20) && (this.enemyPos.y <= height + 30 && this.enemyPos.y >= 0 - 30)) { //only shoots when on-screen
      if (gameTime % (points + 260) == 0){ //randomized using points, changing when the projectile is shot slightly
        shootProjectile();
      }
    }
    enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed)); //moves very very very slowly towards the player
  }
  
  //Shoots the musculus projectile by adding a new projectile to the world's projectile list
  @Override void shootProjectile(){
    projList.add(new Projectile(enemyPos.x, enemyPos.y, player.playerPos.copy()));
  }
}
