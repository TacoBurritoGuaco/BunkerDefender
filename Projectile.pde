//Projectile class used by enemies that shoot projectiles
class Projectile {
  //This determines the position of the projectile, its movement and its acceleration.
  PVector projAcc = new PVector(); //vector values used for acceleration x and y
  PVector projSpeed = new PVector(); //vector values used to store speed x and y
  PVector projPos = new PVector(); //the position vector (most important)
  
  PVector playerLast = new PVector(); //the last position the player was on

  //The length and width of the projectile used 
  int projLength;
  int projWidth;
  Projectile(float xCoord, float yCoord, PVector lastPlayerPos) {

    //projectile position based on input values given to it when created
    projPos.x = xCoord;
    projPos.y = yCoord;
    //default speed
    projSpeed.x = 1;
    projSpeed.y = 1;
    
    //This takes the last player pos only when initialized, making it so it does not track the player like the enemies
    playerLast = directionVector(lastPlayerPos, this.projPos, this.projSpeed);

    //sets to default proj length and width
    projLength = 10;
    projWidth = 10;
  }
  
  //returns true or false depending on if the proj has reached the player's PVector() position
  boolean projReachedPlayer() {
    if ((player.playerPos.x <= (this.projPos.x + this.projWidth) && player.playerPos.x >= (this.projPos.x - this.projWidth)) && (player.playerPos.y <= (this.projPos.y + this.projLength) && player.playerPos.y >= (this.projPos.y - this.projLength))) { //is the proj overlaping the player
      return true;
    }
    return false;
  }
  
  //Draws the projectile shot by all enemies
  void drawProjectile() {
    
    //Projectile is simple but uses colors that are not used in other places to stand out
    stroke(112, 41, 99);
    strokeWeight(3);
    fill(189, 181, 213);
    circle(projPos.x, projPos.y, 13 + ((float) Math.sin(frameCount * 0.25) * 2)); //projectile circle
    //Pulsates using sin like seen in GoopLab and FroggyFly
    
    noStroke(); //resets back to default noStroke
  }

  //Moves the projectile forwards.
  void move() {
    projPos.add(playerLast); //Moves towards the last position the player was in
    //Because the direction vector function is called only once, it does not update. As such, the projectile keeps going forwards
  }
}
