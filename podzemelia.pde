final int MENU_STATE    = 0;
final int GAME_STATE    = 1;
final int PAUSED_STATE  = 2;
final int VICTORY_STATE = 3;
final int LOST_STATE    = 4;

int state = MENU_STATE;

void setup() { 
  fullScreen();
  background(0);

  loadFonts();
  loadSounds();  
  loadImages();
}

void draw() {
  background(0);

  switch (state) {
  case MENU_STATE:
    drawInMenu();
    break;
  case GAME_STATE:
    drawGame();
    break;
  case PAUSED_STATE:
    drawInPaused();
    break;
  case VICTORY_STATE:
    drawVictory();
    break;
  case LOST_STATE:
    drawLost();
    break;
  }
}

void drawInMenu() {
  image(menuFon, 0, 0);

  fill(200);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("DUNGEON", width / 2, height / 2);

  fill(255);
  textSize(50);
  text("Нажми 'Enter', что бы начать играть.", width / 2, height / 2 + 120);
  textSize(30);
  text("Нажми 'Esc', во время игры, что бы поставить на паузу.", width / 2, height / 2 + 160);
}

void drawGame() {
  image(gameFon, 0, 0);

  drawLevel();
  drawPlayer();
  drawPlayerScore();
}

void drawInPaused() {
  image(pausedFon, 0, 0);

  fill(255, 0, 0);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("【D【u【n】g【e【o【n】", width / 2, height / 2);

  fill(255);
  textSize(50);
  text("Нажми 'Esc', что бы вернуться в игру.", width / 2, height / 2 + 120);
}

float angle = 0;
void drawVictory() {
  noStroke();
  pushMatrix();
  translate(width / 2, height / 2);
  for (int i = 0; i < 100; i++) {
    rotate(angle);
    angle += 0.00003;
    translate( i * 10, 0);
    fill(255 * 10 / 100);
    rect(0, 100, 100, 100);
  }
  popMatrix();
  //image(wonFon, 0, 0);

  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Ты прошел игру! Поздравляю! Ты выйграл!", width / 2, height / 2 + 170);

  textSize(70);
  fill(255);
  text("Ваш счёт за всю игру! " + playerScore, width / 2, height / 2 + 270);

  textSize(50);
  text("Нажми 'Enter', что бы вернуться в меню", width / 2, height / 2 + 330);
}

void drawLost() {
  image(lostFon, 0, 0);

  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Ты проиграл:( ", width / 2, height / 2);

  textSize(70);
  fill(255);
  text("Твой счет стал меньше нуля :( ", width / 2, height / 2 + 70);

  textSize(40);
  text("Нажми 'Enter', что бы вернуться в меню. Удачи в следущий раз!", width / 2, height / 2 + 130);
}
void keyPressed() {
  switch (state) {
  case MENU_STATE:
    keyPressedInMenu();
    break;
  case GAME_STATE:
    keyPressedInGame();
    break;
  case PAUSED_STATE:
    keyPressedInPaused();
    break;
  case VICTORY_STATE:
    keyPressedInVictory();
    break;
  case LOST_STATE:
    keyPressedInLost();
    break;
  }
}

void keyPressedInMenu() {
  if (keyCode == ENTER) {
    playerScore = 0;
    currentLevelIndex = -1;
    loadNextLevel();
    state = GAME_STATE;
  }
}

void keyPressedInGame() {
  switch (keyCode) {
  case UP:
    movePlayer(0, -1);
    break;
  case DOWN:
    movePlayer(0, 1);
    break;
  case RIGHT:
    movePlayer(1, 0);
    break;
  case LEFT:
    movePlayer(-1, 0);
    break;
  case ESC:
    state = PAUSED_STATE;
    key = 0;
    break;
  }
  switch (key) {
  case 'w':
  case 'W':
    movePlayer(0, -1);
    break;
  case 's':
  case 'S':
    movePlayer(0, 1);
    break;
  case 'd':
  case 'D':
    movePlayer(1, 0);
    break;
  case 'a':
  case 'A':
    movePlayer(-1, 0);
    break;
  case ESC:
    state = PAUSED_STATE;
    key = 0;
    break;
  }
  if (keyCode == ESC) {
    state = PAUSED_STATE;
  }
}

void keyPressedInPaused() {
  if (keyCode == ESC) {
    key = 0;
    state = GAME_STATE;
  }
}

void keyPressedInVictory() {
  if (keyCode == ENTER) {
    state = MENU_STATE;
  }
}

void keyPressedInLost() {
  if (keyCode == ENTER) {
    state = MENU_STATE;
  }
}
