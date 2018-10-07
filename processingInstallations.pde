// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/1scFcY-xMrI

import processing.video.*;
Capture video;

import processing.sound.*;
SoundFile[] file;

color trackColor; 
float threshold = 50;
float distThreshold = 50;

ArrayList<Blob> blobs = new ArrayList<Blob>();

int ballCount = 150;
ballPhysics[] ball = new ballPhysics[ballCount];
int timer;

void setup() {
  int numsounds = 5;
  file = new SoundFile[numsounds];
  file[0] = new SoundFile(this, "kick.wav");
  file[1] = new SoundFile(this, "snare.wav");
  file[2] = new SoundFile(this, "cowbell.wav");
  file[3] = new SoundFile(this, "clap.wav");
  file[4] = new SoundFile(this, "cymbal.wav");
  size(1280, 720);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, 1280, 720);
  video.start();
  trackColor = color(217, 191, 0);
  
  colorMode(HSB, 255, 255, 255);  
  noStroke();
  frameRate(60);
  smooth();
   frame.setResizable(true);
  for (int i = 0; i<ballCount; i++) {
    ball[i] = new ballPhysics();
  }
}

void captureEvent(Capture video) {
  video.read();
}

void keyPressed() {
  if (key == 'a') {
    distThreshold+=5;
  } else if (key == 'z') {
    distThreshold-=5;
  }
  if (key == 's') {
    threshold+=5;
  } else if (key == 'x') {
    threshold-=5;
  }


  println(distThreshold);
}

void draw() {
  //video.loadPixels();
  //image(video, 0, 0);

  blobs.clear();


  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

  for (Blob b : blobs) {
    if (b.size() > 500) {
      b.show();
      

  float midx=1280-b.midX();
  float midy=b.midY();
  fill(217, 191, 0);
  ellipse(midx, midy,10, 10);


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
    ball[i].update(midx,midy);
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

  if (timer>70) {
    timer=0;
    
      for (int i = 0; i<ballCount; i++) {
        if (ball[i].present == 0) {
          //ball[i].spawn(random(50,width-50),random(50,height-50));
          ball[i].spawn(midx, midy);
          return;
        }
      }
    
  } else
    timer++;
    }
  }

  textAlign(RIGHT);
  fill(0);
  text("distance threshold: " + distThreshold, width-10, 25);
  text("color threshold: " + threshold, width-10, 50);
  
}


// Custom distance functions w/ no square root for optimization
float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable

}
