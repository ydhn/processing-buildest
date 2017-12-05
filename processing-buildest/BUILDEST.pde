//BUILDEST PROTOTYPE
//HAN YUN DO | KWON JI MIN

public int x;
public int v=0;
int mode=0; //0: BUILD MODE, 1: DESTROY MODE
PImage background, cloud1, cloud2, night, mountain;
PFont font, sfont;
float cloud1x = 0, cloud2x = 2400;
int nightStart;
String Mode = "[TETRIS DEFENCE]";
int leftMin=3, leftSec=0;
int StartCounting=0;
boolean isStarted = false;

void setup() { 
  imageMode(CENTER);
  font = loadFont("Koverwatch-48.vlw");
  sfont = loadFont("Koverwatch-18.vlw");
  textFont(font);
  
  background = loadImage("images/day.png");
  night = loadImage("images/night.png");
  cloud1 = loadImage("images/cloud.png");
  cloud2 = loadImage("images/cloud.png");
  mountain = loadImage("images/mountain.png");
  
  loadCharacterImgs();
  loadMaterialImgs();
  loadTetris();
  loadPhysicalEngine();
  loadBoundary();
  size(1200, 600, P3D);
  background(255);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Connecting to Adapter server...", width/2, height/2);
}

void draw() {
  if (frameCount==1) init();
  background(255);
  imageMode(CORNER);
  image(background, 0, 0);
  
  if (mode==2) { // animation mode
    int current = frameCount-nightStart; 
    if(current >= 0 && current <= 720) {
      tint(255, map(current,0,420,0,255));
      image(night, 0, -720+current); 
      tint(255);
    }
    if(current >= 720) {
      changeDestroyMode();
    }
  }
  else if(mode==1) {
    image(night, 0, 0);
  }
  
  if (StartCounting > 0) {
    if(frameCount % 60 == 0) {
      notify(Integer.toString(StartCounting));
      StartCounting --;
      if(StartCounting == 0) {
        isStarted = true; 
        StartCounting = -1; //Not to start again.
      }
    }
  }
  
  if(isStarted) {
    if(frameCount % 60 == 0) {
      leftSec --;
      if(leftMin == 0 && leftSec == 11 && mode==0) { changeIntoNight(); }
      if(leftMin == 0 && leftSec == 0 && mode==1) { gameOver(); }
      if(leftSec < 0) { leftSec=59; leftMin--; }
      if(leftMin < 0) {
        leftMin = 0;    
      }
    }
  }
  
  image(cloud1, cloud1x, 0);
  image(cloud2, cloud2x, 0);
  image(mountain, 0, 0);
  cloud1x-=0.1;
  cloud2x-=0.1;
  if(cloud1x <= -2400) cloud1x=2400;
  if(cloud2x <= -2400) cloud2x=2400;
  
  noStroke();
  box2d.step();

  if ((mode==0 || mode==2) && isStarted) { // BUILD MODE
    renderTetris();
    if (frameCount%60==0) {
      stepTetris();
    }
  }

  if (mode==1) { // DESTORY MODE
    for (User user : Users) user.character.render();
    for (Material m : Materials) m.render();
    for (int i=0; i<Materials.size(); i++)
      if (Materials.get(i).dead) 
        Materials.remove(i);
  }

  for (Boundary boundary : Boundaries) boundary.render();
  
  if(!(mode==4)) {
    showTeam();
    showTime();
  }
  showNotifications();
  textFont(sfont);
  fill(255);
  textSize(18);
  textAlign(CENTER);
  text("Access yun.do/buildest", width/2, height-12);
  textFont(font);
}

void init() {
  client = new WebsocketClient(this, adapterAddress);
  notify("Welcome to BUILDEST.");
  notify("The game needs at least one player in each team to play.");
  notify("Access yun.do/buildest with your mobile phone.");
}