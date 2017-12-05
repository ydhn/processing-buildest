int otx[][] = {{0, 1, 2, 3}, {0, 1, 2, 0}, {0, 1, 2, 2}, {0, 1, 0, 1}, {0, 1, 2, 1}, {0, 1, 1, 2}, {1, 2, 0, 1}};
int oty[][] = {{0, 0, 0, 0}, {0, 0, 0, 1}, {0, 0, 0, 1}, {0, 0, 1, 1}, {0, 0, 0, 1}, {0, 0, 1, 1}, {0, 0, 1, 1}};
int tetri_x[][][] = new int[4][7][4]; 
int tetri_y[][][] = new int[4][7][4]; 

int table[][] = new int[47][81];
ArrayList<Tetromino> Tetrominos;


class Tetromino {
  int x, y, team;
  boolean moving = false; 
  int shapeIndex;
  int userIndex;
  int woodORstone=0;
  int textureIndex=0;
  int rotation=0;
  Tetromino(int team, int userIndex) {
    this.team = team;
    this.userIndex = userIndex;
    Boolean newTetrominoAdded = false;
    while (!newTetrominoAdded) {
      shapeIndex = (int)random(0, 6);
      textureIndex = (int)random(0, 3); 
      if (Users.get(userIndex).stoneMODE) woodORstone=1;
      x = (int)random(0, 80);
      y = 2;
      boolean okay=true;
      for (int i=0; i<4; i++) {
        if (table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] != -1) {
          okay=false;
          break;
        }
      }
      if (okay) {
        newTetrominoAdded = true;
      }
    }
    moving = true;
    for (int i=0; i<4; i++) {
      table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
    }
  }

  void render() {
    pushMatrix();
    translate(x*15, (y-1)*15);
    for (int i=0; i<4; i++) {
      imageMode(CORNER);
      rectMode(CORNER);
      stroke(255*(1-team),0,255*team);
      strokeWeight(2);
      rect(tetri_x[rotation][shapeIndex][i]*15, tetri_y[rotation][shapeIndex][i]*15, 15, 15);
      if (woodORstone==0)
        image(woodImgs[textureIndex], tetri_x[rotation][shapeIndex][i]*15, tetri_y[rotation][shapeIndex][i]*15, 15, 15);
      else image(stoneImgs[textureIndex], tetri_x[rotation][shapeIndex][i]*15, tetri_y[rotation][shapeIndex][i]*15, 15, 15);
      tint(255);
    }
    popMatrix();
  }

  void finishMoving() {
    moving = false;
    Users.get(userIndex).newBlock();
    Users.get(userIndex).defenceContribution += 10000;
  }

  void rotate() {
    for (int i=0; i<4; i++) {
      table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = -1;
    }
    boolean okay=true;
    rotation++;
    if (rotation>3) rotation=0;
    for (int i=0; i<4; i++) {
      if (table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] != -1) {
        okay=false;
        break;
      }
    }
    if (!okay) {
      rotation--;
      if (rotation<0) rotation=3;
    }    
    for (int i=0; i<4; i++) {
      table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
    }
  }

  void step() {
    if (moving) {
      for (int i=0; i<4; i++) {
        table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = -1;
      }
      y+=1;
      boolean okay=true;
      for (int i=0; i<4; i++) {
        if (table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] != -1) {
          okay=false;
          break;
        }
      }  
      if (!okay) {
        y-=1;
        for (int i=0; i<4; i++) {
          table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
        }
        finishMoving();
      } else {
        for (int i=0; i<4; i++) {
          table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
        }
      }
    }
  }

  void right() {
    for (int i=0; i<4; i++) {
      table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = -1;
    }
    x+=1;
    boolean okay=true;
    if (!((x<=80) && (x>=0))) okay=false;
    else {
      for (int i=0; i<4; i++) {
        if (table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] != -1) {
          okay=false;
          break;
        }
      }
    }
    if (!okay) {
      x-=1;
      for (int i=0; i<4; i++) {
        table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
      }
    } else {
      for (int i=0; i<4; i++) {
        table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
      }
    }
  }

  void left() {
    for (int i=0; i<4; i++) {
      table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = -1;
    }
    x-=1;
    boolean okay=true;
    if (!((x<=80) && (x>=0))) okay=false;
    else {
      for (int i=0; i<4; i++) {
        if (table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] != -1)
          okay=false;
      }
    }
    if (!okay) {
      x+=1;
      for (int i=0; i<4; i++) {
        table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
      }
    } else {
      for (int i=0; i<4; i++) {
        table[y+tetri_y[rotation][shapeIndex][i]][x+tetri_x[rotation][shapeIndex][i]] = team;
      }
    }
  }
}

void loadTetris() {
  // Rotation map
  tetri_x[0] = otx;
  tetri_y[0] = oty;
  for (int i=1; i<4; i++) {
    tetri_x[i] = new int[7][4];
    tetri_y[i] = new int[7][4];
    for (int tetri_num=0; tetri_num<7; tetri_num++) {
      int t[][] = new int[8][8];
      for (int j=0; j<4; j++) {
        t[tetri_y[i-1][tetri_num][j]+4][tetri_x[i-1][tetri_num][j]+4]=1;
      }
      //t is original 4x4 tetromino array
      int y=-1; 
      int x=-1; // This will be the first block
      for (int yy=7; yy>=0; yy--) {
        for (int xx=0; xx<8; xx++) {
          if (t[yy][xx]==1) {
            y=yy;
            x=xx;
            break;
          }
        }
        if (y!=-1) break;
      }
      //tetri_x[i][tetri_num][0] = x;
      //tetri_y[i][tetri_num][0] = y;
      int cnt=0;

      for (int yy=7; yy>=0; yy--) {
        for (int xx=0; xx<8; xx++) {
          if (t[yy][xx]==1) {
            tetri_x[i][tetri_num][cnt]=y-yy;
            tetri_y[i][tetri_num][cnt]=xx-x;
            cnt++;
          }
        }
      }
    }
  }

  Tetrominos = new ArrayList<Tetromino>();
  for (int i=0; i<39; i++) {
    for (int j=0; j<80; j++) {
      table[i][j] = -1;
    }
  }
  for (int i=0; i<80; i++) table[39][i] = 1000;
  for (int i=0; i<37; i++) table[i][80] = 1000;
}

void stepTetris() {
  for (int i=0; i<Tetrominos.size(); i++) {
    Tetrominos.get(i).step();
  }
  for (int i=0; i<Users.size(); i++) {
    if (Users.get(i).stoneMODE) {
      Users.get(i).stoneSTATUS = max(Users.get(i).stoneSTATUS-1, 0);
      if (Users.get(i).stoneSTATUS == 0) {
        Users.get(i).stoneMODE = false;
        Users.get(i).stoneDELAY = 300;
      }
    }
    Users.get(i).stoneDELAY = max(Users.get(i).stoneDELAY-10, -10);
    if (Users.get(i).stoneDELAY == 0) {
      notify(Users.get(i).name + ", STONE MODE AVAILABLE!");
    }
  }
}

void renderTetris() {
  for (int i=0; i<Tetrominos.size(); i++) {
    Tetrominos.get(i).render();
  }
}