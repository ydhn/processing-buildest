//PImage characterImgs[] = new PImage[10];
PImage characterImgs[][][] = new PImage[2][4][3];  //[team][type][1,2,3 walking sequence]
class Character {
  float w, h;
  int characterImgsIndex;
  int characterImgsSeq;
  int seqCount=0;
  int userIndex;
  Body body;      
  Boolean dead = false;
  int fragile, fragileMax;
  float x, y, v;
  float relativeXvel=0, relativeYvel=0;
  float characterVelocity=40, jumpAbility=20;
  Boolean jumpEnd=true;
  int jumpStatus=0, jumpDelay=200;
  int team;
  Character(int team) {
    this.team = team;
  }

  void render() {
    seqCount++;
    if(seqCount==3) {
      seqCount=0;
      characterImgsSeq++;
      if(characterImgsSeq==3) characterImgsSeq = 0;
    }
    if (!jumpEnd) { 
      jumpStatus--;
      if (jumpStatus == 0) jumpEnd=true;
    }
    popMatrix();
    /*x += v;
     if (x < 0 || x > width-15) {
     x = constrain(x, 0, width-15);
     }
     strokeWeight(2);
     stroke(255*(1-team), 0, 255*team);
     rect(x, y, 15, 15);*/
  }

  void goRight() {
    Vec2 vel = body.getLinearVelocity();
    vel.x += characterVelocity;
    body.setLinearVelocity(vel);
    relativeXvel += characterVelocity;
  }

  void goLeft() {
    Vec2 vel = body.getLinearVelocity();
    vel.x -= characterVelocity;
    body.setLinearVelocity(vel);
    relativeXvel -= characterVelocity;
  }

  void goStop() {
    Vec2 vel = body.getLinearVelocity();
    vel.x -= relativeXvel;
    body.setLinearVelocity(vel);
    relativeXvel -= relativeXvel;
  }

  void jump() {
    if (jumpEnd) {
      Vec2 vel = body.getLinearVelocity();
      vel.y += jumpAbility;
      body.setLinearVelocity(vel);
      jumpEnd = false;
      jumpStatus=(int)jumpDelay;
    }
  }
}

class CFireMan extends Character {
  CFireMan(int team, float x, float y, int userIndex) {
    super(team);
    this.userIndex = userIndex; 
    w = 39;
    h = 53;
    fragile = 0;
    fragileMax = 1000;
    characterImgsIndex = 0;
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.fixedRotation = true;
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 100;
    fd.friction = 0;
    fd.restitution = 0.4;

    // Attach Fixture to Body               
    body.createFixture(fd);
    body.setUserData(this);
  }
  void render() {
    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body); 

    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);
    imageMode(CENTER);
    image(characterImgs[team][characterImgsIndex][characterImgsSeq], 0, 0, w, h);
    
    super.render();
  }
}

class CTankMan extends Character {
  CTankMan(int team, float x, float y, int userIndex) {
    super(team);
    this.userIndex = userIndex; 
    w = 43;
    h = 45;
    fragile = 0;
    fragileMax = 1000;
    characterImgsIndex = 1;
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.fixedRotation = true;
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 100;
    fd.friction = 0;
    fd.restitution = 0.4;

    // Attach Fixture to Body               
    body.createFixture(fd);
    body.setUserData(this);
  }
  void render() {
    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body); 

    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);
    imageMode(CENTER);
    image(characterImgs[team][characterImgsIndex][characterImgsSeq], 0, 0, w, h);
    
    super.render();
  }
}

class CFlyMan extends Character {
  CFlyMan(int team, float x, float y, int userIndex) {
    super(team);
    this.userIndex = userIndex;
    jumpDelay = 50;
    jumpAbility = 25;
    characterVelocity = 10;
    w = 36;
    h = 66;
    fragile = 0;
    fragileMax = 1000;
    characterImgsIndex = 2;
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.fixedRotation = true;
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 100;
    fd.friction = 0;
    fd.restitution = 0.4;

    // Attach Fixture to Body               
    body.createFixture(fd);
    body.setUserData(this);
  }
  void render() {
    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body); 

    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);
    imageMode(CENTER);
    image(characterImgs[team][characterImgsIndex][characterImgsSeq], 0, 0, w, h);
    
    super.render();
  }
}

class CBombMan extends Character {
  CBombMan(int team, float x, float y, int userIndex) {
    super(team);
    this.userIndex = userIndex; 
    w = 28;
    h = 56;
    fragile = 0;
    fragileMax = 1000;
    characterImgsIndex = 3;
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.fixedRotation = true;
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 100;
    fd.friction = 0;
    fd.restitution = 0.4;

    // Attach Fixture to Body               
    body.createFixture(fd);
    body.setUserData(this);
  }
  void render() {
    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body); 

    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);
    imageMode(CENTER);
    image(characterImgs[team][characterImgsIndex][characterImgsSeq], 0, 0, w, h);
    
    super.render();
  }
}

void loadCharacterImgs() {
  characterImgs[0][0][0] = loadImage("characters/000.png");
  characterImgs[0][0][1] = loadImage("characters/001.png");
  characterImgs[0][0][2] = loadImage("characters/002.png");
  characterImgs[0][1][0] = loadImage("characters/010.png");
  characterImgs[0][1][1] = loadImage("characters/011.png");
  characterImgs[0][1][2] = loadImage("characters/012.png");
  characterImgs[0][2][0] = loadImage("characters/020.png");
  characterImgs[0][2][1] = loadImage("characters/021.png");
  characterImgs[0][2][2] = loadImage("characters/022.png");
  characterImgs[0][3][0] = loadImage("characters/030.png");
  characterImgs[0][3][1] = loadImage("characters/031.png");
  characterImgs[0][3][2] = loadImage("characters/032.png");
  characterImgs[1][0][0] = loadImage("characters/100.png");
  characterImgs[1][0][1] = loadImage("characters/101.png");
  characterImgs[1][0][2] = loadImage("characters/102.png");
  characterImgs[1][1][0] = loadImage("characters/110.png");
  characterImgs[1][1][1] = loadImage("characters/111.png");
  characterImgs[1][1][2] = loadImage("characters/112.png");
  characterImgs[1][2][0] = loadImage("characters/120.png");
  characterImgs[1][2][1] = loadImage("characters/121.png");
  characterImgs[1][2][2] = loadImage("characters/122.png");
  characterImgs[1][3][0] = loadImage("characters/130.png");
  characterImgs[1][3][1] = loadImage("characters/131.png");
  characterImgs[1][3][2] = loadImage("characters/132.png");
  
}