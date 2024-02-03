//Variables pour la grosseur de l'ecran
int screenSizeX = 1200;
int screenSizeY = 1200;

camera cam = new camera(600,400,500);
coord mousePosition = new coord(0,0,0);

void settings() {
  size(screenSizeX, screenSizeY);
}

void setup() {
  background(0, 0, 0);
  cam.setPosition(600,600,100);
   fill(255);
 noStroke();
 ellipse(cam.position.x, cam.position.y, 10,10);
}

void draw(){

  mousePosition.x = mouseX;
  mousePosition.y = mouseY;
  mousePosition.z = 0;
  
  cam.pointToScreenSpace(mousePosition);
  
}
