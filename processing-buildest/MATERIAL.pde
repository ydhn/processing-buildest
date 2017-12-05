PImage woodImgs[] = new PImage[3];
PImage stoneImgs[]= new PImage[3];
PImage fragileImgs[] = new PImage[3];


class Material {
  float w, h;
  Body body;      
  int shapeIndex;
  int team;
  float fragile = 0;
  float fragileMax = 100;
  Boolean dead = false;
  int imgN, rotation;
  Material() {
  }

  void render() {
    if (!dead) {
      if (!((int)(fragile/fragileMax*4) < 1) && ((int)(fragile/fragileMax) < 1))
        for (int i=0; i<4; i++)
          image(fragileImgs[(int)(fragile/fragileMax*4)-1], tetri_x[rotation][shapeIndex][i]*w, tetri_y[rotation][shapeIndex][i]*h, w, h);

      popMatrix();
      if (fragile >= fragileMax) {
        box2d.destroyBody(body);
        dead = true;
      }
    }
  }
}

class Wood extends Material {

  Wood(float x, float y, int imgN, int shapeIndex, int rotation, int team) {
    w = 15;
    h = 15;
    this.team = team;
    fragile = 0;
    fragileMax = 1000000;
    this.imgN = imgN;
    this.rotation = rotation;
    this.shapeIndex = shapeIndex;
    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    for (int i=0; i<4; i++) {
      PolygonShape sd = new PolygonShape();
      float box2dW = box2d.scalarPixelsToWorld(w/2);
      float box2dH = box2d.scalarPixelsToWorld(h/2);
      Vec2 offset = new Vec2(w*tetri_x[rotation][shapeIndex][i], h*tetri_y[rotation][shapeIndex][i]);
      offset = box2d.vectorPixelsToWorld(offset);
      sd.setAsBox(box2dW, box2dH, offset, 0);

      FixtureDef fd = new FixtureDef();
      fd.shape = sd; 
      fd.density = 10;
      fd.friction = 0.3;
      fd.restitution = 0;

      // Attach Fixture to Body               
      body.createFixture(fd);
    }
    body.setUserData(this);
  }

  void render() {
    if (!dead) {
      // We need the Body’s location and angle
      Vec2 pos = box2d.getBodyPixelCoord(body);    
      float a = body.getAngle();

      pushMatrix();
      translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
      rotate(-a);
      imageMode(CENTER);
      rectMode(CENTER);

      for (int i=0; i<4; i++) {
        stroke(255*(1-team), 0, 255*team);
        strokeWeight(2);
        rect(tetri_x[rotation][shapeIndex][i]*15, tetri_y[rotation][shapeIndex][i]*15, 15, 15);

        image(woodImgs[imgN], tetri_x[rotation][shapeIndex][i]*w, tetri_y[rotation][shapeIndex][i]*h, w, h);
      }
      super.render();
    }
  }
}

class Stone extends Material {
  int imgN;

  Stone(float x, float y, int imgN, int shapeIndex, int rotation, int team) {
    w = 15;
    h = 15;
    this.team = team;
    fragile = 0;
    fragileMax = 3000000;
    this.imgN = imgN;
    this.rotation = rotation;
    this.shapeIndex = shapeIndex;
    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    for (int i=0; i<4; i++) {
      PolygonShape sd = new PolygonShape();
      float box2dW = box2d.scalarPixelsToWorld(w/2);
      float box2dH = box2d.scalarPixelsToWorld(h/2);
      Vec2 offset = new Vec2(w*tetri_x[rotation][shapeIndex][i], h*tetri_y[rotation][shapeIndex][i]);
      offset = box2d.vectorPixelsToWorld(offset);
      sd.setAsBox(box2dW, box2dH, offset, 0);

      FixtureDef fd = new FixtureDef();
      fd.shape = sd; 
      fd.density = 30;
      fd.friction = 0.6;
      fd.restitution = 0;

      // Attach Fixture to Body               
      body.createFixture(fd);
    }
    body.setUserData(this);
  }

  void render() {
    if (!dead) {
      // We need the Body’s location and angle
      Vec2 pos = box2d.getBodyPixelCoord(body);    
      float a = body.getAngle();

      pushMatrix();
      translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
      rotate(-a);
      rectMode(CENTER);
      for (int i=0; i<4; i++) {
        stroke(255*(1-team), 0, 255*team);
        strokeWeight(2);
        rect(tetri_x[rotation][shapeIndex][i]*15, tetri_y[rotation][shapeIndex][i]*15, 15, 15);
        image(stoneImgs[imgN], tetri_x[rotation][shapeIndex][i]*w, tetri_y[rotation][shapeIndex][i]*h, w, h);
      }
      super.render();
    }
  }
}

void loadMaterialImgs() {
  woodImgs[0] = loadImage("images/wood01.png");
  woodImgs[1] = loadImage("images/wood02.png");
  woodImgs[2] = loadImage("images/wood03.png");
  stoneImgs[0]= loadImage("images/stone01.png");
  stoneImgs[1]= loadImage("images/stone02.png");
  stoneImgs[2]= loadImage("images/stone03.png");
  fragileImgs[0]= loadImage("images/fragile01.png");
  fragileImgs[1]= loadImage("images/fragile02.png");
  fragileImgs[2]= loadImage("images/fragile03.png");
}