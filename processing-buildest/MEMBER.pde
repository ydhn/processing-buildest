void showTeam() {

  textAlign(LEFT);
  fill(255, 0, 0);
  textSize(26);
  text("RED TEAM", 30, 200);
  textAlign(RIGHT);
  fill(101, 206, 255);
  text("BLUE TEAM", width-30, 200);
  int redTeamN = 0;
  int blueTeamN = 0; 
  fill(255);
  for (int i=0; i<Users.size(); i++) {
    User u = Users.get(i);
    if (u.team == 0) {
      redTeamN ++;
      textAlign(LEFT);
      textSize(26);
      text(u.name + " / ", 30, 200+26*redTeamN);
      float bigW = textWidth(u.name + " / ");
      textSize(18);
      text("CONTRIBUTION ON DEF: " + Integer.toString(u.defenceContribution) + " / ATK: " + Integer.toString(u.attackContribution), 30 + bigW, 200+26*redTeamN);
    } else if (u.team == 1) {
      blueTeamN ++;
      textAlign(RIGHT);
      textSize(26);
      text(" / " + u.name, width - 30, 200+26*blueTeamN);
      float bigW = textWidth(" / " + u.name);
      textSize(18);
      text("CONTRIBUTION ON DEF: " + Integer.toString(u.defenceContribution) + " / ATK: " + Integer.toString(u.attackContribution), width-30-bigW, 200+26*blueTeamN);
    }
  }
  
  if(StartCounting==0 && redTeamN > 0 && blueTeamN > 0) {
    StartCounting = 20;
    
  }
}