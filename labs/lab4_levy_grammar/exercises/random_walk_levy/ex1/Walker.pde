float STEPSCALE=10;

class Walker {
  PVector position;
  PVector prevPosition;
  
  Walker() {
    this.position=CENTER_SCREEN.copy();
    this.prevPosition=this.position.copy();    
  }
  void draw() {    
    
    stroke(255);
    strokeWeight(3);
    line(this.prevPosition.x,this.prevPosition.y,this.position.x,this.position.y);
    this.prevPosition = this.position.copy();
    update();
  }

  void update() {    
    PVector step = new PVector(random(-1,1),random(-1,1));
    step.normalize();
    float stepsize = montecarlo();
    step.mult(stepsize*STEPSCALE);
    
    this.position.add(step);
    this.position.x=constrain(this.position.x, 0, width);    
    this.position.y=constrain(this.position.y, 0, height);
  }
}

float montecarlo() {
  float r1;
  float r2;
  float p;
  do{
    r1 = random(1);
    p = random(1);
    r2 = random(1);
  }while(r2>=p);

  return r1;

}
