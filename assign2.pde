int a=5; //enemy x-start
int b,c,d,e,f; //enemy y & treasure
float g,h; //fighter
float speed=5;
int bgx1, bgx2;
int gameState;
float blood=38.8;
final int GAME_START=1, GAME_RUN=2,GAME_OVER=3;

PImage bg1,bg2;
PImage img1,img2,img3,img4;
PImage start1,start2,end1,end2;

boolean upPressed=false;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;
void setup () {
  size(640,480);
  //image loading
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  bg1=loadImage("img/bg1.png");
  bg1.resize(640,480);
  bg2=loadImage("img/bg2.png");
  bg2.resize(640,480);
  img3=loadImage("img/fighter.png");
  img4=loadImage("img/treasure.png");
  img1=loadImage("img/hp.png");
  img2=loadImage("img/enemy.png");
  //fighter
  g=588;
  h=245;
  //enemy y
  b=235;
  //treasure locate
  e=floor(random(0,599));
  f=floor(random(0,439));
  image(img4,e,f);
  
  gameState=GAME_START;
}

void draw() {
  switch(gameState){
    
   case GAME_START:
    image(start2,0,0);
    if (mouseX<441 && mouseX>208 && mouseY>379 && mouseY<411){
     image(start1,0,0);
     if (mousePressed){
      switch(gameState){
      case GAME_START:
      gameState=GAME_RUN;
      break;
      }
     }
    }
    break;
    
   case GAME_RUN: 
    //scrolling background
    bgx1=bgx1%1280;
    bgx1++;
    image(bg1,bgx1,0);
    image(bg2,bgx1-640,0);
    image(bg1,bgx1-1280,0);
    //fighter 
    if(g<0){
    g=0;
    }
    if(g>589){
    g=589;
    }
    if(h<0){
    h=0;
    }
    if(h>429){
    h=429;
    }
    image(img3,g,h);
    
    //treasure
    image(img4,e,f);
    //enemy x
    a+=speed;
    a%=640;
    image(img2,a,b);
    //hp bar
    fill(255,0,0);
    rect(13,3,blood,20);
    //hp
    image(img1,0,0);
    
    //fighter&enemy crash
    if (sq(a+30.5-g-25.5)+sq(b+30.5-h-25.5)<sq(30.5+25.5)){
    a=-61;
    blood-=38.8;
    }
    //fighter get treasure
    if (sq(e+20.5-g-25.5)+sq(f+20.5-h-25.5)<sq(20.5+25.5)){
    e=floor(random(0,599));
    f=floor(random(0,439));
    blood+=19.4;
    }
    
    //blood upper bound 
    if (blood>=194.0){
    blood=194.0;
    }
    break;  

   case GAME_OVER:
    image(end2,0,0);
    if (mouseX<431 && mouseX>208 && mouseY>312 && mouseY<345){
     image(end1,0,0);
     if (mousePressed){
     switch(gameState){
     case GAME_OVER:
     gameState=GAME_RUN;
     e=floor(random(0,599));
     f=floor(random(0,439));
     g=588;
     h=245;
     blood=38.8;
     break;
     }
     }
    }
    break;   
  }
   
   //game over
   if((int)blood<=0){
   switch(gameState){
   case GAME_RUN:
   gameState=GAME_OVER;
   break;
   }
   }
   //fighter control
   if(upPressed){
   h-=speed;
   }
   if(downPressed){
   h+=speed;
   }
   if(leftPressed){
   g-=speed;
   }
   if(rightPressed){
   g+=speed;
   }
   //enemy approaching fighter
   if(g>a){
   a+=speed*1/6;
   }
   if(h<b){
   b-=speed*1/2;
   }
   if(h>b){
   b+=speed*1/2;
   }
}
void keyPressed(){
  if(key==CODED){
  switch(keyCode){
  case UP:
    upPressed=true;
    break;
  case DOWN:
    downPressed=true;
    break;
  case LEFT:
    leftPressed=true;
    break;
  case RIGHT:
    rightPressed=true;
    break;
  }
  }

}
void keyReleased(){
if(key==CODED){
  switch(keyCode){
  case UP:
    upPressed=false;
    break;
  case DOWN:
    downPressed=false;
    break;
  case LEFT:
    leftPressed=false;
    break;
  case RIGHT:
    rightPressed=false;
    break;
  }
  }
}
