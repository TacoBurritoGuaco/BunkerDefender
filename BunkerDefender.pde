/*
Title: Bunker Defender
 By: Fernando Salas (Student#: 991 721 077)
 Date: Nov 13, 2023
 
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
int gameTime; //timer used for odd time based movement found in enemies like fleshy.
String gameState; //changes the screen to a different screen

//boolean drawnGrass; //Boolean that checks if the grass has been drawn

//Bullet related variables
int bulletNumber; //determines the amount of bullets left
int bulletReload; //determines how long it takes for bullets to reload
int bulletDelay; //determines the delay between bullets shot
boolean bulletOut; //determines if you are out of bullets or not

int tempTimer; //a temporary timer used for anything related to delays
boolean mouseHasBeenPressed; //boolean to check if the mouse has been previously pressed

PVector centerPos = new PVector(); //vector that determines the center's position
Player player = new Player();

Grass[] grassList = new Grass[30]; //list of grass (now an object!)
Husk[] huskList = new Husk[4]; //List of husks
Oculus[] ocList = new Oculus[3]; //List of Oculus (or is it oculi?)
Fleshy[] fleList = new Fleshy[2]; //List of fleshys
//Credit to BUST THOSE GHOSTS! (by Jensen Verlaan) for teaching me how to do these lists!

//Sets up a list that stores all the enemies by storing their different lists
//Might be easier to just use for loops here?
Enemy[][] enemyList = { huskList, ocList, fleList }; //https://stackoverflow.com/questions/4781100/how-to-make-an-array-of-arrays-in-java
//Found out how to do this from here

//======= Setup! =======//
void setup() {
  size(400, 400); //size of the canvas (screen)
  gameState = "Reset"; //sets the screen to the setup screen before the game starts!
}

//======= Draw! =======//
void draw() {
  frameRate(60); //sets the frame rate for timers
  noStroke(); //Set no stroke as the default for shapes (has to be specified)

  //Changing the chain of if statements to a switch statement for optimization
  //Works exactly the same except it uses a switch now
  //Also renamed the variable to make it easier to follow

  //SETUP BEFORE GAME
  switch (gameState) {
  case "Reset":
    
    //resets the location of the player.
    player.playerPos.x = 200;
    player.playerPos.y = 200;
    key = 'w'; //sets your movement to start by default
    
    for (int i = 0; i < grassList.length; i++){
      grassList[i] = new Grass();
    }
    score = 0; //score is set to 0 at default
    gameTime = 0; //gameTime is reset to 0 by default

    bulletNumber = 6; //default number of bulleta
    bulletReload = 0; //counts up to 1.5 seconds by default
    bulletDelay = 0; //counts up to a quarter of a second of delay by default
    bulletOut = false; //set to false by default

    mouseHasBeenPressed = true; //set to true by default to prevent players from spending a bullet right at the game's start

    //Sets the center PVector()'s default positoon
    centerPos.x = 200;
    centerPos.y = 200;
    
    //Initializes the husks in husk list
    for (int i = 0; i < huskList.length; i++){
      huskList[i] = new Husk();
    }
    //Initializes the Oculuses (or is it oculi?) in oculus list
    for (int i = 0; i < ocList.length; i++){
      ocList[i] = new Oculus();
    }
    //Initializes the fleshy's in fleshy list
    for (int i = 0; i < fleList.length; i++){
      fleList[i] = new Fleshy();
    }
    
    gameState = "GameStart"; //sets the screen to game start, and therefore, starts the game!
    break;

    //MAIN GAME
  case "GameStart":
    background(193, 154, 107); //sets the background base color
    
    gameTime += 1; //constantly increases gametime
    
    //draws the grass background for the main screen
    for (int i = 0; i < grassList.length; i++){
      grassList[i].drawGrass();
    }
    
    player.drawPlayer(); //draws the player character
    player.movePlayer(key); //moves the player character

    //For loop within a for loop that draws enemies, moves enemies, and checks if the enemies have reached the player
    for (int i = 0; i < enemyList.length; i++){
      for (int j = 0; j < enemyList[i].length; j++){
        enemyList[i][j].drawEnemy();
        enemyList[i][j].move();
        if (enemyList[i][j].enemyReachedPlayer() == true){
          gameState = "GameOver";
        }
      }
    }
    //draws the one fleshy
    //theOneFleshy.drawFleshy();
    //Moves the one fleshy
    //theOneFleshy.move(centerPos);
    
    drawMark(); //draws the sniper mark over the mouse as well as the dotted line to it

    mousePressed(); //remove later

    drawBullets(bulletNumber); //draws the bullet ui

    fill(255);
    textSize(35);
    text("score: " + score, 10, 30); //score text that updates with every succesful kill

    break;

    case ("GameOver"):
    background(0);

    textAlign(CENTER); //sets textAlign to center
    fill(255);
    textSize(40);
    text("Final score: " + score, 200, 100); //The final score, displayed in the middle of the screen
    textAlign(CORNER); //resets textAlign back to default

    drawButton(200, 300, 80, 80); //draws the button that resets the game using the draw button function (simplified from goopLab)
    break;
  }
}

//======= return score function =======//
//does as it says, returns the score and can be called by the objects
void updateScore(int enemyScore) {
  score += enemyScore;
}

//======= Sniper Mark Function =======//
void drawMark() {

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



//======= Bullet Function =======//
void drawBullets(int bNum) {

  int dis = 0; //variable set to determine the distance between each bullet

  //Draws the empty bullet cases behind the actual bullets
  //Increases distance every loop, creating a new bullet on a different location
  for (int i = 0; i <= 5; i += 1) {
    fill(0);
    triangle(220 + dis, 360, 230 + dis, 340, 240 + dis, 360); //triangle top
    rect(220 + dis, 360, 20, 30); //rectangle body
    arc(230 + dis, 390, 20, 10, 0, PI); //ellipse base
    dis += 30;
  }

  dis = 0; //resets distance back to 0

  //Draws the bullets based on the number of bullets the player currently has
  //Does the same as the previous for loop, but with more detailed colors/additional shapes
  for (int i = 1; i <= bNum; i += 1) {
    fill(129, 133, 137);
    triangle(220 + dis, 360, 230 + dis, 340, 240 + dis, 360); //triangle top

    fill(253, 218, 13); //yellow bullet body and bottom
    rect(220 + dis, 360, 20, 30); //rectangle body
    arc(230 + dis, 390, 20, 10, 0, PI); //ellipse base

    noFill();
    stroke(196, 30, 58); //red stripe on bullet body
    arc(230 + dis, 375, 17, 5, 0, PI); //arc that draws the stripe
    noStroke(); //resets to no stroke

    //additional triangle to give the bullet shape more weight.
    fill(129, 133, 137);
    triangle(220 + dis, 360, 230 + dis, 365, 240 + dis, 360);

    dis += 30;
  }
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
      gameState = "Reset"; //This is the biggest new addition to this code
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


//======= Shooting Bullets Function (Now in MousePressed())=======//
//function that updates the number of bullets whenever the mouse is pressed
//It also prevents bullets from "being fired" if the delay if statement has not turned the mouseHasBeenpressed boolean back to false
//This is done to prevent all the bullets from instantly being used
//Additionally, when all bullets are spent, it also prevents the user from shooting, with a significantly longer delay
//This is done to make the user carefully choose when to and when not to shoot bullets.
//Whats also important is, that this statement additionally detects when the player makes a valid shot
//as such, its secondary use is to detect if the player has succesfully shot an enemy
//NOTE: I have moved the function's, well, functionality to mousePressed() as reccomended previously

void mousePressed() {
  if (mousePressed) { //REMOVE LATER
    if (bulletOut == false) { //if the player is not out of bullets
      if (mouseHasBeenPressed == false) { //if the player has fired a bullet beforehand

        for (int i = 0; i < enemyList.length; i++){
          for (int j = 0; j < enemyList[i].length; j++){
            enemyList[i][j].beenShot();
          }
        }
        //Check if the one fleshy has been shot
        //theOneFleshy.beenShot(mouseX, mouseY);

        bulletNumber -= 1; //always reduces the number of bullets
        mouseHasBeenPressed = true; //sets this boolean to true for delay
        if (bulletNumber <= 0) { //if the bullets are out
          bulletOut = true; //set reload boolean to true
        }
      }
    }
  }

  //If statement that adds slight delay between each shot of the sniper
  if (mouseHasBeenPressed == true) {
    bulletDelay += 1;
    if (bulletDelay >= 15) {
      mouseHasBeenPressed = false;
      bulletDelay = 0; //resets bullet delay
    }
  }

  //If statement that adds delay between bullet reloads
  //Only relevant whenever the user is out of bullets
  if (bulletOut == true) {
    bulletReload += 1;
    if (bulletReload >= 90) {
      bulletOut = false;
      bulletNumber = 6; //resets the number of bullets after reload delay
      bulletReload = 0; //resets bullet delay
    }
  }
}
