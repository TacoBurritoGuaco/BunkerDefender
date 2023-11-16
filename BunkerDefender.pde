/*
Title: Bunker Defense
By: Fernando Salas (Student#: 991 721 077)
Date: Oct 25, 2023
 
Programming for Game Designers 1: Fundamentals
Instructor: Nicolas Hesler
 
Description:
- Use the mouse to aim down your sniper sight and press it to destroy the incoming horde of monsters!
- Beware of the husks and their large numbers! they get faster the closer they are!
- Beware of the Oculus and its sights, which avoid your own!
- Be careful though! you only have 3 bullets! if you run out of bullets, you'll have to wait before you can shoot any of the monsters again
- Every time you kill a monster, you gain points!
- If the monsters reach your bunker, you lose! but don't fret, you can always try again by pressing the big red button you'll see afterwards
- The screen you get after your untimely demise will tell you your score! try and see how much higher you can make it!
*/

//Note: I wasn't able to implement a few things, as you will see through my delirious 8-hours of constant coding comments
//Still, I think the final product is quite nice! its not quite what I wished it could have been, but I am still quite proud of what I accomplished
//(It also meets all the requirements so there's that)
//Once again, I hope you enjoy it!


//======= Initializing variables  =======//
int score; //score value
String screen; //changes the screen to a different screen

//boolean drawnGrass; //Boolean that checks if the grass has been drawn

//Bullet related variables
int bulletNumber; //determines the amount of bullets left
int bulletReload; //determines how long it takes for bullets to reload
int bulletDelay; //determines the delay between bullets shot
boolean bulletOut; //determines if you are out of bullets or not

int tempTimer; //a temporary timer used for anything related to delays
boolean mouseHasBeenPressed; //boolean to check if the mouse has been previously pressed

PVector centerPos = new PVector(); //vector that determines the center's position

Husk[] huskList = new Husk[5]; //List of husks
Oculus[] ocList = new Oculus[2]; //List of Oculus (or is it oculi?)
//Credit to BUST THOSE GHOSTS! (by Jensen Verlaan) for teaching me how to do these lists!

//Fleshy theOneFleshy;
//Was going to add a fleshy cube monster, as the plans show, but given the time? that is simply NOT possible
//There is just something NOT working correctly there. I've been trying to implement his x and y movement but it is simply just NOT working
//As such, I have made the decision to cut him from the final version
//this will still meet EVERY requirement, it will just not include fleshy
//I hope thats alright, sorry I couldn't figure it out D:

//======= Setup! =======//
void setup(){
  size(400, 400); //size of the canvas (screen)
  
  screen = "Reset"; //sets the screen to the setup screen before the game starts!

}

