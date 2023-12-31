
//Splitters are difficult enemies not too dissimilar from fleshies
//They also take more shots to kill (this time, 3). However, splitters are special in they way they spawn, rising from the ground in a docile state, before activating a very fast "angry" state
//They also do not spawn off-screen, and instead, spawn somewhere on-screen and cannot make the player lose in this docile state. It also only starts its behavior after a set amount of time has passed
class Splitter extends Enemy {
  
  
  int oppacity; //oppacity that increases after splitter spawns
  
  //Initializes the fleshy
  Splitter() {
    super();
    health = 3; //sets the health to 3
    randRange = 250; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 10 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 6; //the default weight of the enemy spawns

    //Sets the splitter's speed
    enemySpeed.x = 0.1;
    enemySpeed.y = 0.1;
    
    //Sets the splitter's acceleration
    enemyAcc.x = 0.07;
    enemyAcc.y = 0.07;

    //sets the enemy's location
    enemyPos = enemyLoc(randRange, weightChance);

    //sets to default enemy length and width
    enemyLength = 30;
    enemyWidth = 30;
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
    health = 3; //resets the enemy's health
    behavior = false; //resets behavior
    enemyTimer = 0; //resets enemy timer
    oppacity = 0; //resets oppacity
  }
  
  //Draws the husk
  @Override void drawEnemy() {
    
    //When the splitter appears on screen
    if (enemyTimer >= 720) {
      oppacity += 5;
    }
    
    //Body
    fill(#F5F5DC, oppacity); //Flesh-like beige
    ellipse(enemyPos.x, enemyPos.y - 20, 20, 25); //Top head
    circle(enemyPos.x - 10, enemyPos.y + 5, 20); //left body circle
    circle(enemyPos.x + 10, enemyPos.y + 5, 20); //right body circle

    //Mouth
    fill(0, oppacity); //Pitch black for mouth
    quad(enemyPos.x - 15, enemyPos.y - 25, enemyPos.x + 5, enemyPos.y - 8, enemyPos.x - 5, enemyPos.y + 10, enemyPos.x - 30, enemyPos.y - 10); //left quad
    quad(enemyPos.x + 15, enemyPos.y - 25, enemyPos.x - 5, enemyPos.y - 8, enemyPos.x + 5, enemyPos.y + 10, enemyPos.x + 30, enemyPos.y - 10); //right quad
    rect(enemyPos.x - 10, enemyPos.y - 5, 20, 30); //bottom rectangle
    
    stroke(0, oppacity); //stroke color for eyes
    strokeWeight(2); //Stroke's weight
    //The stroke, funny enough, actually gives the eyes a jittery effect.
    //While this was not intentional, it gives the husks a lot more life than they had previously. and so, I am keeping it in
    
    //teeth
    fill(255, oppacity); //teeth color
    quad(enemyPos.x - 15, enemyPos.y - 23, enemyPos.x - 12, enemyPos.y - 18, enemyPos.x - 24, enemyPos.y - 6, enemyPos.x - 27, enemyPos.y - 10); //left quad
    quad(enemyPos.x + 15, enemyPos.y - 23, enemyPos.x + 12, enemyPos.y - 18, enemyPos.x + 24, enemyPos.y - 6, enemyPos.x + 27, enemyPos.y - 10); //right quad
    rect(enemyPos.x - 8, enemyPos.y + 18, 15, 5); //bottom rectangle
    //This is done after outlines to give the teeth the same jittery effect of the eyes
  
    if (enemyTimer < 1180){
      fill(238, 75, 43); //Color of eyes (red)
      circle(enemyPos.x - 4, enemyPos.y - 22, 5); //left eye
      circle(enemyPos.x + 4, enemyPos.y - 22, 5); //right eye
    } else { //eyes are bigger and shake from left to right when angered
      fill(238, 75, 43); //Color of eyes (red)
      circle(enemyPos.x - 4 + ((float) Math.sin(frameCount * 0.75) * 1), enemyPos.y - 22, 8); //left eye
      circle(enemyPos.x + 4 + ((float) Math.sin(frameCount * 0.75) * 1), enemyPos.y - 22, 8); //right eye
    }
    noStroke(); //reset back to no stroke
  }

  //Moves the husk
  //Credit to Lucas for helping me understand how to pull this off.
  @Override void move() {
    enemyTimer += 1;
    //Timer waits for roughly 7 seconds before moving the enemy onto the screen
    if (enemyTimer == 720) {
      float posListX[] = {random(player.playerPos.x - 60, player.playerPos.x - 70), random(player.playerPos.x + 60, player.playerPos.x + 70)}; //List of two randomized values that are in a range off of the player's x coordinates
      enemyPos.x = posListX[int(random(0, 2))]; //teleports the splitter somewhere on screen near the player
      float posListY[] = {random(player.playerPos.y - 60, player.playerPos.y - 70), random(player.playerPos.y + 60, player.playerPos.y + 70)}; //List of two randomized values that are in a range off of the player's y coordinates
      enemyPos.y = posListY[int(random(0, 2))]; //teleports the splitter somewhere on screen near the player
    }
    //The randomizing is done this way to both prevent the enemy from telefragging the player and to make them spawn somewhere near the player's position
    
    //Timer waits for roughly 6 seconds before setting behavior to true
    if (enemyTimer >= 1180) {
      behavior = true;
    }
    
    if (behavior == true){ //Movement trigger based on behavior that initiates the Splitter's fast acceleration
      enemySpeed.add(enemyAcc);
    }
    enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed)); //moves very very very slowly towards the player
    
  }
}
