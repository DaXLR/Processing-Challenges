int screenSizeX = 1200;
int screenSizeY = 1200;
boolean paintMode = false;
boolean isJumping = false;
float prevXmouse, prevYmouse;

ArrayList<Bean> beans = new ArrayList<Bean>();

void settings() {
  size(screenSizeX, screenSizeY);
}

void setup() {
  background(0, 0, 0);
}

void draw() {
  
  if (!paintMode){
  background(0, 0, 0);
  }
  updateBeans();
  prevXmouse = mouseX;
  prevYmouse = mouseY;
}

void updateBeans() {

  for (int i = beans.size()-1; i >= 0; i--) {
    Bean bean = beans.get(i);

    bean.update(isJumping);
    if (bean.isAlive == false)
    {
      beans.remove(i);
    }
  }
}

void keyPressed()
{
  if (key == 'n') {
    beans.add(new Bean(IDcounter, mouseX, mouseY, mouseX-prevXmouse, mouseY-prevYmouse));
    IDcounter += 1;
  }
  if (key == 'p') {
    paintMode = !paintMode;
  }
  if (key == 'j') {
    isJumping = !isJumping;
  }
  
}
