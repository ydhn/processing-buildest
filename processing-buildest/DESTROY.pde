void changeIntoNight() {
  notify("Get ready for the battle night...");
  mode = 2;
  nightStart = frameCount;
}

void changeDestroyMode() {
  notify("ATTACK MODE STARTED!!");
  Mode = "[ATTACK MODE]";
  for (int i=0; i<Tetrominos.size(); i++) {
    Tetromino t = Tetrominos.get(i);
    Material m;
    if (t.woodORstone == 0) {
      int x = t.x*15, y=(t.y+1)*15;
      m = new Wood(x, y, t.textureIndex, t.shapeIndex, t.rotation, t.team);
      Materials.add(m);
    } else {
      int x = t.x*15, y=(t.y+1)*15;
      m = new Stone(x, y, t.textureIndex, t.shapeIndex, t.rotation, t.team);
      Materials.add(m);
    }
  }
  mode = 1;
}