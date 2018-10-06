import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BallClassVectors extends PApplet {



int ballCount = 150;
ballPhysics[] ball = new ballPhysics[ballCount];

int timer;


Minim minim;
AudioSample Golfball;

public void setup() 
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
  minim = new Minim(this);
  Golfball = minim.loadSample("Golfball.mp3",512);
  
  
}

public void draw() 
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
  text("FPS:"+str(PApplet.parseInt(frameRate*10)/10.0f), 5, 15+18*3);

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

public void mousePressed() {
}




class ballPhysics {
  int present = 0;
  int spawn = 0;
  int r;
  PVector location= new PVector(width/2, height/2);
  PVector velocity= new PVector(random(-15, 15), random(-10, 15));
  PVector gravity = new PVector(0, 0.2f);
  float gravStrength= 0.4f;
  PVector gravity2 = new PVector(width/2, height/2);

  float x=0, y=0, vx, dvx, vy, dvy, mass, g=20;
  int time;
  int clr;
  int bouncedx =0;
  int bouncedy =0;
  int exit = 0;
  float distGravity2 =0;
  float angle=0;
  float Rint = 0;

  ballPhysics() {
  }

  public void spawn(int _x, int _y) {
    location.x = _x;
    location.y=_y;
    velocity.x = random(-15, 15); 
    velocity.y=random(-10, 15);
    gravity2.x = _x;
    gravity2.y=_y;
    //x=_x;
    //y=_y;
    //vx= random(-400,400);
    //vy= random(-100,400);
    clr=PApplet.parseInt(random(0, 255));
    r= PApplet.parseInt(random(height/70,height/25));
    mass = 10;
    spawn = 1;
    exit = 0;
    time = 0;
    bouncedx =0;
    bouncedy =0;
    Rint=0;
  }
  public void gravity(float x,float y){
    gravity2.x=x;
    gravity2.y=y;
    
  }
  public void update() {


    if (present == 0 && spawn == 1) {
      present = 1;
      spawn = 0;
    } 
    if (present == 1) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
      time++;
      if (mousePressed) {
        gravity2.x=mouseX;
        gravity2.y=mouseY;
        distGravity2=PVector.dist(gravity2,location);
        gravity2.sub(location);
        gravity2.normalize();
        if(mouseButton==LEFT)
        gravity = gravity.mult(gravity2, gravStrength*2/sq(1+distGravity2/1000.0f));
        if(mouseButton==CENTER)
        gravity = gravity.mult(gravity2, gravStrength*-2/sq(1+distGravity2/1000.0f));
        if(key!='n')
        gravity.y=gravity.y+gravStrength;
        velocity = velocity.mult(velocity, 0.995f);
      } else {
        gravity.x=0;
        if(key!='n')
        gravity.y=gravStrength;
        else
        gravity.y=0;
      }
      
      gravity = gravity.div(gravity, r/5.0f);
      velocity.add(gravity);
      location.add(velocity);
      
      
      if (time<8){
        fill(clr, 255, 255, time*32-1);
        Rint=Rint+PApplet.parseFloat(r)/8.0f;
      }
      else{
        fill(clr, 255, 255);
        Rint=r;
      }
      ellipse(location.x, location.y, Rint*2, Rint*2);
      
      angle = velocity.heading();
      stroke(0);
      strokeWeight(2);
      line(location.x,location.y,location.x+Rint*cos(angle),location.y+Rint*sin(angle));
      noStroke();

      if ((location.y<=r || location.y>=height-r) && bouncedy == 0 && (location.y<height/2 || exit == 0)) {
        velocity.y=-velocity.y*0.85f;
        bouncedy = 1;
        Golfball.setGain(-20+velocity.mag());
        Golfball.trigger();
        velocity.x=velocity.x*0.8f;
        if (abs(velocity.y)<3.5f && location.y>height/2)
          exit = 1;
      }
      if(key=='n')
        exit = 0;
        
      if (location.y>r && location.y<height-r)
        bouncedy = 0;

      if ((location.x<=r || location.x>=width-r) && bouncedx == 0) {
        velocity.x=-velocity.x*0.8f;
        bouncedx = 1;
        Golfball.setGain(-20+velocity.mag());
        Golfball.trigger();
      }
      if (location.x>r && location.x<width-r)
        bouncedx = 0;


      if (location.y>height+r && exit == 1) {
        present = 0;
        exit=0;
      }
    }
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BallClassVectors" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