//======= Draw! =======//
void draw(){
  frameRate(60); //sets the frame rate for timers
  noStroke(); //Set no stroke as the default for shapes (has to be specified)
  
  if (screen == "Reset"){ //SETUP BEFORE GAME
  score = 0; //score is set to 0 at default
  
  bulletNumber = 3; //default number of bulleta
  bulletReload = 0; //counts up to 1.5 seconds by default
  bulletDelay = 0; //counts up to a quarter of a second of delay by default
  bulletOut = false; //set to false by default
  
  mouseHasBeenPressed = true; //set to true by default to prevent players from spending a bullet right at the game's start
  
  //Sets the center PVector()'s default positoon
  centerPos.x = 200;
  centerPos.y = 200;
  
  //For loop that adds all the husks to the program
  for (int i = 0; i < huskList.length; i+=1){
    
    //Credit to asimes https://forum.processing.org/one/topic/how-to-pick-random-value-from-array.html for explaining how to make random choices base on arrays
    float posList[] = {random(410, 420) , random(-10, -20)}; //Chooses a random X or Y Value past 400, or a random X or Y Value off screen past 0 (negative)
    
    //Below is an if statement that works based on increased chances of husks coming from the left/right of the screen rather than the bottom/top
    if (random(0, 10) > 4){
      huskList[i] = new Husk(posList[int(random(0, 2))], random(0, 400)); //chooses a random number for the x-value from the array, one which will be on the right, and the other on the left
      //Chooses a Y-value between 0 and 400
      //Creates a new husk in these coordinates
    } else {
      huskList[i] = new Husk(random(0, 400), posList[int(random(0, 2))]); //chooses a random number for the y-value from the array, one which will be on the bottom, and the other on the top
      //Chooses a X-value between 0 and 400
      //Creates a new husk in these coordinates
    }
  }
  
  //For loop that adds all the Oculus to the program
  for (int i = 0; i < ocList.length; i+=1){
    
    //Credit to asimes https://forum.processing.org/one/topic/how-to-pick-random-value-from-array.html for explaining how to make random choices base on arrays
    float posList[] = {random(550, 560) , random(-150, -160)}; //Chooses a random X or Y Value past 400, or a random X or Y Value off screen past 0 (negative)
    
    //Below is an if statement that works based on increased chances of Oculus coming from the bottom/top of the screen rather than the left/right
    if (random(0, 10) > 2){
      ocList[i] = new Oculus(random(0, 400), posList[int(random(0, 2))]); //chooses a random number for the y-value from the array, one which will be on the bottom, and the other on the top
      //Chooses a X-value between 0 and 400
      //Creates a new oculus in these coordinates
    } else {
      ocList[i] = new Oculus(posList[int(random(0, 2))], random(0, 400)); //chooses a random number for the x-value from the array, one which will be on the right, and the other on the left
      //Chooses a Y-value between 0 and 400
      //Creates a new oculus in these coordinates
    }
    
    screen = "GameStart"; //sets the screen to game start, and therefore, starts the game!
  }
    
  }if (screen == "GameStart"){ //MAIN GAME
    background(193, 154, 107); //sets the background base color
    
    drawBunk(); //draws the titular bunker in the middle of the screen!
    
    //For loop that draws and moves all the husks
    for (int i = 0; i < huskList.length; i+=1){
      huskList[i].drawHusk();
      huskList[i].move(centerPos);
    }
    //For loop that draws and moves all the oculus
    for (int i = 0; i < ocList.length; i+=1){
      ocList[i].drawOculus();
      ocList[i].move(centerPos);
    }
    //draws the one fleshy
    //theOneFleshy.drawFleshy();
    //Moves the one fleshy
    //theOneFleshy.move(centerPos);
    
    drawMark(); //draws the sniper mark over the mouse as well as the dotted line to it
    
    bulletShot(); //function that detects when a bullet has been shot by the player, and either delays when the next bullet can be shot, or gives reloading more bullets (if they run out) delay.
    //previously an if statement, but was turned into a function for significantly better code readability
    
    drawBullets(bulletNumber); //draws the bullet ui
    
    fill(255);
    textSize(35);
    text("score: " + score, 10, 30); //score text that updates with every succesful kill
    
    //For loop that checks if a husk has reached the bunker
    for (int i = 0; i < huskList.length; i+=1){
      if (huskList[i].enemyReachedBase(centerPos) == true){
        screen = "GameOver";
      }
    }
    //For loop that checks if an oculus has reached the bunker
    for (int i = 0; i < ocList.length; i+=1){
      if (ocList[i].enemyReachedBase(centerPos) == true){
        screen = "GameOver";
      }
    }
  } if (screen == "GameOver") { //GAME OVER SCREEN
    background(0);
    
    drawBunk(); //draws the titular bunker in the middle of the screen! (Except now you are dead so its not as cool)
    //Note: This is done on purpose to make the game over screen feel a little more alive
    
    textAlign(CENTER); //sets textAlign to center
    fill(255);
    textSize(40);
    text("Final score: " + score, 200, 100); //The final score, displayed in the middle of the screen
    textAlign(CORNER); //resets textAlign back to default
    
    drawButton(200, 300, 80, 80); //draws the button that resets the game using the draw button function (simplified from goopLab)
  }
}

