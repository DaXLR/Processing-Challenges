//TODO Bouger les fonctions de calcul de points hors de la classe camera
//ajouter des variables pour modifier les parametres de la sim
//ajouter la fonction de son pour les objets
//Ajouter lag compensation
//Ajouter calcul de vecteur pour le mouvement de la camera selon langle




//Variables pour la grosseur de l'ecran
int screenSizeX = 1200;
int screenSizeY = 800;

camera cam = new camera(screenSizeX, screenSizeY, screenSizeY);
coord mousePosition = new coord(0, 0, 0);


boolean movingForward = false;
boolean movingBack = false;
boolean movingLeft = false;
boolean movingRight = false;
boolean tiltRight = false;
boolean tiltLeft = false;
boolean tiltUp = false;
boolean tiltDown = false;

float speed = 10;
float tiltSpeed = 0.05;

float gravity = 50;


void settings() {
  size(screenSizeX, screenSizeY);
}

void setup() {
  background(0, 0, 0);
  cam.setPosition(0, 0, 200, 45*toRadian, 0);
}

void draw() {

  background(0, 0, 0);
  int intensity = 100;
  for (int i = 0; i < intensity; i++) {
    createDrop(random(0.5, 5), random(-10000, 10000)+cam.position.x, random(-10000, 10000)+cam.position.y, cam.position.z + 1000);
  }
  update();
  render();
  move();

  for (int i = 0; i<objects.size(); i++) {
    object o = objects.get(i);
    if (o.type == "DROP") {
      o.move(0, 0, -gravity);
      if (o.position.z < -100)
      {
        if (cam.getDistance(o.position, cam.position, true) < 3000) {
          createCube(random(25,100), o.position.x, o.position.y, o.position.z - 100);
        }
        objects.remove(i);
      }
    }
    if (o.type == "CUBE") {
      for (int j = 0; j < o.polygons.size(); j ++) {
        poly p = o.polygons.get(j);
        p.setStrokeColor(255, 255, 255, p.strokeColor.a - 10);
        if (p.strokeColor.a <= 0)
        {
          objects.remove(i);
        }
      }
    }
  }
}
