//======= return directional vector function =======//
//Calculates the direction vector between two different vectors
//Credit to Lucas for helping with this!
PVector directionVector(PVector a, PVector b, PVector speed){
      
  //Variables
  PVector newPos = new PVector(); //the next coordinates the enemy should be at when the function is called
  float dY; //The displacement between the center's Y-value and the enemy's current Y-value
  float dX; //The displacement between the center's X-value and the enemy's current X-value
  
  //Calculus Stuff (Which, again, was figured out with Lucas in a call)
  dX = a.x - b.x; //Calculates displacement of x by substracting the two points
  dY = a.y - b.y; //Calculates displacement of y by substracting the two points
  
  newPos.y = sin(abs(atan(dY/dX)))*speed.y*(dY/abs(dY));
  newPos.x = cos(atan(dY/dX))*speed.x*(dX/abs(dX));
  //Alright, to break the above math down:
  //First and foremost, we find the displacement between each vector by dividing displacementY by displacementX
  //Then, this value is turned into the angle (in radians) by tan inverse, which we then plug into sin for y (Opposite over Hypotenuse) and cos for x (Adjacent over Hypotenuse)
  //This value will then be turned into the velocity vector, and then multiplied by the enemy's speed
  //Finnally, this is then multipled by each corresponding displacement's unit vector
  //Note: The result of atan for sin is turned into an absolute value because the sin function cannot take negative values (although, cosine does not have the problem)
  
  return(newPos); //return this new directional vector
}
