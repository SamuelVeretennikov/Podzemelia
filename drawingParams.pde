final float CELL_SCALE = 1; //<>//

int cellSize;
int levelPixelWidth;
int levelPixelheight;
int centeringShiftX;
int centeringShiftY;

// Шрифты:
PFont mainFont;

//Текстуры:
PImage wallImage;
PImage doorImage;
Sprite coinSprite;
PImage stairsImage;
PImage floorImage;
PImage fakeWallImage;
SpritePlayerWalking playerWalking;
SpritePlayerIdling playerSprite;
SpriteSpider spiderSprite;
PImage Key;
PImage vkWhite;
PImage vkBlack;
PImage wallLImage;

//Фоны:
PImage menuFon;
PImage wonFon;
PImage lostFon;
PImage gameFon;
PImage pausedFon;

void recalcDrawingParams() {
  noStroke();
  cellSize = int(min(width / currentLevelWidth, height / currentLevelHeight) * CELL_SCALE);
  levelPixelWidth = currentLevelWidth * cellSize;
  levelPixelheight = currentLevelHeight * cellSize;
  centeringShiftX = (width - levelPixelWidth) / 2;
  centeringShiftY = (height - levelPixelheight) / 2;
}

void loadFonts() {
  mainFont = createFont("Gouranga-Pixel.ttf", 32);
  textFont(mainFont);
}

void loadImages() {
  wallImage = loadImage("wall.png");
  doorImage = loadImage("door.png");
  coinSprite = new Sprite("coin/coin", 9, ".png", 10);
  stairsImage = loadImage("stairs.png");
  floorImage = loadImage("floor.png");
  fakeWallImage = loadImage("fakeWall.png");
  playerWalking = new SpritePlayerWalking("playerWalking/playerWalking", 3, ".png");
  playerSprite = new SpritePlayerIdling("player/player", 2, ".png", 10);
  spiderSprite = new SpriteSpider("spider/spider", 7, ".png", 10);
  Key = loadImage("key.png");
  vkWhite = loadImage("vk.png");
  vkBlack = loadImage("vk-black.png");
  wallLImage = loadImage("wallL.png");

  //Фоны:
  menuFon = loadImage("game-pause-fon.png");
  wonFon = loadImage("fon-won.jpg");
  lostFon = loadImage("fon-lost.jpg");
  //gameFon = loadImage("game-pause-fon.png");
  pausedFon = loadImage("fon.jpg");
}

class Sprite {
  PImage[] images;
  int frame;

  int skip, _skip;
  int time = -1;

  Sprite(String imagePrefix, int count, String extension) {
    this(imagePrefix, count, extension, 3);
  }

  Sprite(String imagePrefix, int count, String extension, int skip) {
    images = new PImage[count];

    for (int i = 0; i < count; i++) {
      String fileName = imagePrefix + i + extension;
      images[i] = loadImage(fileName);
    }

    this.skip = skip;
    _skip = skip;
  }

  void draw(float x, float y, float width, float height) {
    if (time < 0 || time > 0) {
      _skip--;
      if (_skip < 0) {
        _skip = skip;
        frame = (frame + 1) % images.length;
      }
      if (time > 0) {
        --time;
      }

      image(images[frame], x, y, width, height);
    } else {
      image(images[0], x, y, width, height);
    }
  }
}

class SpritePlayerIdling {
  PImage[] images;
  int frame;

  int skip, _skip;
  int time = -1;

  SpritePlayerIdling(String imagePrefix, int count, String extension) {
    this(imagePrefix, count, extension, 3);
  }

  SpritePlayerIdling(String imagePrefix, int count, String extension, int skip) {
    images = new PImage[count];

    for (int i = 0; i < count; i++) {
      String fileName = imagePrefix + i + extension;
      images[i] = loadImage(fileName);
    }

    this.skip = skip;
    _skip = skip;
  }

  void draw(float x, float y, float width, float height) {
    if (time < 0 || time > 0) {
      _skip--;
      if (_skip < 0) {
        _skip = skip;
        frame = (frame + 1) % images.length;
      }
      if (time > 0) {
        --time;
      }

      image(images[frame], x, y, width, height);
    } else {
      image(images[0], x, y, width, height);
    }
  }
}

class SpritePlayerWalking {
  PImage[] images;
  int frame;

  int skip, _skip;
  int time = -1;

  SpritePlayerWalking(String imagePrefix, int count, String extension) {
    this(imagePrefix, count, extension, 3);
  }

  SpritePlayerWalking(String imagePrefix, int count, String extension, int skip) {
    images = new PImage[count];

    for (int i = 0; i < count; i++) {
      String fileName = imagePrefix + i + extension;
      images[i] = loadImage(fileName);
    }

    this.skip = skip;
    _skip = skip;
  }

  void draw(float x, float y, float width, float height) {
    if (time < 0 || time > 0) {
      _skip--;
      if (_skip < 0) {
        _skip = skip;
        frame = (frame + 1) % images.length;
      }
      if (time > 0) {
        --time;
      }

      image(images[frame], x, y, width, height);
    } else {
      image(images[0], x, y, width, height);
    }
  }
}

class SpriteSpider {
  PImage[] images;
  int frame;

  int skip, _skip;
  int time = -1;

  SpriteSpider(String imagePrefix, int count, String extension) {
    this(imagePrefix, count, extension, 3);
  }

  SpriteSpider(String imagePrefix, int count, String extension, int skip) {
    images = new PImage[count];

    for (int i = 0; i < count; i++) {
      String fileName = imagePrefix + i + extension;
      images[i] = loadImage(fileName);
    }

    this.skip = skip;
    _skip = skip;
  }

  void draw(float x, float y, float width, float height) {
    if (time < 0 || time > 0) {
      _skip--;
      if (_skip < 0) {
        _skip = skip;
        frame = (frame + 1) % images.length;
      }
      if (time > 0) {
        --time;
      }

      image(images[frame], x, y, width, height);
    } else {
      image(images[0], x, y, width, height);
    }
  }
}
