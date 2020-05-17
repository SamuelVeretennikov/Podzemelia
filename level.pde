int currentLevelIndex = -1;
char[][] currentLevel;
int currentLevelWidth;
int currentLevelHeight;

void loadNextLevel() {
  if (currentLevelIndex >= LEVELS.length - 1) {
    state = VICTORY_STATE;
    return;
  }

  currentLevelIndex++;
  currentLevelWidth = LEVELS[currentLevelIndex][0].length;
  currentLevelHeight = LEVELS[currentLevelIndex].length;
  currentLevel = new char[currentLevelHeight][currentLevelWidth];

  for (int y = 0; y < currentLevelHeight; y++) {
    for (int x = 0; x < currentLevelWidth; x++) {
      char cell = LEVELS[currentLevelIndex][y][x];
      if (cell == 'P') {
        placePlayer(x, y);
      }
      currentLevel[y][x] = cell;
    }
  }
  recalcDrawingParams();
}

void drawLevel() {
  for (int y = 0; y < currentLevelHeight; y++) {
    for (int x = 0; x < currentLevelWidth; x++) {
      int pixelX = x * cellSize + centeringShiftX;
      int pixelY = y * cellSize + centeringShiftY;
      char cell = currentLevel[y][x];
      switch (cell) {
      case 'W':
        image(wallImage, pixelX, pixelY, cellSize, cellSize);
        break;
      case ' ':
        fill(200, 200, 200);
        image(floorImage, pixelX, pixelY, cellSize, cellSize);
        break;
      case 'P':
        fill(200, 200, 200);
        image(floorImage, pixelX, pixelY, cellSize, cellSize);
        //rect(pixelX, pixelY, cellSize, cellSize);
        break;
      case 'E':
        image(floorImage, pixelX, pixelY, cellSize, cellSize);
        image(stairsImage, pixelX, pixelY, cellSize, cellSize);
        break;
      case 'e':        
        image(floorImage, pixelX, pixelY, cellSize, cellSize);        
        image(stairsImage, pixelX, pixelY, cellSize, cellSize);
        break;
      case '*':
        fill(200, 200, 200);
        image(floorImage, pixelX, pixelY, cellSize, cellSize);        
        coinSprite.draw(pixelX, pixelY, cellSize, cellSize);
        break;
      case 'F':
        image(fakeWallImage, pixelX, pixelY, cellSize, cellSize);
        break;
      case 'V':
        fill(200, 200, 200);
        image(floorImage, pixelX, pixelY, cellSize, cellSize);        
        spiderSprite.draw(pixelX, pixelY, cellSize, cellSize);
        break;
      case 'K':
        fill(200, 200, 200);
        image(floorImage, pixelX, pixelY, cellSize, cellSize);
        image(Key, pixelX, pixelY, cellSize, cellSize);
        break;
      }
    }
  }
}
