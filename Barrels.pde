class barrels {

  PImage decor;
  PImage rollBarrel;

  // variables that aid in positioning of the moving barrels
  int x = -100;
  int y;
  int xSpeed;
  int level;

  //boolean that is set when barrel is added to arraylist, true meaning its an original, false meaning its a new one added by DK
  boolean original;

  //this is called for the stationary barrels
  barrels() {
    //image initializing/loading for barrels
    decor = new PImage();
    rollBarrel = new PImage();
    decor =  loadImage("barrelStanding.png");
    rollBarrel = loadImage("barrelRolling.png");
  }
  //this is called for moving barrels
  barrels(int level_, boolean original_) {
    original = original_;
    level = level_; 
    //image initialization/loading for barrels
    rollBarrel = new PImage();
    rollBarrel = loadImage("barrelRolling.png");


    //this bit checks to see what potentially random level the barrel is set to and changes positions accordingly

    //first floor
    if (level == 0) {
      x = 750;
      y = 885;
    }
    //second floor
    if (level == 1) {
      x = int(random(0, width));
      y = 810;
    }
    //third floor
    if (level == 2) {
      x = int(random(0, width));
      y = 735;
    }
    //fourth floor
    if (level == 3) {
      x = int(random(0, width));
      y = 660;
    }
    //fifth floor
    if (level == 4) {
      x = int(random(0, width));
      y = 585;
    }
    //sixth floor
    if (level == 5) {
      x = int(random(0, width));
      y = 510;
    }
    //seventh floor
    if (level == 6) {
      x = int(random(0, width));
      y = 435;
    }
    //eigth floor
    if (level == 7) {
      x = 635;
      y = 435;
    }

    xSpeed = 5;  //sets xSpeed, or travel rate
  }

  //function that displays the stationary barrels
  void displayDecor(int xdecor, int ydecor) {

    image(decor, xdecor, ydecor);
    image(decor, xdecor+25, ydecor);
    image(decor, xdecor+50, ydecor);
    image(decor, xdecor+12, ydecor-25);
    image(decor, xdecor+37, ydecor-25);
  }

  //function that draws the barrels as well as moves it accordingly
  void display() {

    //draws barrel if its an original
    if (original) {  
      image(rollBarrel, float(x), float(y));
    }
    // draws barrel with a blue tint if its not an original
    else {
      tint(100, 100, 200); 
      image(rollBarrel, float(x), float(y));
      //when the tinted barrel reaches the very left of the screen, it will go to a randomly chosen floor
      if (x <= 0) {
        y = floorLevel[int(random(0, 7))]- 5 ;
      }
    }

    tint(255); //sets tint back to normal
    //checks to see boolean key value, if its true, value changes to false when mario reaches top and DK does his run away animation
    //this makes it so the barrels cannot move and "kill" mario while he is frozen
    if (mario.ableToMove) {
      //if the floor level value is an even number, than the barrel will move to the right
      if (level % 2 == 0) x += xSpeed; 
      //if the floor level value is an odd number, than the barrel will move to the left
      else x-= xSpeed;

      //if a barrel reaches either the left end or right end, than xSpeed sign(pos or neg) will flip, meaning it will change direction, travelling in opposite direction
      if (x < 0 || x > width) xSpeed *= -1;
    }
  }

  //function that checks if a barrel has collided with mario, returns true if so, and false if no collision has taken place
  boolean collision() {

    float testX = x;
    float testY = y;

    //this block checks to see where mario is in regards to the barrel, and sets testX and testY accordingly
    if (x < mario.getX()) testX = mario.getX();  //left edge
    else if (x > mario.getX()+mario.getWidth()) testX = mario.getX()+mario.getWidth();   //right edge
    if (y < mario.getY()) testY = mario.getY();      // top edge
    else if (y > mario.getY()+mario.getHeight()) testY = mario.getY()+mario.getHeight();   // bottom edge


    float distX = x-testX;
    float distY = y-testY;
    float distance = sqrt( (distX*distX) + (distY*distY) );


    if (distance <= 3) return true; 

    return false;
  }
}
