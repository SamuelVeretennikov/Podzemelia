final int POINTS_FOR_COIN = 1;
final int VIRUS_COIN = 5;

int playerX;
int playerY;
int playerScore = 0;

final int PLAYER_IDLING_STATE = 0;
final int PLAYER_WALKING_STATE = 1;

int playerState = PLAYER_IDLING_STATE;
int walkingFrames = 0;

void placePlayer(int x, int y) {
  playerX = x;
  playerY = y;
}

void movePlayer(int dx, int dy) {
  int nextX = playerX + dx;
  int nextY = playerY + dy;
  playerState = PLAYER_WALKING_STATE;
  walkingFrames = 10;

  if (currentLevel[nextY][nextX] != 'W') {
    playerX = nextX;
    playerY = nextY;
  }  
  if (currentLevel[nextY][nextX] == 'E') {
    loadNextLevel();
    nextLevelSound.play();
    nextLevelSound.rewind();
  } else if (currentLevel[nextY][nextX] == '*') {
    playerScore += POINTS_FOR_COIN;
    currentLevel[nextY][nextX] = ' ';
    coinSound.play();
    coinSound.rewind();
  } else if (currentLevel[nextY][nextX] == 'V') {
    playerScore -= VIRUS_COIN;
    currentLevel[nextY][nextX] = ' ';
    virusCoinSound.play();
    virusCoinSound.rewind();
  } else if (currentLevel[nextY][nextX] == 'e') {
    state = VICTORY_STATE;
    currentLevelIndex = -1;
  } else if (playerScore <= -1) {
    state = LOST_STATE;
  }
}


void drawPlayer() {
  int pixelX = playerX * cellSize + centeringShiftX;
  int pixelY = playerY * cellSize + centeringShiftY;

  if (playerState == PLAYER_WALKING_STATE) {
    playerWalking.draw (pixelX, pixelY, cellSize, cellSize);
  } else if (playerState == PLAYER_IDLING_STATE) {
    playerSprite.draw (pixelX, pixelY, cellSize, cellSize);
  }
  if (walkingFrames > 0) {
    walkingFrames --;
  } else { 
    playerState = PLAYER_IDLING_STATE;
  }
}

void drawPlayerScore() {
  fill(255);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Score " + playerScore, 1150, 20);
}
