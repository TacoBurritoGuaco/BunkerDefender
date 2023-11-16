

//=====IMPORTANT!=======//
//This code goes unused, and is only here in case you want to see what I could have potentially fixed about it
//And also because its not good practice to throw all that effort away, even if it didn't really make it into the final version
//Hope you enjoy going through it at least!
//======================//


//Fleshy's are the strongest, yet most infrequent enemy
//They can take 3 bullet shots, and while the move slow, their acceleration is very high, only remedied by their method of movement
//Rather than move diagonally, fleshy's move horizontally and vertically.
class Fleshy{
  
  PVector flesAcc = new PVector(); //vector values used for acceleration x and y
  PVector flesSpeed = new PVector(); //vector values used to store speed x and y
  PVector flesPos = new PVector(); //the position vector (most important)
  int bulk; //the amount of extra shots it takes to kill a fleshy
  
  //Initializes the fleshy
  Fleshy(float x, float y){
    //Sets the position of the fleshy to the input value
    flesPos.x = x;
    flesPos.y = y;
    
    //Sets the fleshy's default speed
    flesSpeed.x = 0.1;
    flesSpeed.y = 0.1;
    
    //Sets the fleshy's default acceleration
    flesAcc.x = 0.1;
    flesAcc.y = 0.1;
    
    bulk = 2; //sets the fleshy's default bulk
  }
  
  //Draws the fleshy
  void drawFleshy(){
    rectMode(CENTER);//Sets to center to more easily determine where fleshy should be drawn
    
    fill(136, 8, 8); //blood red
    rect(flesPos.x, flesPos.y, 40, 40); //body
    
    //side triangles
    
    //mouth
    fill(0);
    rect(flesPos.x, flesPos.y, 20, 20); //mouth (with no teeth)
    
    fill(255); //pearly whites!
    rect(flesPos.x, flesPos.y + random(8, 10), 20, 5); //bottom teeth
    rect(flesPos.x, flesPos.y - random(8, 10), 20, 5); //upper teeth
    //Note: these teeth clatter just like the ones in goopLab (using random)
    
    rectMode(CORNER);//resets back to default corner
  }
  
  //called when the husk is shot
  //Changes its X and Y coordinates to randomized values using the same method done in setup (just with no looping)
  //It does this by checking the current x and y of the mouse when it is pressed, and if it is within a certain radius of the enemy
  void beenShot(float x, float y){
    
    //If statement that checks fleshy's health
    if (bulk <= 0){
      //If statement that checks if the mouse is within a specific radius of the enemy
      if ((x <= (flesPos.x + 10) && x >= (flesPos.x - 10)) && (y <= (flesPos.y + 20) && y >= (flesPos.y - 20))){
        //Credit to asimes https://forum.processing.org/one/topic/how-to-pick-random-value-from-array.html for explaining how to make random choices base on arrays
        float posList[] = {random(440, 460) , random(-40, -60)}; //Chooses a random X or Y Value past 400, or a random X or Y Value off screen past 0 (negative)
        
        //Below is an if statement that works based on increased chances of fleshy coming from the left/right of the screen rather than the bottom/top
        if (random(0, 10) > 2){
          flesPos.x = posList[int(random(0, 2))]; //chooses a random number for the x-value from the array, one which will be on the right, and the other on the left
          flesPos.y = random(0, 400); //Chooses a Y-value between 0 and 400
        } else {
          flesPos.x = random(0, 400); //Chooses a X-value between 0 and 400
          flesPos.y = posList[int(random(0, 2))]; //chooses a random number for the y-value from the array, one which will be on the bottom, and the other on the top
        }
        //resets the husk's speed (because it accelerates)
        flesSpeed.x = 0.3; 
        flesSpeed.y = 0.3;
        
        //Resets fleshy's bulk back to 2
        bulk = 2;
        
      }
    } else {
      bulk -= 1;
    }
  }
  
  //Moves the fleshy
  //Fleshy, once again, moves on the x and y axis separately.
  //This is pulled off using a variety of floats, booleans, and if statements to determine when should and when should it not switch direction
  //Credit to Lucas for helping me understand how to pull this off.
  void move(PVector center){
    
    if (frameCount/30 == 0){
      flesSpeed.add(flesAcc.x, 0);
      flesPos.add(directionVector(center).x, 0);
      if (directionVector(center).x == 0){
        flesPos.add(0, flesSpeed.x);
      }
    } else {
      flesSpeed.add(0, flesAcc.y);
      flesPos.add(0, directionVector(center).y);
      if (directionVector(center).y == 0){
        flesPos.add(0, flesSpeed.y);
      }
    }
  }
    
  //Calculates the direction vector that the enemy should follow
  //Credit to Lucas for helping with this!
  PVector directionVector(PVector c){
    
    //Variables
    PVector newPos = new PVector(); //the next coordinates the enemy should be at when the function is called
    float dY; //The displacement between the center's Y-value and the enemy's current Y-value
    float dX; //The displacement between the center's X-value and the enemy's current X-value
    
    //Calculus Stuff (Which, again, was figured out with Lucas in a call)
    dX = c.x - flesPos.x; //Calculates displacement of x by substracting the two points
    dY = c.y - flesPos.y; //Calculates displacement of y by substracting the two points
    
    newPos.y = sin(abs(atan(dY/dX)))*flesSpeed.y*(dY/abs(dY));
    newPos.x = cos(abs(atan(dY/dX)))*flesSpeed.x*(dX/abs(dX));
    //Alright, to break the above math down:
    //First and foremost, we find the displacement between each vector by dividing displacementY by displacementX
    //Then, this value is turned into the angle (in radians) by tan inverse, which we then plug into sin for y (Opposite over Hypotenuse) and cos for x (Adjacent over Hypotenuse)
    //This value will then be turned into the velocity vector, and then multiplied by the enemy's speed
    //Finnally, this is then multipled by each corresponding displacement's unit vector
    //Note: The result of atan for sin is turned into an absolute value because the sin function cannot take negative values (although, cosine does not have the problem)
    
    return(newPos); //return this new directional vector
  }
}
