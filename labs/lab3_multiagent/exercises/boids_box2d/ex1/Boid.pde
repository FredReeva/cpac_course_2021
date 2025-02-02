class Boid{
    Body body;
    Box2DProcessing  box2d;
    color defColor = color(200, 200, 200);
    color contactColor;
    float radiusP;
    
    Boid(Box2DProcessing  box2d, CircleShape ps, BodyDef bd, Vec2 position){
        this.box2d = box2d;    
        bd.position.set(position);
        this.body = this.box2d.createBody(bd);
        this.body.m_mass=1;
        this.body.createFixture(ps, 1);
        this.body.getFixtureList().setRestitution(0.8);
        this.body.setUserData(this);        
    }
    void applyForce(Vec2 force){
      this.body.applyForce(force, this.body.getWorldCenter());      
    }
    void draw(){
        /* your code*/
        // see box2d.getBodyPixelCoord(Body body);
        Vec2 position = this.box2d.getBodyPixelCoord(this.body);
        fill(200);
        this.radiusP = W2P(ps.m_radius)*2; //! not working
        ellipse(position.x, position.y, this.radiusP, this.radiusP);
 
    }
    void kill(){
        this.box2d.destroyBody(this.body);
    }

   
}
