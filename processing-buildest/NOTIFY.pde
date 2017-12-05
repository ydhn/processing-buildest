int notificationN = 0;
String notifications[] = new String[50];
int notifications_time[] = new int[50];
int notiTime = 10000;
void showTime() {
  noStroke();
  fill(0, 100);
  rectMode(CORNER);
  rect(width/2-150, 0, 300, 120);
  textAlign(CENTER);
  fill(255);
  textSize(25);
  text(Mode + " TIME LEFT", width/2, 40);
  textSize(60);
  text(Integer.toString(leftMin) + ":" + Integer.toString(leftSec), width/2, 100);
}

void notify(String s) {
  boolean good = false;
  for(int i=0; i<notificationN; i++) {
    if(notifications_time[i] > notiTime) {
      notifications_time[i] = 0;
      notifications[i] = s;
      good = true;
      break;
    }
  }
  if (!good) {
    notifications_time[notificationN] = 0;
    notifications[notificationN] = s;
    notificationN ++;
  }
}

void showNotifications() {
  textAlign(CENTER);
  textSize(36);
  
  for(int i=0; i<notificationN; i++) {
    notifications_time[i] += 30;
    fill(255, map( constrain(abs(notifications_time[i]-notiTime/2),0,notiTime/2), notiTime/2, 0, 0, 255) );
    text(notifications[i], width/2, 160+i*36);
  }
}