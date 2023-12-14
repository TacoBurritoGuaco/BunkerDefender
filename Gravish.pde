//Gravish are the other enemy type that also shoots projectiles
//They, like splitter, spawn somewhere near the player in a docile state. after a bit, it will begin rapidally shooting projectiles towards the player's position.
//However, these projectiles have a large margin of error, being semi-random in their spread
//They have 2 health points, just like Musculus
class Gravish extends Enemy {
  
  int oppacity; //oppacity that increases after gravish spawns
  
  //Initializes the gravish
  Gravish() {
    super();
    health = 2; //sets the health to 2
    randRange = 200; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 10 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 1; //the default weight of the enemy spawns

    //Sets the enemy speed
    enemySpeed.x = 0.1;
    enemySpeed.y = 0.1;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 20;
    enemyWidth = 10;
    //This is purposefully smaller than the splitter to allow for some window for error when it activates
    
    behavior = false; //sets behavior boolean
    enemyTimer = 0; //sets default enemy timer to 0
    oppacity = 0; //oppacity set to 0 by default
  }
  
  @Override void resetEnemy() {
    //resets to default speed
    enemySpeed.x = 0.1;
    enemySpeed.y = 0.1;
    points = int(random(0 + randRange, 5 + randRange)); //Resets how many points the enemy gives
    health = 2; //resets the enemy's health
    behavior = false; //resets behavior
    enemyTimer = 0; //resets enemy timer
    oppacity = 0; //resets oppacity
  }
  
  //Draws the husk
  @Override void drawEnemy() {
    
    //When the splitter appears on screen
    if (enemyTimer >= 420) {
      oppacity += 5;
    }
    
    rectMode(CENTER);
    //Body
    fill(#F5F5DC, oppacity); //Flesh-like beige
    ellipse(enemyPos.x, enemyPos.y - 13, 20, 20); //Top head
    rect(enemyPos.x, enemyPos.y, 20, 25); //body
    triangle(enemyPos.x - 10, enemyPos.y + 12, enemyPos.x + 10, enemyPos.y + 12, enemyPos.x, enemyPos.y + 25); //little ghost tail thingamajig

    //body pattern
    noFill();
    stroke(#d9b99b, oppacity);
    strokeWeight(2);
    arc(enemyPos.x, enemyPos.y - 10, 20, 5, 0, PI);
    arc(enemyPos.x, enemyPos.y - 5, 20, 5, 0, PI);
    arc(enemyPos.x, enemyPos.y + 5, 20, 5, 0, PI);
    arc(enemyPos.x, enemyPos.y + 10, 20, 5, 0, PI);
    
    noStroke(); //resets back to no stroke
    
    //Top Leaves
    fill(201, 204, 63);
    circle(enemyPos.x - 2, enemyPos.y - 24, 7);
    fill(180, 196, 36);
    circle(enemyPos.x + 2, enemyPos.y - 24, 7);
    
    //eye
    fill(0, oppacity);
    ellipse(enemyPos.x, enemyPos.y, 20, 8);
    
    if (enemyTimer < 780){
      fill(189, 181, 213);
      circle(enemyPos.x, enemyPos.y, 2);
    } else { //eye pulsates in a hipnotic pattern whenever its docile state is over
      fill(189, 181, 213);
      circle(enemyPos.x, enemyPos.y, 2);
      stroke(189, 181, 213);
      strokeWeight(2);
      noFill();
      circle(enemyPos.x, enemyPos.y, 5 + ((float) Math.sin(frameCount * 0.75) * 2));
    }
    
    noStroke();
    rectMode(CORNER); //reset back to corner
  }

  //Moves the husk
  //Credit to Lucas for helping me understand how to pull this off.
  @Override void move() {
    enemyTimer += 1;
    //Timer waits for roughly 7 seconds before moving the enemy onto the screen
    if (enemyTimer == 420) {
      float posListX[] = {random(player.playerPos.x - 60, player.playerPos.x - 70), random(player.playerPos.x + 60, player.playerPos.x + 70)}; //List of two randomized values that are in a range off of the player's x coordinates
      enemyPos.x = posListX[int(random(0, 2))]; //teleports the splitter somewhere on screen near the player
      float posListY[] = {random(player.playerPos.y - 60, player.playerPos.y - 70), random(player.playerPos.y + 60, player.playerPos.y + 70)}; //List of two randomized values that are in a range off of the player's y coordinates
      enemyPos.y = posListY[int(random(0, 2))]; //teleports the splitter somewhere on screen near the player
    }
    //The randomizing is done this way to both prevent the enemy from telefragging the player and to make them spawn somewhere near the player's position
    
    //Timer waits for roughly 6 seconds before setting behavior to true
    if (enemyTimer >= 780) {
      behavior = true;
    }
    
    if (behavior == true){ //starts shooting projectiles very rapidally towards the player
      if (gameTime % 30 == 0){ //Shoots every half a second
        shootProjectile();
      }
    }
    enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed)); //moves very very very slowly towards the player
    
  }
  
  //Shoots the gravish projectile by adding a new projectile to the world's projectile list
  @Override void shootProjectile(){
    //sets the player position to a new randPos vector
    PVector randPos = player.playerPos.copy();
    //Randomizes this vector's coordinates slightly
    randPos.x += random(0, 50);
    randPos.y += random(0, 50);
    //Shoots the projectile based on this slightly randomized diretion
    projList.add(new Projectile(enemyPos.x, enemyPos.y, randPos));
  }
  
}
