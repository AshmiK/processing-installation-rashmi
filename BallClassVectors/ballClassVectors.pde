

int ballCount = 150;
ballPhysics[] ball = new ballPhysics[ballCount];

int timer;


void setup() 
{
  size(1280, 720);
  colorMode(HSB, 255, 255, 255);  
  noStroke();
  frameRate(60);
  smooth();
   frame.setResizable(true);
  for (int i = 0; i<ballCount; i++) {
    ball[i] = new ballPhysics();
  }
 
  
  
}

void draw() 
{
  background(255);
if (mousePressed) {
  fill(0);
   ellipse(mouseX, mouseY,15, 15);
   textSize(18);
   if(mouseButton==LEFT)
  text("-G",mouseX+5,mouseY-10);
   
  if(mouseButton==RIGHT)
  text("Spawn",mouseX+5,mouseY-10);
  
  if(mouseButton==CENTER)
  text("+G",mouseX+5,mouseY-10);
}

  int ballCounter=0;
  int exitCounter=0;
  for (int i = 0; i<ballCount; i++) {
    if (ball[i].present==1) {
      ballCounter++;
      //println(str(i)+":"+str(ball[i].time)+" x:"+str(ball[i].location.x)+" y:"+str(ball[i].location.y)+" vx:"+str(ball[i].velocity.x)+" vy:"+str(ball[i].velocity.y));
    }
    if (ball[i].exit==1) {
      exitCounter++;
    }
    ball[i].update();
  }
  fill(0);
  textSize(18);
  text(str(ballCounter)+"/"+str(ballCount), 5, 15);
  text("Exit:"+str(exitCounter), 5, 15+18);
  if(key!='n')
  text("Gravity:ON", 5, 15+18*2);
  else
  text("Gravity:OFF", 5, 15+18*2);
  text("FPS:"+str(int(frameRate*10)/10.0), 5, 15+18*3);

  if (timer>3) {
    timer=0;
    if (mouseButton==RIGHT && mousePressed) {
      for (int i = 0; i<ballCount; i++) {
        if (ball[i].present == 0) {
          //ball[i].spawn(random(50,width-50),random(50,height-50));
          ball[i].spawn(mouseX, mouseY);
          return;
        }
      }
    }
  } else
    timer++;
}

void mousePressed() {
}
