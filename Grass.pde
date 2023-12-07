
//Object used for drawing the grass on the main screen
//This is done to optimize this process, as well as to add nice decoration onto the screen
public class Grass {
  PVector grassPos = new PVector(); //the position vector of the player
  int type;
  
  Grass(){
    //sets the grass position to a random location
    grassPos.x = random(0, 400);
    grassPos.y = random(0, 400);
    
    //chooses a random number between 1, 2, and 3
    type = int(random(1, 4));
  }
  
  void drawGrass(){
    switch(type){
      //first grass variant
      case (1):
      //shadow
      fill(0,0,0, 100);
      ellipse(grassPos.x, grassPos.y, 25, 10);
      //grass section
      fill(#464033);
      triangle(grassPos.x + 10, grassPos.y, grassPos.x, grassPos.y - 20, grassPos.x - 10, grassPos.y);
      
      
      break;
      
      //second grass variant
      case(2):
      //shadow
      fill(0,0,0, 100);
      ellipse(grassPos.x, grassPos.y, 25, 10);
      //grass sections
      fill(#464033);
      triangle(grassPos.x -10, grassPos.y, grassPos.x -20, grassPos.y - 20, grassPos.x + 5, grassPos.y);
      triangle(grassPos.x +10, grassPos.y, grassPos.x +20, grassPos.y - 20, grassPos.x - 5, grassPos.y);
      break;
      
      //Third grass variant
      case(3):
      //shadow
      fill(0,0,0, 100);
      ellipse(grassPos.x, grassPos.y, 50, 15);
      fill(#464033);
      triangle(grassPos.x -20, grassPos.y, grassPos.x -30, grassPos.y - 30, grassPos.x , grassPos.y);
      triangle(grassPos.x +20, grassPos.y, grassPos.x +30, grassPos.y - 30, grassPos.x , grassPos.y);
      triangle(grassPos.x + 10, grassPos.y, grassPos.x, grassPos.y - 20, grassPos.x - 10, grassPos.y);
      break;
    }
  }
}
