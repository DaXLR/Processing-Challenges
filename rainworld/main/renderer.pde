static float toRadian = 0.0174533;
static float toDegrees = 57.2957795;

ArrayList<object> objects = new ArrayList<object>();

//Fonction principale pour l'update des interactions dans la scène
void update() {

  //Met a jour tous les polygones et pré-calcule les angles relatif de chaque point relatif à la camera
  for (int i = 0; i < objects.size(); i ++) {

    object o = objects.get(i);
    o.updatePolygons(true);
  }
  
  //Création des gouttes
    for (int i = 0; i < rainIntensity; i++) {
    createDrop(random(2, 8), random(-rainDropFade, rainDropFade)+cam.position.x, random(-rainDropFade, rainDropFade)+cam.position.y, cam.position.z + rainDropSpawnHeight);
  }
  
  //Séquence logique pour la disparition des gouttes et le fade out des pyramides
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
        if (getDistance(o.position, cam.position, true) < puddleFade) {
          createPuddle(random(10, 100), o.position.x, o.position.y, o.position.z - 100);
        }
        objects.remove(i);
      }
    }
    if (o.type == "PUDDLE") {
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

//Déclenche le rendu des polygones
void render() {

  for (int i = 0; i < objects.size(); i ++) {

    object o = objects.get(i);
    if (o.toRender) {
      o.renderPolygons();
    }
  }
}

//Ajoute un objet a la liste des objets actifs
int addObject(object obj) {

  objects.add(obj);

  return objects.size()-1;
}
