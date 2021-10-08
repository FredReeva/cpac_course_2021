import oscP5.*;
import netP5.*;
int PORT = 57120;
OscP5 oscP5;
NetAddress ip_port;

AgentMover mover;
int MASS_TO_PIXEL=10;
float mass_mover = 10;
float mass_attractor;
PVector pos_attractor;
float radius_attractor;
float area;
float dist=0;
float mult_factor = 0;
final float GC = 10; //6.67e-11
void setup(){
  mover=new AgentMover(10);
  mass_attractor=random(800, 1200);
  pos_attractor = new PVector(width/2, height/2);  
  radius_attractor = sqrt(mass_attractor/PI)*MASS_TO_PIXEL;
  
  oscP5 = new OscP5(this,55000);
  ip_port = new NetAddress("127.0.0.1",PORT);
  size(1280, 720);
  background(0);  
}

PVector computeGravityForce(AgentMover mover){
  PVector attr_force;
  /* your code here */
  PVector distance = PVector.sub(pos_attractor,mover.position);
  dist = distance.mag();
  dist = constrain(dist, dist_min, dist_max);
  mult_factor = GC*mover.mass*this.mass_attractor/pow(dist,2);
  attr_force = distance.normalize().mult(mult_factor);
  return attr_force;
}
void sendEffect(float cutoff, float vibrato){
    OscMessage effect = new OscMessage("/note_effect");    
    effect.add("effect");       
    effect.add(cutoff);
    effect.add(vibrato);
    
    oscP5.send(effect, ip_port);
}
    
void draw(){
  rectMode(CORNER);
  fill(0,20);
  rect(0,0,width, height);
  fill(200, 0, 200, 40);
  ellipse(pos_attractor.x, pos_attractor.y, 
          radius_attractor, radius_attractor);
  
  PVector force = computeGravityForce(mover);
  mover.applyForce(force);
  mover.update();
  mover.computeEffect(dist);
  sendEffect(mover.cutoff, mover.vibrato);
  mover.draw();
}
