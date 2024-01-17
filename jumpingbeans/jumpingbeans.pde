float degToRadian = 0.0174533;

//Variables pour la grosseur de l'ecran
int screenSizeX = 1200;
int screenSizeY = 1200;

//Longeurs de cube pour la simulation (aucune incidence sur le visuel)
int xlength = 1000;
int ylength = 1000;
int zlength = 1000;


//Diverses variables pour le calcul du cube et des positions screenspace equivalentes
float sideLength;
float sideLengthRatio = 1; //1

float rightSideAngle = 10 * degToRadian; //10 
float leftSideAngle = 40 * degToRadian; //40 

Point A = new Point(0, 0);
Point B = new Point(0, 0);
Point C = new Point(0, 0);
Point D = new Point(0, 0);
Point E = new Point(0, 0);
Point F = new Point(0, 0);
Point G = new Point(0, 0);
Point H = new Point(0, 0);

Point origin = new Point(0, 0);
Point result = new Point(0, 0);

float bounceReactValue = 50.0;
float bounceReactDecay = 1.0;
float topAlpha = 50;
float leftAlpha = 50;
float rightAlpha = 50;
float backAlpha = 50;
float bottomAlpha = 50;
float frontAlpha = 50;


//Variables de controle
boolean paintMode = false;
boolean isJumping = false;
boolean drawCube = true;
boolean bounceReact = true;
float prevXmouse, prevYmouse;

//Array de Beans
ArrayList<Bean> beans = new ArrayList<Bean>();



void settings() {
  size(screenSizeX, screenSizeY);
}

void setup() {
  background(0, 0, 0);
  recalculateCube();
}

void draw() {

  if (!paintMode) {
    background(0, 0, 0);
    if (drawCube) {
      drawCube(true);
    }
  }

  if (beans.size()>= 2) {
    reorderBeans();
  }
  updateBeans();
  if (drawCube)
  {
    drawCube(false);
  }
  prevXmouse = mouseX;
  prevYmouse = mouseY;
}

void recalculateCube()
{
  //Pre-calcule les points du cube une seule fois
  if (screenSizeX < screenSizeY)
  {
    sideLength = (screenSizeX/2 * sideLengthRatio);
  } else {
    sideLength = (screenSizeY/2 * sideLengthRatio);
  }
  A.X = (screenSizeX/2) - 0.11 * sideLength;
  A.Y = (screenSizeY/2) - 0.09 * sideLength;
  float rightSideYoffset = sin(rightSideAngle) * sideLength;
  float rightSideXoffset = cos(rightSideAngle) * sideLength;
  float leftSideYoffset = sin(leftSideAngle) * sideLength;
  float leftSideXoffset = cos(leftSideAngle) * sideLength;
  B.X = A.X + rightSideXoffset;
  B.Y = A.Y - rightSideYoffset;
  C.X = B.X;
  C.Y = B.Y + sideLength;
  D.X = A.X;
  D.Y = A.Y + sideLength;
  E.X = D.X - leftSideXoffset;
  E.Y = D.Y - leftSideYoffset;
  F.X = A.X - leftSideXoffset;
  F.Y = A.Y - leftSideYoffset;
  G.X = F.X + rightSideXoffset;
  G.Y = F.Y - rightSideYoffset;
  H.X = G.X;
  H.Y = G.Y + sideLength;
  origin.X = A.X;
  origin.Y = A.Y;
}

