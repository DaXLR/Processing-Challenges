ArrayList<object> objects = new ArrayList<object>();


//Met a jour tous les polygones et pré-calcule les angles relatif de chaque point relatif à la camera
void update() {

  for (int i = 0; i < objects.size(); i ++) {

    object o = objects.get(i);
    o.updatePolygons(true);
  }
}

void render() {

  for (int i = 0; i < objects.size(); i ++) {

    object o = objects.get(i);
    if (o.toRender) {
      o.renderPolygons();
    }
  }
}

//Ajoute un objet a la liste et retourne la position dans la liste
int addObject(object obj) {

  objects.add(obj);

  return objects.size()-1;
}
