class ballPhysics {
  int present = 0;
  int spawn = 0;
  int r;
  PVector location= new PVector(width/2, height/2);
  PVector velocity= new PVector(random(-15, 15), random(-10, 15));
  PVector gravity = new PVector(0, 0.2);
  float gravStrength= 0.4;
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

  void spawn(int _x, int _y) {
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
    clr=int(random(0, 255));
    r= int(random(height/70,height/25));
    mass = 10;
    spawn = 1;
    exit = 0;
    time = 0;
    bouncedx =0;
    bouncedy =0;
    Rint=0;
  }
  void gravity(float x,float y){
    gravity2.x=x;
    gravity2.y=y;
    
  }
  void update() {


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
        gravity = gravity.mult(gravity2, gravStrength*2/sq(1+distGravity2/1000.0));
        if(mouseButton==CENTER)
        gravity = gravity.mult(gravity2, gravStrength*-2/sq(1+distGravity2/1000.0));
        if(key!='n')
        gravity.y=gravity.y+gravStrength;
        velocity = velocity.mult(velocity, 0.995);
      } else {
        gravity.x=0;
        if(key!='n')
        gravity.y=gravStrength;
        else
        gravity.y=0;
      }
      
      gravity = gravity.div(gravity, r/5.0);
      velocity.add(gravity);
      location.add(velocity);
      
      
      if (time<8){
        fill(clr, 255, 255, time*32-1);
        Rint=Rint+float(r)/8.0;
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
        velocity.y=-velocity.y*0.85;
        bouncedy = 1;


        velocity.x=velocity.x*0.8;
        if (abs(velocity.y)<3.5 && location.y>height/2)
          exit = 1;
      }
      if(key=='n')
        exit = 0;
        
      if (location.y>r && location.y<height-r)
        bouncedy = 0;

      if ((location.x<=r || location.x>=width-r) && bouncedx == 0) {
        velocity.x=-velocity.x*0.8;
        bouncedx = 1;

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
