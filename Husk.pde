
//husks are the basic enemy in the game. They will move towards the bunker
//from somewhere off screen and get increasingly faster as they do so.
class Husk{
  
  //Note: First attempt at understanding vectors, and promptly using them in my program
  //As such, I will describe my understanding of these particular vectors throughtly.
  PVector huskAcc = new PVector(); //vector values used for acceleration x and y
  PVector huskSpeed = new PVector(); //vector values used to store speed x and y
  PVector huskPos = new PVector(); //the position vector (most important)
  //This determines the position of the husk, its movement (using a directional vector formula outlined below) etc.
  
  int points; //the points the husk will give when killed
  
  //Initializes the husk
  Husk(float x, float y){
    //Sets the position of the husk to the input value
    huskPos.x = x;
    huskPos.y = y;
    
    //Sets the husk's default speed
    huskSpeed.x = 0.3;
    huskSpeed.y = 0.3;
    
    //Sets the husk's default acceleration
    huskAcc.x = 0.001;
    huskAcc.y = 0.001;
    
    points = 0; //sets point to 0 by default (since the points are not called until they are randomized again)
  }
  
  //Draws the husk
  void drawHusk(){
    
    //Mouth
    fill(180, 196, 36); //zombie green
    arc(huskPos.x, huskPos.y + 5, 20, 20, 0, PI); //bottom jaw
    arc(huskPos.x, huskPos.y - 5, 20, 20, PI, TWO_PI); //top jaw
    
    //Teeth
    fill(234, 221, 202); //teeth color
    triangle(huskPos.x - 10, huskPos.y - 5, huskPos.x - 7, huskPos.y + 5, huskPos.x - 5, huskPos.y - 5); //first tooth
    triangle(huskPos.x - 5, huskPos.y - 5, huskPos.x, huskPos.y + 5, huskPos.x + 5, huskPos.y - 5); //second tooth
    triangle(huskPos.x + 5, huskPos.y - 5, huskPos.x + 7, huskPos.y + 5, huskPos.x + 10, huskPos.y - 5); //third tooth
    
    stroke(0); //stroke color for eyes
    strokeWeight(2); //Stroke's weight
    //The stroke, funny enough, actually gives the eyes a jittery effect.
    //While this was not intentional, it gives the husks a lot more life than they had previously. and so, I am keeping it in
    
    fill(255, 191, 0); //Color of eyes (yellow)
    circle(huskPos.x - 8, huskPos.y - 10, 10); //left eye
    circle(huskPos.x + 8, huskPos.y - 7, 8); //right eye
    noStroke(); //reset back to no stroke
  }
  
  //called when the husk is shot
  //Changes its X and Y coordinates to randomized values using the same method done in setup (just with no looping)
  //It does this by checking the current x and y of the mouse when it is pressed, and if it is within a certain radius of the enemy
  boolean beenShot(float x, float y){
    
    //If statement that checks if the mouse is within a specific radius of the enemy
    if ((x <= (huskPos.x + 10) && x >= (huskPos.x - 10)) && (y <= (huskPos.y + 20) && y >= (huskPos.y - 20))){
      //Credit to asimes https://forum.processing.org/one/topic/how-to-pick-random-value-from-array.html for explaining how to make random choices base on arrays
      float posList[] = {random(440, 460) , random(-40, -60)}; //Chooses a random X or Y Value past 400, or a random X or Y Value off screen past 0 (negative)
      
      //Below is an if statement that works based on increased chances of husks coming from the left/right of the screen rather than the bottom/top
      if (random(0, 10) > 4){
        huskPos.x = posList[int(random(0, 2))]; //chooses a random number for the x-value from the array, one which will be on the right, and the other on the left
        huskPos.y = random(0, 400); //Chooses a Y-value between 0 and 400
      } else {
        huskPos.x = random(0, 400); //Chooses a X-value between 0 and 400
        huskPos.y = posList[int(random(0, 2))]; //chooses a random number for the y-value from the array, one which will be on the bottom, and the other on the top
      }
      //resets the husk's speed (because it accelerates)
      huskSpeed.x = 0.3; 
      huskSpeed.y = 0.3;
      points = int(random(10, 15)); //sets the points the husk will give to a random value 
      return true; //returns true
    }
    return false; //returns false by default
  }
  
  //returns the enemy's current point value, which is then added to the total score
  int returnPoints(){
    return points;
  }
  
  //returns true or false depending on if the enemy has reached 200, 200 (the center)
  boolean enemyReachedBase(PVector center){
    if ((center.x <= (huskPos.x + 10) && center.x >= (huskPos.x - 10)) && (center.y <= (huskPos.y + 20) && center.y >= (huskPos.y - 20))){ //are the enemy's coordinates 200, 200?
      return true;
    }
    return false;
  }
  
  //Moves the husk
  //Credit to Lucas for helping me understand how to pull this off.
  void move(PVector center){

    //Checks if the husk is almost on screen (within the parameters given)
    //Then, increases the speed of the husk by acceleration
    if ((huskPos.x <= width + 20 && huskPos.x >= 0 - 20) && (huskPos.y <= height + 30 && huskPos.y >= 0 - 30)){
      huskSpeed.add(huskAcc);
    }
    //adds the next position that the enemy should be at given the directional vector
    huskPos.add(directionVector(center)); 
  }
  
  //Calculates the direction vector that the enemy should follow
  //Credit to Lucas for helping with this!
  PVector directionVector(PVector c){
    
    //Variables
    PVector newPos = new PVector(); //the next coordinates the enemy should be at when the function is called
    float dY; //The displacement between the center's Y-value and the enemy's current Y-value
    float dX; //The displacement between the center's X-value and the enemy's current X-value
    
    //Calculus Stuff (Which, again, was figured out with Lucas in a call)
    dX = c.x - huskPos.x; //Calculates displacement of x by substracting the two points
    dY = c.y - huskPos.y; //Calculates displacement of y by substracting the two points
    
    newPos.y = sin(abs(atan(dY/dX)))*huskSpeed.y*(dY/abs(dY));
    newPos.x = cos(atan(dY/dX))*huskSpeed.x*(dX/abs(dX));
    //Alright, to break the above math down:
    //First and foremost, we find the displacement between each vector by dividing displacementY by displacementX
    //Then, this value is turned into the angle (in radians) by tan inverse, which we then plug into sin for y (Opposite over Hypotenuse) and cos for x (Adjacent over Hypotenuse)
    //This value will then be turned into the velocity vector, and then multiplied by the enemy's speed
    //Finnally, this is then multipled by each corresponding displacement's unit vector
    //Note: The result of atan for sin is turned into an absolute value because the sin function cannot take negative values (although, cosine does not have the problem)
    
    return(newPos); //return this new directional vector
  }
}