void reorderBeans()
{
  boolean done = false;
  while (!done)
  {
    done = true;

    Bean previousBean = beans.get(0);
    for (int i = 1; i <= beans.size()-1; i++) {
      Bean currentBean = beans.get(i);

      if (currentBean.z < previousBean.z)
      {
        beans.remove(i-1);
        beans.add(i-1, currentBean);
        beans.remove(i);
        beans.add(i, previousBean);
        done = false;
      } else {
        previousBean = currentBean;
      }
    }
  }
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

void drawCube(boolean beforeBeans)
{

  if (backAlpha > 0)
  {
    backAlpha -= bounceReactDecay;
  } else {
    backAlpha = 0;
  }
  if (leftAlpha > 0)
  {
    leftAlpha -= bounceReactDecay;
  } else {
    leftAlpha = 0;
  }
  if (rightAlpha > 0)
  {
    rightAlpha -= bounceReactDecay;
  } else {
    rightAlpha = 0;
  }
  if (frontAlpha > 0)
  {
    frontAlpha -= bounceReactDecay;
  } else {
    frontAlpha = 0;
  }
  if (topAlpha > 0)
  {
    topAlpha -= bounceReactDecay;
  } else {
    topAlpha = 0;
  }
  if (bottomAlpha > 0)
  {
    bottomAlpha -=bounceReactDecay;
  } else {
    bottomAlpha = 0;
  }


  if (beforeBeans) {

    if (bounceReact && !paintMode)
    {
      noStroke();
      fill(backAlpha);
      beginShape();
      vertex(G.X, G.Y);
      vertex(H.X, H.Y);
      vertex(E.X, E.Y);
      vertex(F.X, F.Y);
      endShape(CLOSE);

      fill(rightAlpha);
      beginShape();
      vertex(G.X, G.Y);
      vertex(B.X, B.Y);
      vertex(C.X, C.Y);
      vertex(H.X, H.Y);
      endShape(CLOSE);

      fill(bottomAlpha);
      beginShape();
      vertex(H.X, H.Y);
      vertex(C.X, C.Y);
      vertex(D.X, D.Y);
      vertex(E.X, E.Y);
      endShape(CLOSE);
    }
    noFill();
    strokeWeight(5);
    stroke(50);
    line(G.X, G.Y, H.X, H.Y);
    line(H.X, H.Y, E.X, E.Y);
    line(H.X, H.Y, C.X, C.Y);
  }

  if (!beforeBeans)
  {

    if (bounceReact && !paintMode)
    {
      noStroke();
      fill(255, 255, 255, frontAlpha);
      beginShape();
      vertex(A.X, A.Y);
      vertex(B.X, B.Y);
      vertex(C.X, C.Y);
      vertex(D.X, D.Y);
      endShape(CLOSE);

      fill(255, 255, 255, leftAlpha);
      beginShape();
      vertex(A.X, A.Y);
      vertex(D.X, D.Y);
      vertex(E.X, E.Y);
      vertex(F.X, F.Y);
      endShape(CLOSE);

      fill(255, 255, 255, topAlpha);
      beginShape();
      vertex(A.X, A.Y);
      vertex(B.X, B.Y);
      vertex(G.X, G.Y);
      vertex(F.X, F.Y);
      endShape(CLOSE);
    }

    strokeWeight(5);
    stroke(255);
    line(A.X, A.Y, B.X, B.Y);
    line(B.X, B.Y, C.X, C.Y);
    line(C.X, C.Y, D.X, D.Y);
    line(D.X, D.Y, E.X, E.Y);
    line(E.X, E.Y, F.X, F.Y);
    line(F.X, F.Y, A.X, A.Y);
    line(A.X, A.Y, D.X, D.Y);
    line(F.X, F.Y, G.X, G.Y);
    line(B.X, B.Y, G.X, G.Y);
  }
}

void keyPressed()
{
  if (key == 'n') {
    //beans.add(new Bean(IDcounter, mouseX, mouseY, 600.0,  mouseX-prevXmouse, mouseY-prevYmouse, random(-100,100)));
    beans.add(new Bean(IDcounter, xlength/2, ylength/2, zlength/2, random(-50, 50), random(-50, 50), random(-50, 50)));
    IDcounter += 1;
  }
  if (key == 'p') {
    paintMode = !paintMode;
  }
  if (key == 'j') {
    isJumping = !isJumping;
  }
  if (key == 'b') {
    bounceReact = !bounceReact;
  }
  if (key == 'c') {
    drawCube = !drawCube;
  }
  
  if (key == '1') {
    leftSideAngle -= 0.5 * degToRadian;
    recalculateCube();
  }
  if (key == '7') {
    leftSideAngle += 0.5 * degToRadian;
    recalculateCube();
  }
  if (key == '2') {
    sideLengthRatio -= 0.01;
    recalculateCube();
  }
  if (key == '8') {
    sideLengthRatio += 0.01;
    recalculateCube();
  }
  if (key == '3') {
    rightSideAngle -= 0.5 * degToRadian;
    recalculateCube();
  }
  if (key == '9') {
    rightSideAngle += 0.5 * degToRadian;
    recalculateCube();
  }

}
