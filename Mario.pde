class mario {
  
  //list storing images of mario
  PImage mario [] = new PImage[8];
  //variables that help with animation of mario
  int marioLWalkCycle = 0;
  int marioRWalkCycle = 3;
  int currentImage;
  //stores values that aid in movement and display
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector prevLocation;

  //variables that keep track of the dimensions or "box" around mario for collisions
  float top;
  float bottom;
  float left;
  float right;

  //variable that helps with setting mario's updated "floor" or ground (y level) while playing
  float offsetAmount;
  // variable that keeps track of marios current level
  int currentLevel = 0;

  //booleans that help with movement 
  boolean leftMove = false;
  boolean rightMove = false;
  boolean jump = false;
  boolean falling;

  boolean topNotReached; //boolean key that changes to false once mario has reached the top floor, only changes back once game is reset
  boolean ableToMove; // keeps track of whether or not mario is allowed to move, on turns to falls when DK does his runAway animation
  boolean hasKey; // checks if mario has a key, changes when mario grabs key
  boolean descend; // keeps track of whether mario is falling or not, changes when going down ladder


  mario() {
    //stores images of mario inside of list
    mario[0] =  loadImage("marioWalk1.png");
    mario[1] =  loadImage("marioWalk2.png");
    mario[2] =  loadImage("marioWalk3.png");
    mario[3] =  loadImage("marioWalk4.png");
    mario[4] =  loadImage("marioWalk5.png");
    mario[5] =  loadImage("marioWalk6.png");
    mario[6] =  loadImage("marioClimb1.png");
    mario[7] =  loadImage("marioClimb2.png");

    //sets Pvector values
    location = new PVector(100, 875);
    velocity = new PVector(5, -5);
    acceleration = new PVector (.15, .35);

    //sets box collision dimension/location
    top =  location.y - 15;
    bottom = location.y + 15;
    left = location.x - 5;
    right = location.x - 5;

    //sets booleans to starting values
    leftMove = false;
    rightMove = false;
    jump = false;
    falling = false;
    topNotReached = true;
    ableToMove = true;
    hasKey = false;  
    descend = false;
  }

  //draws Mario
  void display() {

    stroke(10);
    strokeWeight(1);
    image(mario [currentImage], location.x, location.y);
    //checks to see if mario has reached the top floor
    if (currentLevel == 6 && topNotReached) {
      topReached = true; //boolean key for activating DK RunAway 
      topNotReached= false; // changes to false so this if statement can only occure once, otherwise, topReached will continue to change to true
    }
  }
  //function that allows mario to move
  void movement() {

    if (ableToMove) { //checks if mario is allowed to move
      if (leftMove) {//checks if user wants to move left
        if (location.x > 0) { //makes it so user cant move infinitely to the left and off the screen
          location.x -= velocity.x;
        }
        //this small chunk is the for marios animation while moving left, cycles through images
        int chance5 = int(random(0, 2));
        if (chance5 ==0) marioLWalkCycle +=1; //makes it so the animation is slightly slower allowing for more visible animation
        if (marioLWalkCycle >= 2) {
          marioLWalkCycle = 0;
        }

        currentImage = marioLWalkCycle;
      }
      if (rightMove) { // checks to see if user wants to move right
        if (location.x < width) { //  makes it so user cant move infinietly to the right and off the screen
          location.x += velocity.x;
        }
        //this small chunk is the for marios animation while moving right, cycles through images
        int chance6 = int(random(0, 2));
        if (chance6 ==0) marioRWalkCycle += 1; //makes it so the animation is slightly slower allowing for more visible animation
        if (marioRWalkCycle >= 5) {
          marioRWalkCycle = 3;
        }
        currentImage = marioRWalkCycle;
      }
      if (jump) { //checks if user wants to jump

        velocity.y += acceleration.y; //introducing "gravity" to the velocity
        location.y += velocity.y; // adds the altered speed through gravity to the location 
        offsetAmount = currentLevel * 75; // subtracting this value by 875, the very bottom floors y-level, we can determine the y-level that mario needs to be at
        if (location.y > 875-offsetAmount) { // once it reaches the floor level
          location.y = 875-offsetAmount;
          velocity.y = -5;
          jump = false;
        }
      }
    }
  }
  //function that helps make the arrow keys usable
  void userMovement(boolean temp) {

    if (keyCode == LEFT) {
      leftMove  = temp;
    }
    if (keyCode == RIGHT) {
      rightMove = temp;
    }
    if (keyCode == UP) {

      jump = true;
    }
  }
  //function that checks if mario(user) is touching/colliding with ladders
  void ladderInteraction() {

    if (keyCode == UP) { //checks if UP is being pressed

      //checks each ladders and sees is mario's box is touching the ladders' box, if so, it will set the currentlevel variable of mario by +1; meaning it will be sent to the above floor
      if (ladders.get(0).getRight() > left && ladders.get(0).getLeft() < right && ladders.get(0).getBottom() > top && ladders.get(0).getTop() < bottom) currentLevel = 1;
      if (ladders.get(1).getRight() > left && ladders.get(1).getLeft() < right && ladders.get(1).getBottom() > top && ladders.get(1).getTop() < bottom) currentLevel = 2;
      if (ladders.get(2).getRight() > left && ladders.get(2).getLeft() < right && ladders.get(2).getBottom() > top && ladders.get(2).getTop() < bottom) currentLevel = 3;
      if (ladders.get(3).getRight() > left && ladders.get(3).getLeft() < right && ladders.get(3).getBottom() > top && ladders.get(3).getTop() < bottom) currentLevel = 4;
      if (ladders.get(4).getRight() > left && ladders.get(4).getLeft() < right && ladders.get(4).getBottom() > top && ladders.get(4).getTop() < bottom) currentLevel = 5;
      if (ladders.get(5).getRight() > left && ladders.get(5).getLeft() < right && ladders.get(5).getBottom() > top && ladders.get(5).getTop() < bottom) currentLevel = 6;
      if (ladders.get(6).getRight() > left && ladders.get(6).getLeft() < right && ladders.get(6).getBottom() > top && ladders.get(6).getTop() < bottom) currentLevel = 7;
    }

    if (keyCode == DOWN) { //checks if DOWN is being pressed

      //checks each ladders and sees is mario's box is touching the ladders' box, if so, it will set the currentlevel variable of mario by -1; meaning it will be sent to the lower floor
      //also changes boolean key "descend" to true which allows mario to fall
      if (ladders.get(0).getRight() > left && ladders.get(0).getLeft() < right && ladders.get(0).getBottom() > top && ladders.get(0).getTop() - 75 < bottom) {
        currentLevel = 0;
        descend = true;
      } 
      if (ladders.get(1).getRight() > left && ladders.get(1).getLeft() < right && ladders.get(1).getBottom() > top && ladders.get(1).getTop() - 75 < bottom) {
        currentLevel = 1;
        descend = true;
      } 
      if (ladders.get(2).getRight() > left && ladders.get(2).getLeft() < right && ladders.get(2).getBottom() > top && ladders.get(2).getTop() - 75 < bottom) {
        currentLevel = 2;
        descend = true;
      } 
      if (ladders.get(3).getRight() > left && ladders.get(3).getLeft() < right && ladders.get(3).getBottom() > top && ladders.get(3).getTop() - 75 < bottom) {
        currentLevel = 3;
        descend = true;
      } 
      if (ladders.get(4).getRight() > left && ladders.get(4).getLeft() < right && ladders.get(4).getBottom() > top && ladders.get(4).getTop() - 75 < bottom) {
        currentLevel = 4;
        descend = true;
      } 
      if (ladders.get(5).getRight() > left && ladders.get(5).getLeft() < right && ladders.get(5).getBottom() > top && ladders.get(5).getTop() - 75 < bottom) {
        currentLevel = 5;
        descend = true;
      }  
      if (ladders.get(6).getRight() > left && ladders.get(6).getLeft() < right && ladders.get(6).getBottom() > top && ladders.get(6).getTop() - 75 < bottom) {
        currentLevel = 6;
        descend = true;
      }
    }

    if (descend) { //checks to see if boolean key "descend" is true, meaning it was colliding with a ladder
      //then checks to see what the current level is, since it was decreased by -1, we increase the location.y of mario meaning it starts
      //to fall, until it reaches the new currentlevel floors y-level

      //runs through every possible currentLevel value and acts accordingly
      if (currentLevel == 0) {
        if (location.y <= 870) {
          location.y += 5;
        } else {
          descend = false;
        }
      }
      if (currentLevel == 1) {
        if (location.y <= 795) {
          location.y += 5;
        } else {
          descend = false;
        }
      }
      if (currentLevel == 2) {   
        if (location.y <= 720) {
          location.y += 5;
        } else {
          descend = false;
        }
      }
      if (currentLevel == 3) {
        if (location.y <= 645) {
          location.y += 5;
        } else {

          descend = false;
        }
      }
      if (currentLevel == 4) {
        if (location.y <= 570) {
          location.y += 5;
        } else {

          descend = false;
        }
      }
      if (currentLevel == 5) { 
        if (location.y <= 495) {
          location.y += 5;
        } else {
          descend = false;
        }
      } 

      if (currentLevel == 6) { 
        if (location.y <= 420) {
          location.y += 5;
        } else {
          descend = false;
        }
      }
    }

    //for floor 7 its slightly different, since we also have to check if its standing on the platform or not
    if (currentLevel == 7) {
      if (location.x <= 335 || location.x >= 535) { // checks if its on platform
        currentLevel = 6; // sets currentLevel to -1
        descend = true; //sets descend to true, allowing the above if statement, if(descend), to become true
        //and run, which allows user to fall down, will also set descend back to false once complete
      }
    }
  }

  //function that changes box dimension and location, depending on where mario is
  void boxLocation() {
    top =  location.y - 15;
    bottom = location.y + 15;
    left = location.x - 5;
    right = location.x - 5;
  }

  //functions that return values of mario and his box, so other objects in different classes can access them
  float getTop() {
    return top;
  }
  float getBottom() {
    return bottom;
  }
  float getLeft() {
    return left;
  }
  float getRight() {
    return right;
  }
  float getX() {
    return location.x;
  }
  float getY() {
    return location.y;
  }
  float getWidth() {
    return right - left;
  }
  float getHeight() {
    return bottom - top;
  }
}
