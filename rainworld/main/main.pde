//TODO Bouger les fonctions de calcul de points hors de la classe camera
//ajouter des variables pour modifier les parametres de la sim
//ajouter la fonction de son pour les objets
//Ajouter lag compensation
//Ajouter calcul de vecteur pour le mouvement de la camera selon langle

import processing.sound.*;
SoundFile rain;

float gravity = 100;
int gradientResolution = 10;
int rainIntensity = 50;
int rainDropFade = 6000;
int rainDropSpawnHeight = 1500;
int puddleFade = 4000;


void settings() {
  fullScreen();
  screenSizeX = displayWidth;
  screenSizeY = displayHeight;
}

void setup() {
  rain = new SoundFile(this, "rain.wav");
  rain.loop();


  background(0, 0, 0);
  object o = objects.get(createCube(1000, 5000, 20000, 20000, 4800));
  for (int j = 0; j < o.polygons.size(); j ++) {
    poly p = o.polygons.get(j);
    p.setSolidColor(0, 0, 0, 255);
    p.setStrokeColor(0,0,0,0);
  }

  cam.setPosition(0, 0, 200, 45*toRadian, 0);
}

void draw() {

  drawBackground();
  update();
  render();
  move();
}

void drawBackground()
{
  float horizon = 0.43*screenSizeY+(0.9*cam.pitch*screenSizeY);
  color skyTop = color(0, 0, 0);
  color skyHorizon = color(100, 100, 100);
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
  line(0, screenSizeY, screenSizeX, screenSizeY);
}
