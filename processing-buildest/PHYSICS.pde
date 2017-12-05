import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Wood> Woods;
ArrayList<Stone> Stones;
ArrayList<Material> Materials;
ArrayList<Boundary> Boundaries;

void loadPhysicalEngine() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  box2d.listenForCollisions();
  Woods = new ArrayList<Wood>();
  Stones = new ArrayList<Stone>();
  Materials = new ArrayList<Material>();
  Boundaries = new ArrayList<Boundary>();
}

void postSolve(Contact cp, ContactImpulse impulse) {
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
 
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  ArrayList<Material> ms = new ArrayList<Material>();
  ArrayList<Character> cs = new ArrayList<Character>(); 
  if (o1.getClass() == Wood.class || o1.getClass() == Stone.class) {
    ms.add((Material) o1);
  }
  if (o2.getClass() == Wood.class || o2.getClass() == Stone.class) {
    ms.add((Material) o2);
  }
  
  if (o1.getClass() == CFireMan.class || o1.getClass() == CTankMan.class || o1.getClass() == CFlyMan.class || o1.getClass() == CBombMan.class) {
    cs.add((Character) o1);
  }
  if (o2.getClass() == CFireMan.class || o2.getClass() == CTankMan.class || o2.getClass() == CFlyMan.class || o2.getClass() == CBombMan.class) {
    cs.add((Character) o2);  
  }

  float sum = 0;
  for(float i: impulse.normalImpulses)
    sum += i;
  
  for (Material m: ms) {
    m.fragile += sum;  
  }
  
  if(ms.size() == 1 && cs.size() == 1) {
    if(cs.get(0).team != ms.get(0).team)   
      Users.get(cs.get(0).userIndex).attackContribution += (int)sum/10;
    else Users.get(cs.get(0).userIndex).attackContribution += (int)sum/20;
  }
  
}