//Donkey Kong Game - Final Project
// Mudasser
//July 16/21
//object oriented program that allows the user to play as a character(object) and is able to move around 
//and dodge obstacles(objects), with the goal of saving the princess.
//CONTROLS- use arrow keys to move, up to jump and also go up ladders, down to go down ladders, left and right to move left and right


//creates object names
ArrayList<mapLayout> ladders = new ArrayList<mapLayout>();
ArrayList<barrels>  rollingBarrel;
mario mario;
mapLayout map;
boss DK;
barrels decor;
mapLayout jails;
int [] floorLevel = new int[7];

//creating and initializing booleans varaiables acting as keys throughout program to start certain actions
boolean topReached = false;
boolean backDown = false;
boolean end = false;
boolean gameComplete = false;

PFont myFont;

void setup() {

  size(800, 1000);
  rectMode(CENTER);
  imageMode(CENTER);
  //initializing objects
  mario = new mario();
  map = new mapLayout();
  DK = new boss();
  decor = new barrels();
  jails = new mapLayout();
  rollingBarrel = new ArrayList<barrels>();

  //adding values to a list which contains the y levels for each floor
  floorLevel[0] = 890;
  floorLevel[1] = 815;
  floorLevel[2] = 740;
  floorLevel[3] = 665;
  floorLevel[4] = 590;
  floorLevel[5] = 515;
  floorLevel[6] = 440;

  //adding objects to each arraylist
  ladders.add(new mapLayout(750, floorLevel[0]));
  ladders.add(new mapLayout(15, floorLevel[1]));
  ladders.add(new mapLayout(750, floorLevel[2]));
  ladders.add(new mapLayout(15, floorLevel[3]));
  ladders.add(new mapLayout(750, floorLevel[4]));
  ladders.add(new mapLayout(15, floorLevel[5]));
  ladders.add(new mapLayout(340, floorLevel[6]));
  rollingBarrel.add(new barrels(0, true));
  rollingBarrel.add(new barrels(1, true));
  rollingBarrel.add(new barrels(1, true));
  rollingBarrel.add(new barrels(2, true));
  rollingBarrel.add(new barrels(2, true));
  rollingBarrel.add(new barrels(3, true));
  rollingBarrel.add(new barrels(4, true));
  rollingBarrel.add(new barrels(4, true));
  rollingBarrel.add(new barrels(5, true));

  frameRate(40);
  //font initializing
  myFont = createFont("Georgia", 32);
  textFont(myFont);
  textAlign(CENTER, CENTER);
}

void draw() {
  if (!end) { // if the game has not ended, meaning its begun or reset!

    background(25);
    map.drawScene(); 
    //draws each ladder in arraylist
    for (int i = 0; i < ladders.size(); i++) {
      ladders.get(i).drawLadder();
    }
    //functions for mario
    mario.ladderInteraction();
    mario.boxLocation();
    mario.movement();

    //generates stationary barrels beside DK
    decor.displayDecor(715, 430);

    tint(255); // sets tint back to normal


    if (mario.currentLevel != 6 && DK.notRunningAway) { //DK will only throw barrels when mario is not on top floor DK is notrunningaway which is set to false once mario reaches the top floor
      DK.barrel();
      DK.display();
    } else { // will generate his runAway animation/action, only can occer when mario is on the top floor

      DK.runAway();
    }
    //generates each barrel, and checks for collisions with mario(user)
    for (int i = 0; i < rollingBarrel.size(); i++) {
      rollingBarrel.get(i).display();
      rollingBarrel.get(i).collision();
      if (rollingBarrel.get(i).collision()) {
        //if any barrel has collided, then sets one of our boolean keys to true, and calls function for mario to "die"

        end = true;

        //this Block of code removes all barrels, and then adds our original barrels back to their starting spots 
        int amountOfBarrels = rollingBarrel.size();
        for (int a = 0; a < amountOfBarrels; a++) {
          rollingBarrel.remove(0);
        }
        rollingBarrel.add(new barrels(0, true));
        rollingBarrel.add(new barrels(1, true));
        rollingBarrel.add(new barrels(1, true));
        rollingBarrel.add(new barrels(2, true));
        rollingBarrel.add(new barrels(2, true));
        rollingBarrel.add(new barrels(3, true));
        rollingBarrel.add(new barrels(4, true));
        rollingBarrel.add(new barrels(4, true));
        rollingBarrel.add(new barrels(5, true));
      }
    }

    //checks to see if one of our boolean keys are true, is changed to true once mario reaches top and DK has his runAway animation
    if (backDown)   DK.keyGen(); //generates the key to open the jail
    mario.display(); // generates mario
  } else {// is true when the game boolean key "end" is true, meaning play has died or won
    //draws playAgain Box
    fill(201, 130, 130);
    rect(width/2, height - 800, 200, 100);
    fill(255);
    text("Play Again?", width/2, height - 800);

    //if boolean key is true which changes to true when user has won. then it will draw "You Won"
    if (gameComplete) text("YOU WIN!", width/2, height -400);
    //otherwise, meaning if user has lost in any way, then it will draw "You lost"
    else text("You LOST!", width/2, height -400);

    //if the play again box is clicked with the mouse, then the game is reset
    if (mousePressed) {
      if (mouseX >= 300  && mouseX <= 500) {
        if (mouseY >= 150 && mouseY <= 250) {
          restart(); //calls for function that handles resetting game
        }
      }
    }
  }
}

void restart() {
  //function that resets positions of objects including user, and resets their number of objects, along with resetting some values and boolean keys


  //this block removes all barrels and re-adds the original barrels
  int amountOfBarrels = rollingBarrel.size();
  for (int a = 0; a < amountOfBarrels; a++) {
    rollingBarrel.remove(0);
  }
  rollingBarrel.add(new barrels(0, true));
  rollingBarrel.add(new barrels(1, true));
  rollingBarrel.add(new barrels(1, true));
  rollingBarrel.add(new barrels(2, true));
  rollingBarrel.add(new barrels(2, true));
  rollingBarrel.add(new barrels(3, true));
  rollingBarrel.add(new barrels(4, true));
  rollingBarrel.add(new barrels(4, true));
  rollingBarrel.add(new barrels(5, true));

  //resetting variables for mario's position 
  mario.currentLevel = 0;
  mario.location.x = 100;
  mario.location.y = 875;

  DK.runCycle = 11; //resets value for DK

  //resets boolean keys and re-calls DK and mario to reset them
  end = false;
  map.isFree = false;
  gameComplete = false;

  map.isFree = false;
  DK = new boss();
  mario = new mario();
  backDown = false;
}


//both functions aid in movement for mario by user by changing a boolean key value
void keyPressed() {
  mario.userMovement(true);
}

void keyReleased() {
  mario.userMovement(false);
}