//======= return score function =======//
//does as it says, returns the score and can be called by the objects
void updateScore(int enemyScore){
  score += enemyScore;
}

//======= Sniper Mark Function =======//
void drawMark(){
  
  //Draws the circle
  noFill();
  stroke(255, 20, 20);
  strokeWeight(5);
  circle(mouseX, mouseY, 60);
  
  //Draws both rectangles that converge at the center of the circle
  noStroke();
  fill(255, 20, 20);
  rect(mouseX - 30, mouseY - 2, 60, 5);
  rect(mouseX - 2, mouseY - 30, 5, 60);
}

//======= Shooting Bullets Function =======//
//function that updates the number of bullets whenever the mouse is pressed
//It also prevents bullets from "being fired" if the delay if statement has not turned the mouseHasBeenpressed boolean back to false
//This is done to prevent all the bullets from instantly being used
//Additionally, when all bullets are spent, it also prevents the user from shooting, with a significantly longer delay
//This is done to make the user carefully choose when to and when not to shoot bullets.
//Whats also important is, that this statement additionally detects when the player makes a valid shot
//as such, its secondary use is to detect if the player has succesfully shot an enemy
void bulletShot(){
  if (mousePressed){ //if the mouse is pressed
    if (bulletOut == false){ //if the player is not out of bullets
      if (mouseHasBeenPressed == false){ //if the player has fired a bullet beforehand
        
        //For loop that checks if a husk was shot and which husk was shot
        for (int i = 0; i < huskList.length; i+=1){
          if (huskList[i].beenShot(mouseX, mouseY) == true){
            score += huskList[i].returnPoints(); //update the score if a husk has been succesfully killed
          }
        }
        //For loop that checks if an oculus was shot and which oculus was shot
        for (int i = 0; i < ocList.length; i+=1){
          if (ocList[i].beenShot(mouseX, mouseY) == true){
            score += ocList[i].returnPoints(); //likewise, update the score if an oculus has been killed
          }
        }
        //Check if the one fleshy has been shot
        //theOneFleshy.beenShot(mouseX, mouseY);
        
        bulletNumber -= 1; //always reduces the number of bullets
        mouseHasBeenPressed = true; //sets this boolean to true for delay
        if (bulletNumber <= 0){ //if the bullets are out
          bulletOut = true; //set reload boolean to true
        }
      }
    }
  }
  
  //If statement that adds slight delay between each shot of the sniper
  if (mouseHasBeenPressed == true){
    bulletDelay += 1;
    if (bulletDelay >= 15){
      mouseHasBeenPressed = false;
      bulletDelay = 0; //resets bullet delay
    }
  }
  
  //If statement that adds delay between bullet reloads
  //Only relevant whenever the user is out of bullets
  if (bulletOut == true){
    bulletReload += 1;
    if (bulletReload >= 90){
      bulletOut = false;
      bulletNumber = 3; //resets the number of bullets after reload delay
      bulletReload = 0; //resets bullet delay
    }
  }
}

//======= Bullet Function =======//
void drawBullets(int bNum){
  
  int dis = 0; //variable set to determine the distance between each bullet
  
  //Draws the empty bullet cases behind the actual bullets
  //Increases distance every loop, creating a new bullet on a different location
  for (int i = 0; i <= 2; i += 1){
    fill(0);
    triangle(300 + dis, 360, 310 + dis, 340, 320 + dis, 360); //triangle top
    rect(300 + dis, 360, 20, 30); //rectangle body
    arc(310 + dis, 390, 20, 10, 0, PI); //ellipse base
    dis += 30;
  }
  
  dis = 0; //resets distance back to 0
  
  //Draws the bullets based on the number of bullets the player currently has
  //Does the same as the previous for loop, but with more detailed colors/additional shapes
  for (int i = 1; i <= bNum; i += 1){
    fill(129, 133, 137);
    triangle(300 + dis, 360, 310 + dis, 340, 320 + dis, 360); //triangle top
    
    fill(253, 218, 13); //yellow bullet body and bottom
    rect(300 + dis, 360, 20, 30); //rectangle body
    arc(310 + dis, 390, 20, 10, 0, PI); //ellipse base
    
    noFill();
    stroke(196, 30, 58); //red stripe on bullet body
    arc(310 + dis, 375, 17, 5, 0, PI); //arc that draws the stripe
    noStroke(); //resets to no stroke
    
    //additional triangle to give the bullet shape more weight.
    fill(129, 133, 137);
    triangle(300 + dis, 360, 310 + dis, 365, 320 + dis, 360);
    
    dis += 30;
  }
}

