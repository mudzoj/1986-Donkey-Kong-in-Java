class mapLayout {
  //stores x and y location of ladders
  float x;
  float y;
  
  //stores boundaries of ladders
  float top;
  float bottom;
  float left;
  float right;
 
 // initializing for images of peach and jail
  PImage jail[] = new PImage [2];
  PImage peach;
  
  //boolean key that changes depending on whether or not peach is free
  boolean isFree = false;

//used for map object
  mapLayout() {
    //image initializing for peach and jail
    jail[0]= loadImage("jailLocked.png");
    jail[1]= loadImage("jailOpen.png");
    peach = new PImage();
    peach = loadImage ("peach.png");
  }
  
//used for ladders
  mapLayout(float x_, float y_) {
    x = x_;
    y = y_;
    
    bottom = y;
    left = x;
    right = x + 30;
    top = y - 60;
    
  }
  
  //function that draws the map: red floors, peach, jail
  void drawScene() {
    //draws red floors
    stroke(10);
    strokeWeight(1);
    fill(144, 17, 17);
    rect(width/2, 900, width, 15);
    rect(width/2, 825, width, 15);
    rect(width/2, 750, width, 15);
    rect(width/2, 675, width, 15);
    rect(width/2, 600, width, 15);
    rect(width/2, 525, width, 15);
    rect(width/2, 450, width, 15);
    rect(width/2 + 35, 375, 200, 15);
    stroke(10);
    fill(10);
    
   image(peach, 505,350); //draws peach
   
   //checks if mario has grabbed key
   if(mario.hasKey){
     //then checks to see if mario is touching the jail
     if(mario.currentLevel == 7){
        if(mario.location.x >= 475){
          //if above is all true, then boolean key "isfree" is set to true
          isFree = true;
        }
     }
   }
   //checks if boolean key "isFree" is true, if so, then the opened jail cell is drawn and boolean keys "end" and "gameComplete" are set to true
   if(isFree){
     image(jail[1],500,330); 
     end = true;
     gameComplete = true;
   //if boolean key "isFree" is false, meaning mario does not have a key, then the close jail is drawn  
   //and nothing is done to the two boolean key so they remain false
   }else{
     image(jail[0], 500, 330);
   } 
  }
  
  //function that draws ladders 
  void drawLadder() {
    fill(255);
    stroke(185, 158, 88);
    strokeWeight(6);
    line(x, y, x, y -60);
    line(x +30, y, x+30, y-60);
    strokeWeight(3);
    for (int i = 7; i < 60; i+= 7) {
      line(x, y -i, x +30, y -i);
    }
  }
  
  //these four functions return corresponding variables to objects in other classes
  float getTop(){
    return top;  
  }
  float getBottom(){
   return bottom; 
  }
  float getLeft(){
   return left; 
  }
  float getRight(){
   return right; 
  }
  
}
