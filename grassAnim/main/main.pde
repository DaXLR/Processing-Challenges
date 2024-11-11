int screenSizeX;
int screenSizeY;

springLine s1 = new springLine(400, 700, 10);


void settings() {
 size(800,800);
  screenSizeX = displayWidth;
  screenSizeY = displayHeight;
}

void setup() {
  background(0);
  
}

void draw() {
  background(0);
  s1.setDeflection(calculateDeviation());
  s1.drawLine();
}