//======= Draw Bunker function =======//
void drawBunk(){
  
  //Draw the shadows under the bunker (to simulate sunken ground)
  fill(0, 0, 0, 30); //only need to set oppacity once because the circles layer over one another
  ellipse(200, 220, 80, 40); //first circle
  ellipse(200, 220, 100, 45); //second circle
  ellipse(200, 220, 120, 50); //third circle
  
  fill(150);
  quad(170, 220, 190, 180, 210, 180, 230, 220); //base of bunker
  
  fill(0);
  triangle(190, 220, 200, 200, 210, 220); //door to bunker
  
  fill(200, 0, 0);
  rect(200, 150, 30, 20); //draw the flag
  
  stroke(250);
  strokeWeight(5);
  line(200, 180, 200, 140); //draws the flag pole
  
  noStroke(); //resets back to no stroke
}

//Thank the lord for reusable code, halleluyah
//===================BUTTON FUNCTION====================//
//"Draw button" function originally from train function example
// Tweaks have been made to allow the function to take inputs (and as such, draw multiple different buttons)
// This is done, similarly to how it is done for goop's eyes and mouths, to save space
//In this case, this function specifically draws buttons that change the number of eyes on goop.
void drawButton(int coordX, int coordY, int buttonWidth, int buttonHeight) {
  
  stroke(5); //sets the outline for the button
  //buttons have an outline because they are important elements of the program (like goop)

  if (mouseIsOver(coordX, coordY, buttonWidth, buttonHeight)) {
    if (mousePressed) {
      screen = "Reset"; //This is the biggest new addition to this code
      //It sets the screen mode to "reset", which resets every variable and enemy back to their original positions set in setup
      //As such, everything that would otherwise be in setup can simply be moved to reset instead, saving space (other than the canvas size and the screenMode itself)
      
      //when the mouse is over the shape and the mouse button is down
      //set the color to extra-highlighted
      fill(255, 123, 123);
    } else {
        
      //when the mouse is over the shape, highlight it
      fill(230, 83, 83);
    }
  } else {
    
    //when the mouse is not over the shape, set the color to red
    fill(210, 43, 43);
  }
  
  //draw the button shape (ellipse)
  ellipse(coordX, coordY, buttonWidth, buttonHeight);
  noStroke();
}

//===================MOUSE DETECTION FUNCTION====================//
//also originally found in the train function example
//I decided to give this functions inputs as well because I realized the values it was using before were already correspondant to the values in the original "Draw Button" function
//as such, once again, this saves a lot of time and space. Gotta love optimizing code!
//Of note is the additional substraction done that makes the area covered larger. I did this to both work around the buttons now being ellipses and to also give the hitbox of the buttons more leniancy
//That way, when accidentally clicks slightly off the button, they still click the button. 
//This is specially prevelant given how small some of the buttons in my code are, and as such, I am including it in the comments.
boolean mouseIsOver(int clickX, int clickY, int clickWidth, int clickHeight) {
  if (mouseX > clickX-clickWidth && mouseX < clickX+clickWidth && mouseY > clickY-clickHeight && mouseY < clickY+clickHeight) {
    return true;
  } else {
    return false;
  }
}

//======= Grass Function =======//
//grass function is too complicated for the program right now
//I am, also, cutting this one
//void drawGrass(){
//}
