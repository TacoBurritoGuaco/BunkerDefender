
//This is the class that all other enemies will inherit their base behavior from
class Enemy{
  
  //This determines the position of the enemy, its movement (using a directional vector formula outlined below) and its acceleration.
  PVector enemyAcc = new PVector(); //vector values used for acceleration x and y
  PVector enemySpeed = new PVector(); //vector values used to store speed x and y
  PVector enemyPos = new PVector(); //the position vector (most important)
  
  //The length and width of the enemy used in collision code
  int enemyLength;
  int enemyWidth;
  
  int points; //The points the enemy will give
  int health; //The health the enemy has
  float randRange; //value that determines the range of the random values being inputted
  float weightChance; //value that weights the chance for the enemy to spawn either from the sides or from the top
  
  //Initializes the husk
  Enemy(){
    //default Position (input value)
    //Change to a public function that returns the player's pVector position 
    enemyPos.x = x; 
    enemyPos.y = y;
    //default speed
    enemySpeed.x = 0.3;
    enemySpeed.y = 0.3;
    //default acceleration
    enemyAcc.x = 0.001;
    enemyAcc.y = 0.001;
    
    //sets to default enemy length and width
    enemyLength = 20;
    enemyWidth = 10;
    
    points = 0; //sets point to 0 by default (since the points are not called until they are randomized again)
    health = 1; //sets health to a default of 1
    randRange = 40; //the default range added/substracted from the random values in the "beenShot" function
    weightChance = 4; //the default weight of the enemy spawns
  }
  
  void resetEnemy(){
    //resets to default speed
    enemySpeed.x = 0.3;
    enemySpeed.y = 0.3; 
    points = int(random(0 + randRange, 5 + randRange)); //Resets how many points the enemy gives
    health = 1; //resets the enemy's health
  }
  
  //Called whenever an enemy is shot. Uses the player object's current pVector x and y coordinates
  boolean beenShot(){
    
    float x = mouseX;
    float y = mouseY;
    
    //If statement that checks if the mouse is within a specific radius of the enemy
    if ((x <= (enemyPos.x + enemyWidth) && x >= (enemyPos.x - enemyWidth)) && (y <= (enemyPos.y + enemyLength) && y >= (enemyPos.y - enemyLength))){
      //Credit to asimes https://forum.processing.org/one/topic/how-to-pick-random-value-from-array.html for explaining how to make random choices base on arrays
      float posList[] = {random(400 + randRange, 420 + randRange) , random(0 - randRange, -20 - randRange)}; //Chooses a random X or Y Value past 400, or a random X or Y Value off screen past 0 (negative)
      
      //Below is an if statement that works based on increased chances of husks coming from the left/right of the screen rather than the bottom/top
      if (random(0, 10) > weightChance){
        enemyPos.x = posList[int(random(0, 2))]; //chooses a random number for the x-value from the array, one which will be on the right, and the other on the left
        enemyPos.y = random(0, 400); //Chooses a Y-value between 0 and 400
      } else {
        enemyPos.x = random(0, 400); //Chooses a X-value between 0 and 400
        enemyPos.y = posList[int(random(0, 2))]; //chooses a random number for the y-value from the array, one which will be on the bottom, and the other on the top
      }
      this.resetEnemy();
      return true; //returns true
    }
    return false; //returns false by default
  }
  
  //returns the enemy's current point value, which is then added to the total score
  int returnPoints(){
    return points;
  }
  
  //returns true or false depending on if the enemy has reached the player's PVector() position
  boolean enemyReachedPlayer(){
    if ((center.x <= (huskPos.x + enemyWidth) && center.x >= (huskPos.x - enemyWidth)) && (center.y <= (huskPos.y + enemyLength) && center.y >= (huskPos.y - enemyLength))){ //is the enemy overlaping the player
      return true;
    }
    return false;
  }
  
  //Empty enemy draw function; gets overriden by the enemy inheriting it
  void drawEnemy(){
  }
  
  //empty movement option that is overriden
  void move(){
  }
}
