
//Splitters are difficult enemies not too dissimilar from fleshies
//They also take more shots to kill (this time, 3). However, splitters are special in they way they spawn, rising from the ground in a docile state, before activating a very fast "angry" state
//They also do not spawn off-screen, and instead, spawn somewhere on-screen and cannot make the player lose in this docile state. It also only starts its behavior after a set amount of time has passed
class Splitter extends Enemy {
  
  int splitTimer; //timer specifically used for the splitter
  
  //Initializes the fleshy
  Splitter() {
    super();
    health = 3; //sets the fleshy's health to 2
    randRange = 400; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 10 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 6; //the default weight of the enemy spawns

    //Sets the fleshy's speed
    enemySpeed.x = 0.1;
    enemySpeed.y = 0.1;
    
    //Sets the fleshy's acceleration
    enemyAcc.x = 0.07;
    enemyAcc.y = 0.07;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 40;
    enemyWidth = 40;
    
    behavior = false; //sets behavior boolean
    splitTimer = 0; //timer for spawning
  }
  
  @Override void resetEnemy() {
    //resets to default speed
    enemySpeed.x = 0.1;
    enemySpeed.y = 0.1;
    points = int(random(0 + randRange, 5 + randRange)); //Resets how many points the enemy gives
    health = 3; //resets the enemy's health
    behavior = false; //resets behavior
    splitTimer = 0; //resets the splitTimer back to 0
  }
  
  //Draws the husk
  @Override void drawEnemy() {

    //Body
    fill(#F5F5DC); //Flesh-like beige
    ellipse(enemyPos.x, enemyPos.y - 20, 20, 25); //Top head
    circle(enemyPos.x - 10, enemyPos.y + 5, 20); //left body circle
    circle(enemyPos.x + 10, enemyPos.y + 5, 20); //right body circle

    //Mouth
    fill(0); //Pitch black for mouth
    quad(enemyPos.x - 15, enemyPos.y - 25, enemyPos.x + 5, enemyPos.y - 8, enemyPos.x - 5, enemyPos.y + 10, enemyPos.x - 30, enemyPos.y - 10); //left quad
    quad(enemyPos.x + 15, enemyPos.y - 25, enemyPos.x - 5, enemyPos.y - 8, enemyPos.x + 5, enemyPos.y + 10, enemyPos.x + 30, enemyPos.y - 10); //right quad
    rect(enemyPos.x - 10, enemyPos.y - 5, 20, 30); //bottom rectangle
    
    stroke(0); //stroke color for eyes
    strokeWeight(2); //Stroke's weight
    //The stroke, funny enough, actually gives the eyes a jittery effect.
    //While this was not intentional, it gives the husks a lot more life than they had previously. and so, I am keeping it in
    
    //teeth
    fill(255); //teeth color
    quad(enemyPos.x - 15, enemyPos.y - 23, enemyPos.x - 12, enemyPos.y - 18, enemyPos.x - 24, enemyPos.y - 6, enemyPos.x - 27, enemyPos.y - 10); //left quad
    quad(enemyPos.x + 15, enemyPos.y - 23, enemyPos.x + 12, enemyPos.y - 18, enemyPos.x + 24, enemyPos.y - 6, enemyPos.x + 27, enemyPos.y - 10); //right quad
    rect(enemyPos.x - 8, enemyPos.y + 18, 15, 5); //bottom rectangle
    //This is done after outlines to give the teeth the same jittery effect of the eyes

    fill(238, 75, 43); //Color of eyes (yellow)
    circle(enemyPos.x - 4, enemyPos.y - 22, 5); //left eye
    circle(enemyPos.x + 4, enemyPos.y - 22, 5); //right eye
    noStroke(); //reset back to no stroke
  }

  //Moves the husk
  //Credit to Lucas for helping me understand how to pull this off.
  @Override void move() {
    splitTimer += 1;
    //Timer waits for roughly 7 seconds before moving the enemy onto the screen
    if (splitTimer == 420) {
      float posListX[] = {random(player.playerPos.x - 50, player.playerPos.x - 70), random(player.playerPos.x + 50, player.playerPos.x + 70)}; //List of two randomized values that are in a range off of the player's x coordinates
      enemyPos.x = posListX[int(random(0, 2))]; //teleports the splitter somewhere on screen near the player
      float posListY[] = {random(player.playerPos.y - 50, player.playerPos.y - 70), random(player.playerPos.y + 50, player.playerPos.y + 70)}; //List of two randomized values that are in a range off of the player's y coordinates
      enemyPos.y = posListY[int(random(0, 2))]; //teleports the splitter somewhere on screen near the player
    }
    //The randomizing is done this way to both prevent the enemy from telefragging the player and to make them spawn somewhere near the player's position
    
    //Timer waits for roughly 6 seconds before setting behavior to true
    if (splitTimer >= 780) {
      behavior = true;
    }
    
    if (behavior == true){ //Movement trigger based on behavior that initiates the Splitter's fast acceleration
      enemySpeed.add(enemyAcc);
    }
    enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed)); //moves very very very slowly towards the player
    
  }
}
