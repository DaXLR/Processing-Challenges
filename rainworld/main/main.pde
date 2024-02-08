//TODO Bouger les fonctions de calcul de points hors de la classe camera
//ajouter des variables pour modifier les parametres de la sim
//ajouter la fonction de son pour les objets
//Ajouter lag compensation
//Ajouter calcul de vecteur pour le mouvement de la camera selon langle

import processing.sound.*;
SoundFile rain;

//Variables pour la grosseur de l'ecran
int screenSizeX = 1800;
int screenSizeY = 1300;

camera cam = new camera(screenSizeX, screenSizeY, screenSizeY);

float gravity = 100;
int gradientResolution = 10;
int rainIntensity = 50;
int rainDropFade = 5000;
int rainDropSpawnHeight = 1500;
int puddleFade = 3000;


//Variables de mouvement
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

void settings() {
  size(screenSizeX, screenSizeY);
}

void setup() {
  rain = new SoundFile(this, "rain.wav");
  rain.loop();
  background(0, 0, 0);
  cam.setPosition(0, 0, 200, 45*toRadian, 0);
}

void draw() {

  drawBackground();

  for (int i = 0; i < rainIntensity; i++) {
    createDrop(random(2, 8), random(-rainDropFade, rainDropFade)+cam.position.x, random(-rainDropFade, rainDropFade)+cam.position.y, cam.position.z + rainDropSpawnHeight);
  }
  
  update();
  render();
  move();

  for (int i = 0; i<objects.size(); i++) {
    object o = objects.get(i);
    if (o.type == "DROP") {
      o.move(0, 0, -gravity);
      for (int j = 0; j < o.polygons.size(); j ++) {
        poly p = o.polygons.get(j);
        float ratio = 1 - (o.distanceToCamera/rainDropFade);
        p.setSolidColor(p.solidColor.r, p.solidColor.g, p.solidColor.b, (int)(255*ratio));
      }
      if (o.position.z < -100)
      {
        if (cam.getDistance(o.position, cam.position, true) < puddleFade) {
          createCube(random(25, 100), o.position.x, o.position.y, o.position.z - 100);
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

void drawBackground()
{
  float horizon = 0.52*screenSizeY;
  color skyTop = color(255, 255, 255);
  color skyHorizon = color(255, 155, 20);
  color floorHorizon = color(100, 100, 100);
  color floorBottom = color(0, 0, 0);

  strokeWeight(gradientResolution);
  for (int i = 0; i < horizon; i+=(gradientResolution-1)) {
    stroke(lerpColor(skyTop, skyHorizon, (i/horizon)));
    line(0, i, screenSizeX, i);
  }
  for (int i = (int)horizon; i < screenSizeY; i+=(gradientResolution-1)) {
    stroke(lerpColor(floorHorizon, floorBottom, ((i-horizon)/(screenSizeY-horizon))));
    line(0, i, screenSizeX, i);
  }
}
