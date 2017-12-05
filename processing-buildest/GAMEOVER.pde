void gameOver() {
  int redTeamN=0, blueTeamN=0;
  int redScore=0, blueScore=0;
  for (int i=0; i<Users.size(); i++) {
    User u = Users.get(i);
    if (u.team == 0) {
      redTeamN ++;
      redScore += u.defenceContribution + u.attackContribution;
    } else if (u.team == 1) {
      blueTeamN ++;
      blueScore += u.defenceContribution + u.attackContribution;
    }
  }
  redScore /= redTeamN;
  blueScore /= blueTeamN;
  if (redScore > blueScore) {
    notiTime=30000;
    notify("RED WINS!");   
    for (int i=0; i<Users.size(); i++) {
      User u = Users.get(i);
      if (u.team == 0) {
        notify(u.name);
      }
    }
    notify("THANK YOU FOR PLAYING!");
  } else { 
    notify("BLUE WINS!");
    for (int i=0; i<Users.size(); i++) {
      User u = Users.get(i);
      if (u.team == 1) {
        notify(u.name);
      }
    }
    notify("THANK YOU FOR PLAYING!");
  }
  mode = 4;
}