
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
  
  //Initializes the enemy
  Enemy(){
    
    health = 1; //sets health to a default of 1
    randRange = 40; //the default range added/substracted from the random values in the "beenShot" function
    points = int(random(0 + randRange, 5 + randRange)); //sets point to 0 by default (since the points are not called until they are randomized again)
    weightChance = 4; //the default weight of the enemy spawns
    
    //default Position (input value)
    //Change to a public function that returns the player's pVector position 
    enemyPos.x = enemyLoc(randRange, weightChance).x; 
    enemyPos.y = enemyLoc(randRange, weightChance).y;
    //default speed
    enemySpeed.x = 0.3;
    enemySpeed.y = 0.3;
    //default acceleration
    enemyAcc.x = 0.001;
    enemyAcc.y = 0.001;
    
    //sets to default enemy length and width
    enemyLength = 20;
    enemyWidth = 10;
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
    //if statement that determines if the mouse is within the enemy's hitbox
    if ((mouseX <= (this.enemyPos.x + this.enemyWidth) && mouseX >= (this.enemyPos.x - this.enemyWidth)) && (mouseY <= (this.enemyPos.y + this.enemyLength) && mouseY >= (this.enemyPos.y - this.enemyLength))){
      //When called, sets this enemy's position to a random position off-screen
      this.enemyPos.x = enemyLoc(randRange, weightChance).x;
      this.enemyPos.y = enemyLoc(randRange, weightChance).y;
      resetEnemy(); //resets this enemy's variables
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
    if ((playerPos.x <= (this.enemyPos.x + this.enemyWidth) && playerPos.x >= (this.enemyPos.x - this.enemyWidth)) && (playerPos.y <= (this.enemyPos.y + this.enemyLength) && playerPos.y >= (this.enemyPos.y - this.enemyLength))){ //is the enemy overlaping the player
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
