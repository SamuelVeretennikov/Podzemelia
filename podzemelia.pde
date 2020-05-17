final int MENU_STATE    = 0; 
final int GAME_STATE    = 1;
final int PAUSED_STATE  = 2;
final int VICTORY_STATE = 3;
final int LOST_STATE    = 4;

int rectX, rectY;
color rectColor;
color rectHighlight;
boolean rectOver = false;
int rectSize1 = 200;
int rectSize2 = 50;

int state = MENU_STATE;
boolean overButton = false;

void setup() { 
  fullScreen();  
  background(0);
  frameRate(60);

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
  if (overButton == true) {
    image(vkBlack, 0, 700, 75, 75);
  } else {
    image(vkWhite, 0, 700, 75, 75);
  }
  rectColor = color(0);
  rectHighlight = color(51);
  rectX = width/2 - 100;
  rectY = height/2 - 20;
  ellipseMode(CENTER);

  noStroke();
  fill(0, 0, 0, 20);
  rect(0, 0, width, height);

  update(mouseX, mouseY);

  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255, 0, 0);
  rect(rectX, rectY, rectSize1, rectSize2);

  noStroke();

  fill(200, 0, 0);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("DUNGEON", width / 2, height / 2 - 100);

  fill(0, 255, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("PLAY", width / 2, height / 2);

  fill(255, 166, 0);
  textSize(30);
  text("Нажми 'Esc', во время игры, что бы поставить на паузу.", width / 2, height / 2 + 60);

  textSize(30);
  text("Stay Home! :)", width / 2, height / 2 + 100);
}

void update(int x, int y) {
  if ( overRect(width / 2 - 100, height / 2 - 30, 200, 50) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  if (overButton) { 
    link("https://vk.com/sam177aby");
  }
  if (rectOver) {
    initGame();
    state = GAME_STATE;
  }
}

void mouseMoved() { 
  checkButtons();
}

void mouseDragged() {
  checkButtons();
}

void checkButtons() {
  if (mouseX > 0 && mouseX < 60 && mouseY > 690 && mouseY < 900) {
    overButton = true;
  } else {
    overButton = false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawGame() {
  drawLevel();
  drawPlayer();
  drawPlayerScore();
}

void drawInPaused() {
  fill(200, 0, 0);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("Dungeon", width / 2, height / 2);

  fill(255, 166, 0);
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
  fill(255, 100, 50);
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

void initGame() {
  playerScore = 0;
  currentLevelIndex = -1;
  loadNextLevel();
}

void keyPressedInMenu() {
  if (keyCode == ENTER) {
    initGame();
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
