
//Oculus' are a more difficult yet infrequent enemy
//They don't speed up, instead moving at a constant, faster speed
//Additionally, whenever targetted, they'll attempt to move away from the mouse's position.
class Oculus{
  
  PVector ocSpeed = new PVector(); //vector for the Oculus' speed
  PVector ocPos = new PVector(); //vector for the Oculus' position
  
  int points; //the points the oculus will give when killed
  
  //Initializes the oculus
  Oculus(float x, float y){
    //Sets the position of the oculus to the input value
    ocPos.x = x;
    ocPos.y = y;
    
    //Sets the oculus's constant speed
    ocSpeed.x = 0.5;
    ocSpeed.y = 0.5;
    
    points = 0; //sets point to 0 by default (since the points are not called until they are randomized again)
  }
  
  //Draws the oculus
  void drawOculus(){
    
    fill(136, 8, 8); //blood red
    quad(ocPos.x - 15, ocPos.y, ocPos.x, ocPos.y - 25, ocPos.x + 15, ocPos.y, ocPos.x, ocPos.y + 25); //diamond drawn behind the eye of the oculus
    
    fill(245); //greyish white for the eye
    
    circle(ocPos.x, ocPos.y, 30); //eye
    
    fill(0);
    circle((mouseX/20)+(ocPos.x - 9), (mouseY/20)+(ocPos.y - 9), 5); //pupil
    //The pupil works the same way as the froggyFly pupils.
    
  }
  
  //called when the oculos is shot
  //Changes its X and Y coordinates to randomized values using the same method done in setup (just with no looping)
  //It does this by checking the current x and y of the mouse when it is pressed, and if it is within a certain radius of the enemy
  boolean beenShot(float x, float y){
    
    //If statement that checks if the mouse is within a specific radius of the enemy
    if ((x <= (ocPos.x + 15) && x >= (ocPos.x - 15)) && (y <= (ocPos.y + 25) && y >= (ocPos.y - 25))){
      //Credit to asimes https://forum.processing.org/one/topic/how-to-pick-random-value-from-array.html for explaining how to make random choices base on arrays
      float posList[] = {random(530, 540) , random(-130, -140)}; //Chooses a random X or Y Value past 400, or a random X or Y Value off screen past 0 (negative)
      
      //Below is an if statement that works based on increased chances of husks coming from the left/right of the screen rather than the bottom/top
      if (random(0, 10) > 2){
        ocPos.x = random(0, 400); //Chooses a X-value between 0 and 400
        ocPos.y = posList[int(random(0, 2))]; //chooses a random number for the y-value from the array, one which will be on the bottom, and the other on the top
      } else {
        ocPos.x = posList[int(random(0, 2))]; //chooses a random number for the x-value from the array, one which will be on the right, and the other on the left
        ocPos.y = random(0, 400); //Chooses a Y-value between 0 and 400
      }
      
      points = int(random(20, 30)); //sets the points the oculus will give to a random value 
      return true;
    }
    return false;
  }
  
  //returns the enemy's current point value, which is then added to the total score
  int returnPoints(){
    return points;
  }
  
  //returns true or false depending on if the enemy has reached 200, 200 (the center)
  boolean enemyReachedBase(PVector center){
    if ((center.x <= (ocPos.x + 15) && center.x >= (ocPos.x - 15)) && (center.y <= (ocPos.y + 25) && center.y >= (ocPos.y - 25))){ //are the enemy's coordinates 200, 200?
      return true;
    }
    return false;
  }
  
  //Moves the Oculus
  //Credit to Lucas for helping me understand how to pull this off.
  void move(PVector center){

    //adds the next position that the enemy should be at given the directional vector
    //However, this vector also accounts for the position of the mouse, and will attempt to move away from the mouse while still heading towards the center
    //It will do this by taking both vectors (one away from mouse position, and the other towards the center) and finding the vector in-between them
    //This makes its movement quite interesting, making it perhaps not a priority if stalled correctly, but still very scary if ignored
    ocPos.add(directionVector(center));
    
  }
  
  //Calculates the direction vector that the enemy should follow while also accounting for where the mouse is and attempting to move away from it
  PVector directionVector(PVector c){
    
    //Variables
    PVector newPos = new PVector(); //the next coordinates the enemy should be at when the function is called
    PVector bunkerVector = new PVector(); //the vector position that the enemy should move towards
    PVector mouseVector = new PVector(); //the vector position that the enemy should move away from (the mouse)
    
    float dYCenter; //The displacement between the center's Y-value and the enemy's current Y-value
    float dXCenter; //The displacement between the center's X-value and the enemy's current X-value
    
    float dYMouse; //The displacement between the mouse's Y-value and the enemy's current Y-value
    float dXMouse; //The displacement between the mouse's X-value and the enemy's current X-value
    
    float dYFinal; //The displacement between the center directional vector's X-value and the mouse directional vector's X-value
    float dXFinal; //The displacement between the center directional vector's X-value and the mouse directional vector's X-value
    //======Direction Vector towards center======//
    dXCenter = c.x - ocPos.x; //Calculates displacement of x by substracting the two points
    dYCenter = c.y - ocPos.y; //Calculates displacement of y by substracting the two points
    
    //Only difference from the original husk distance vector formula here is that the speed is increased by 1.5 times so that the Oculus does not stall/get pushed too far away
    bunkerVector.y = sin(abs(atan(dYCenter/dXCenter)))*(ocSpeed.y*1.5)*(dYCenter/abs(dYCenter));
    bunkerVector.x = cos(atan(dYCenter/dXCenter))*(ocSpeed.x*1.5)*(dXCenter/abs(dXCenter));
    //Alright, to break the above math down:
    //First and foremost, we find the displacement between each vector by dividing displacementY by displacementX
    //Then, this value is turned into the angle (in radians) by tan inverse, which we then plug into sin for y (Opposite over Hypotenuse) and cos for x (Adjacent over Hypotenuse)
    //This value will then be turned into the velocity vector, and then multiplied by the enemy's speed
    //Finnally, this is then multipled by each corresponding displacement's unit vector
    //Note: The result of atan for sin is turned into an absolute value because the sin function cannot take negative values (although, cosine does not have the problem)
    
    //======Direction Vector Away from the Mouse======//
    dXMouse = mouseX - ocPos.x; //Calculates displacement of x by substracting the two points
    dYMouse = mouseY - ocPos.y; //Calculates displacement of y by substracting the two points
    
    mouseVector.y = sin(abs(atan(dYMouse/dXMouse)))*ocSpeed.y*(dYMouse/abs(dYMouse));
    mouseVector.x = cos(atan(dYMouse/dXMouse))*ocSpeed.x*(dXMouse/abs(dXMouse));
    //Not much of a difference here, which is explained below
    
    //======Final Direction Vector======//
    dXFinal = bunkerVector.x - mouseVector.x; //Calculates displacement of x by substracting the two points
    dYFinal = bunkerVector.y - mouseVector.y; //Calculates displacement of y by substracting the two points
    //Note: the calculation doesn't need to be much different primarily because the difference being calculated already has the mouse vector being substracted
    //If it was the other way around, I'd be a problem, but because this isn't the case, there's not much of a difference between vector calculations
    
    newPos.y = sin(abs(atan(dYFinal/dXFinal)))*ocSpeed.y*(dYFinal/abs(dYFinal));
    newPos.x = cos(atan(dYFinal/dXFinal))*ocSpeed.x*(dXFinal/abs(dXFinal));
    //calculates the FINAL directional vector using the displacement of both the bunker directional vector and the mouse vector
    
    return(newPos); //return this new directional vector
  }
}
