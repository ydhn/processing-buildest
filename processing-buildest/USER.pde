class User {
  int clientID;
  String name;
  Character character;
  int chara;
  int team;
  int index;
  int defenceContribution = 0;
  int attackContribution = 0;
  int tetrominoIndex;
  boolean isAClicked= false, isBClicked=false;
  boolean stoneMODE = false;
  int stoneSTATUS, stoneDELAY=200;
  User(int clientID, String name, int team, int chara) {
    this.name = name;
    this.clientID = clientID;
    this.team = team;
    this.chara = chara;
  }
  void newBlock() {
    Tetromino t = new Tetromino(team, index);
    Tetrominos.add(t);
    tetrominoIndex = Tetrominos.size()-1;
  }
};

ArrayList<User> Users = new ArrayList<User>();
IntDict IndexOfUsers = new IntDict();
String[] TeamName = {"RED TEAM", "BLUE TEAM"};

void addUser(int clientID, String name, int team, int chara) {
  User newUser = new User(clientID, name, team, chara);
  Users.add(newUser);
  int index = Users.size()-1;
  Users.get(index).index = index;
  if (chara==0) 
    Users.get(index).character = new CFireMan(team, 50, 500, index);
  else if (chara==1)
    Users.get(index).character = new CTankMan(team, 50, 500, index);
  else if (chara==2)
    Users.get(index).character = new CFlyMan(team, 50, 500, index);
  else if (chara==3)
    Users.get(index).character = new CBombMan(team, 50, 500, index);
  IndexOfUsers.set(String.valueOf(Users.get(index).clientID), index);
  newUser.newBlock();
  notify("WELCOME, " + name+ ". YOU'RE " + TeamName[team]);
}

void removeUser(int clientID) {
  Users.remove(IndexOfUsers.get(String.valueOf(clientID)));
}