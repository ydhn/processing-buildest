import websockets.*;
WebsocketClient client;
final String adapterAddress = "ws://server.yun.do:89";  

int a=0, b=0;
void webSocketEvent(String rawReceived) {
  JSONObject json = JSONObject.parse(rawReceived);
  String eventType = json.getString("type");
  int clientID = json.getInt("clientID");
  if (eventType.equals("new_user")) {
    addUser(clientID, json.getString("name"), json.getInt("team"), json.getInt("chara"));
  } else if (eventType.equals("bye_user")) {
    //removeUser(clientID);
  } else if (eventType.equals("push")) { 
    if (json.getInt("btn") == 0) {        //LEFT
      if (mode==0 || mode==2) {
        int tIndex = Users.get(IndexOfUsers.get(String.valueOf(clientID))).tetrominoIndex;
        Tetrominos.get(tIndex).left();
      } else if (mode==1) Users.get(IndexOfUsers.get(String.valueOf(clientID))).character.goLeft();
    } else if (json.getInt("btn") == 1) { //RIGHT
      if (mode==0 || mode==2) {

        int tIndex = Users.get(IndexOfUsers.get(String.valueOf(clientID))).tetrominoIndex;
        Tetrominos.get(tIndex).right();
      } else if (mode==1) Users.get(IndexOfUsers.get(String.valueOf(clientID))).character.goRight();
    } else if (json.getInt("btn") == 2) { //A
      Users.get(IndexOfUsers.get(String.valueOf(clientID))).isAClicked=true;
      if (mode==0 || mode==2) {
        int tIndex = Users.get(IndexOfUsers.get(String.valueOf(clientID))).tetrominoIndex;
        Tetrominos.get(tIndex).step();
      } else if (mode==1) Users.get(IndexOfUsers.get(String.valueOf(clientID))).character.jump();
    } else if (json.getInt("btn") == 3) { //B
      Users.get(IndexOfUsers.get(String.valueOf(clientID))).isBClicked=true;
      if (mode==0 || mode==2) {
        int tIndex = Users.get(IndexOfUsers.get(String.valueOf(clientID))).tetrominoIndex;
        Tetrominos.get(tIndex).rotate();
      } else if (mode==1) Users.get(IndexOfUsers.get(String.valueOf(clientID))).character.jump();
    }
  } else if (eventType.equals("pop")) {
    if (json.getInt("btn") <= 1) Users.get(IndexOfUsers.get(String.valueOf(clientID))).character.goStop();
    else if (json.getInt("btn")==2) Users.get(IndexOfUsers.get(String.valueOf(clientID))).isAClicked=false;
    else if (json.getInt("btn")==3) Users.get(IndexOfUsers.get(String.valueOf(clientID))).isBClicked=false;
  }
  if (Users.get(IndexOfUsers.get(String.valueOf(clientID))).isAClicked && Users.get(IndexOfUsers.get(String.valueOf(clientID))).isBClicked) {
    
    if (Users.get(IndexOfUsers.get(String.valueOf(clientID))).stoneDELAY <= 0) {
      Users.get(IndexOfUsers.get(String.valueOf(clientID))).stoneDELAY = 300;
      Users.get(IndexOfUsers.get(String.valueOf(clientID))).stoneMODE = true;
      Users.get(IndexOfUsers.get(String.valueOf(clientID))).stoneSTATUS = 15;
      Tetromino t = Tetrominos.get(Users.get(IndexOfUsers.get(String.valueOf(clientID))).tetrominoIndex);
      t.woodORstone = 1;
      notify(Users.get(IndexOfUsers.get(String.valueOf(clientID))).name + " is now STONE MODE!!");
    }
  }

}