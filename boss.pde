class boss {
  //holds position of DK
  float x;
  float y;
  //initializes Pimage objects to hold DK images and keyLock image;
  PImage DK [] = new PImage[15];
  PImage keyLock = new PImage();
  
  //variables that help with DK movement animation
  int standCycle;
  int grabCycle;
  int runCycle;
  
  //boolean Keys
  boolean grabAnimation; //boolean that changes to true when it is time for DK to grab a new barrel
  boolean loadKey;        //boolean that changes to true when its is time for the Key to be drawn into canvas
  boolean notRunningAway;   //boolean that changes to false when DK is running his run away animation 
  

//holds position and aids in movement of DK when he does his runAway animation/ action
  float xRun;
  float yRun;
  float xRunSpeed;
  
  boss() {
    //initializing images for DK and keyLock
    DK[0] =  loadImage("DKBarrel0.png");
    DK[1] =  loadImage("DKBarrel1.png");
    DK[2] =  loadImage("DKBarrel2.png");
    DK[3] =  loadImage("DKBarrel3.png");
    DK[4] =  loadImage("DKBarrel4.png");
    DK[5] =  loadImage("DKStand0.png");
    DK[6] =  loadImage("DKStand1.png");
    DK[7] =  loadImage("DKStand2.png");
    DK[8] =  loadImage("DKRun0.png");
    DK[9] =  loadImage("DKRun1.png");
    DK[10] =  loadImage("DKRun2.png");
    DK[11] =  loadImage("DKRun3.png");
    DK[12] =  loadImage("DKRun4.png");
    DK[13] =  loadImage("DKRun5.png");
    DK[14] =  loadImage("DKRun6.png");
    keyLock = loadImage("key.png");
    
    //sets variables to initial value
    x= 675;
    y = 415;
    standCycle = 5;
    grabCycle = 0; 
    runCycle = 9;
    xRun = x;
    yRun = y;
    xRunSpeed = 5;
    
    //sets boolean keys to initial values
    grabAnimation = false;
    loadKey = false;
    notRunningAway = true;

    
    
  }
  
  void display() {// function that displays DK 

    if (grabAnimation == false) { //Checks to see if DK isnt running his grab barrel animation
      image(DK[standCycle], x, y);
      
      int chance = int(random(0, 101)); //this chance factor slows down the rate of looping through the images
      if (chance >=90) {                //allows for user to be able to see the animation better
        standCycle ++;
      }
      if (standCycle >7) {
        standCycle = 5;
      }
    }
  }
  
  void barrel() {//function that changes DK into his barrel grabbing animation
    if (grabBarrel()) { // calls a function that returns a boolean
      grabAnimation = true; //sets another boolean key to true
    }
    if (grabAnimation) { //when true it executes, which generates DK barrel grabbing Animation
      image(DK[grabCycle], x, y);
      
      int chance3 = int(random(0, 101)); //this chance factor slows down the rate of looping through the images
      if (chance3 <5) grabCycle ++;      //allows for user to be able to see the animation better
      
      if(grabCycle == 4){ //when the grabCycle is at 4 meaning its at its last, it will draw a image of a barrel right by his hand
       image(decor.rollBarrel, 635,435); 
      }
      if (grabCycle > 5) { // when the grabCycle is at 5 the image is replaced with the actual object of a barrel
        rollingBarrel.add(new barrels(7,false));
        grabCycle = 0;
        grabAnimation = false;
      }
    }
    
  }

  //function that when called will return a true or false to determine whether DK should start his Barrel throwing animation
  boolean grabBarrel() {
    if (grabAnimation == false) { // will only occure if grabAnimation is false, this is to ensure DK doesn't reset his barrel throwing animation
                                  // while executing it, since this value is turned to false once the animation is complete
                                  
      int chance2 = int(random( 0, 150)); //element of chance prevents DK from constantly throwing more and more barrels.
      if (chance2 == 0) {
        return true;
      }
    }
    return false;
  }
  
  //function that creates DK's runaway animation
  void runAway(){
    
    if(mario.location.x <= 200 && notRunningAway){ 
    image(DK[8], x, y); // draws DK's scared image
    }
    
    
    else{
     
    notRunningAway = false; //set to false so scared DK cannot be drawn, nor can DK throw barrels/ be displayed in the top right
    int chance4 = int(random(0,1)); // chance to once again allow for better animation image cycling
     if(chance4 == 0){
      xRun += xRunSpeed;
      runCycle++;
     }
     
    if (backDown){ // if boolean key is true, then runcycle goes from 12-14
      if (runCycle > 14) runCycle = 12; 
    }
    if(topReached){ // if boolean key is true, then runcycle goes from 9-11
      if (runCycle > 11)runCycle = 9; 
    }
    
    //when DK reaches the very right, his direction is flipped and is sent to the bottom floor, and boolean keys are changed.
    if(xRun > width){
      backDown = true;
      topReached = false;
      mario.ableToMove = false; // mario no longer able to move
      yRun = 865;
      xRunSpeed *= -1;  
    }
    //When DK reaches the very left, mario is now able to move
    if(xRun < 0) {
      mario.ableToMove = true;
    }
    //when Dk reaches x = 500, then the key is dropped by changing the boolean key value to true
    if(xRun == 500){
      loadKey = true;
      
    }
    //note that these two if statements can only become true when DK is on the bottom floor 

    //draw DK in his runAway animation style
    image(DK[runCycle], xRun, yRun);
  }
}
  //funciton that draws the key and disappears/sets a boolean (mario.hasKey) to true once mario is touching the key
  void keyGen(){
    if(mario.getX() ==500 && mario.getY() >= 850){
       loadKey = false; //once it is set to false it can no longer become true unless program is restarted, meaning the key will not be drawn again
       mario.hasKey = true; // allows mario aswell as map object to know that he has the key so the jail can be open once mario is touching the cell
      }
      //draws key if loadkey boolean is true,
      if(loadKey){
       image(keyLock, 500, 875); 
      }
      
    
  }
}
