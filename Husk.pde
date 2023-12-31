

//husks are the basic enemy in the game. They will move towards the bunker
//from somewhere off screen and get increasingly faster as they do so.
class Husk extends Enemy {

  //Draws the husk
  @Override void drawEnemy() {

    //Mouth
    fill(79, 121, 66); //zombie green
    arc(enemyPos.x, enemyPos.y + 5, 20, 20, 0, PI); //bottom jaw
    arc(enemyPos.x, enemyPos.y - 5, 20, 20, PI, TWO_PI); //top jaw

    //Teeth
    fill(234, 221, 202); //teeth color
    triangle(enemyPos.x - 10, enemyPos.y - 5, enemyPos.x - 7, enemyPos.y + 5, enemyPos.x - 5, enemyPos.y - 5); //first tooth
    triangle(enemyPos.x - 5, enemyPos.y - 5, enemyPos.x, enemyPos.y + 5, enemyPos.x + 5, enemyPos.y - 5); //second tooth
    triangle(enemyPos.x + 5, enemyPos.y - 5, enemyPos.x + 7, enemyPos.y + 5, enemyPos.x + 10, enemyPos.y - 5); //third tooth

    stroke(0); //stroke color for eyes
    strokeWeight(2); //Stroke's weight
    //The stroke, funny enough, actually gives the eyes a jittery effect.
    //While this was not intentional, it gives the husks a lot more life than they had previously. and so, I am keeping it in

    fill(255, 191, 0); //Color of eyes (yellow)
    circle(enemyPos.x - 8, enemyPos.y - 10, 10); //left eye
    circle(enemyPos.x + 8, enemyPos.y - 7, 8); //right eye
    noStroke(); //reset back to no stroke
  }

  //Moves the husk
  //Credit to Lucas for helping me understand how to pull this off.
  @Override void move() {
    //Checks if the husk is almost on screen (within the parameters given)
    //Then, increases the speed of the husk by acceleration
    if ((this.enemyPos.x <= width + 20 && this.enemyPos.x >= 0 - 20) && (this.enemyPos.y <= height + 30 && this.enemyPos.y >= 0 - 30)) {
      this.enemySpeed.add(enemyAcc);
    }
    //adds the next position that the enemy should be at given the directional vector
    enemyPos.add(directionVector(player.playerPos, this.enemyPos, this.enemySpeed));
  }
}
