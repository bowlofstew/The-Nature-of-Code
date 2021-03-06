Mover[] movers = new Mover[20];

float g = 0.4;

void setup() {
  size(800,200);
  smooth();
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(1,2),random(width),random(height)); 
  }
}

void draw() {
  background(255);


  for (int i = 0; i < movers.length; i++) {
    for (int j = 0; j < movers.length; j++) {
      if (i != j) {
        PVector force = movers[j].attract(movers[i]);
        movers[i].applyForce(force);
      }
    }
   
    movers[i].boundaries();
    
    movers[i].update();
    movers[i].display();
  }

}













class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;

  Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    fill(175, 200);
    ellipse(location.x, location.y, mass*16, mass*16);
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 5.0, 25.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }

  void boundaries() {

    float d = 50;

    PVector force = new PVector(0, 0);

    if (location.x < d) {
      force.x = 1;
    } 
    else if (location.x > width -d) {
      force.x = -1;
    } 

    if (location.y < d) {
      force.y = 1;
    } 
    else if (location.y > height-d) {
      force.y = -1;
    } 

    force.normalize();
    force.mult(0.1);

    applyForce(force);
  }
}



