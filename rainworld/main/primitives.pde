class RGBAColor {

  RGBAColor()
  {
  }

  RGBAColor(int red, int green, int blue, int alpha)
  {
    r = red;
    g = green;
    b = blue;
    a = alpha;
  }

  int r = 0;
  int g = 0;
  int b = 0;
  int a = 0;
}

class coord {

  public float x, y, z;
  public float original_x, original_y, original_z;

  //L'angle relatif du point par rapport à la caméra. Utilisé pour les calculs de positionnement ainsi que la projection en screenspace
  public float relative_yaw;
  public float relative_pitch;
  public float distanceToCamera;

  coord(float a, float b, float c) {
    original_x = a;
    original_y = b;
    original_z = c;
  }
}

class poly {

  int sides = 3;
  //Les polygones peuvent avoir 3 ou 4 cotés dependament du nombre de coordonées passées dans le constructeur
  //Si utilisées par un solide, les coordonées passé dans un poly devraient être relatives à l'origine du solide et NON en worldspace
  ArrayList<coord> points = new ArrayList<coord>();


  public boolean hasCollision = false;
  public boolean isVisible = true;
  RGBAColor solidColor = new RGBAColor(0, 0, 0, 0);
  RGBAColor strokeColor = new RGBAColor(255, 255, 255, 255);

  poly(coord a, coord b, coord c)
  {
    sides = 3;
    points.add(a);
    points.add(b);
    points.add(c);
  }

  poly(coord a, coord b, coord c, coord d)
  {
    sides = 4;
    points.add(a);
    points.add(b);
    points.add(c);
    points.add(d);
  }

  void setSolidColor(int red, int green, int blue, int alpha)
  {
    solidColor.r = red;
    solidColor.g = green;
    solidColor.b = blue;
    solidColor.a = alpha;
  }

  void setStrokeColor(int red, int green, int blue, int alpha)
  {
    strokeColor.r = red;
    strokeColor.g = green;
    strokeColor.b = blue;
    strokeColor.a = alpha;
  }

  void drawPolygon() {

    for (int i = 0; i< points.size(); i++)
    {
      coord pt = points.get(i);
      if (pt.relative_yaw > (PI/2)||pt.relative_yaw < (-PI/2))
      {
        return;
      }
    }

    if (strokeColor.a == 0)
    {
      noStroke();
    } else {
      stroke(strokeColor.r, strokeColor.g, strokeColor.b, strokeColor.a);
    }

    if (solidColor.a == 0) {
      noFill();
    } else {
      fill(solidColor.r, solidColor.g, solidColor.b, solidColor.a);
    }

    strokeWeight(cam.focalLength / points.get(0).distanceToCamera);
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      coord p = cam.pointToScreenSpace(points.get(i).relative_yaw, points.get(i).relative_pitch);
      vertex(((cam.camWidth/2)+p.x), ((cam.camHeight/2)+p.y));
    }
    endShape(CLOSE);
  }
}

class object {

  String type = "NONE";

  ArrayList<poly> polygons = new ArrayList<poly>();
  coord position = new coord(0, 0, 0);
  float relative_yaw;
  float relative_pitch;
  float distanceToCamera;

  boolean toRender = true;
  boolean active = true;

  void setPosition(float x, float y, float z) {
    position.x = x;
    position.y = y;
    position.z = z;
  }

  void move(float x, float y, float z) {
    position.x += x;
    position.y += y;
    position.z += z;
  }

  //Met à jour la position des polygones contenu dans la shape
  //Les poly qui forment la shape ont des coordonées 'locales' (par rapport à l'origine de la shape)
  //Cette fonction les place dans le worldspace selon la position de l'origine du solide
  void updatePolygons(boolean calculateRelativeAngles) {

    for (int i = 0; i < polygons.size(); i ++)
    {
      relative_yaw = cam.getRelativeYaw(position,cam.position,cam.yaw);
      relative_pitch = cam.getRelativePitch(position, cam.position, cam.pitch);
      distanceToCamera = cam.getDistance(position, cam.position, false);
      
      poly p = polygons.get(i);
      for (int j = 0; j < p.sides; j++)
      {
        coord c = p.points.get(j);
        c.x = c.original_x + position.x;
        c.y = c.original_y + position.y;
        c.z = c.original_z + position.z;
        c.distanceToCamera = cam.getDistance(c, cam.position, false);

        if (calculateRelativeAngles)
        {
          c.relative_yaw = cam.getRelativeYaw(c, cam.position, cam.yaw);
          c.relative_pitch = cam.getRelativePitch(c, cam.position, cam.pitch);
        }
      }
    }
  }

  void addPoly(poly p) {
    polygons.add(p);
  }

  void setVisible(boolean set)
  {
    for (int i = 0; i < polygons.size(); i ++)
    {
      poly p = polygons.get(i);
      p.isVisible = set;
    }
  }

  void renderPolygons() {

    for (int i = 0; i < polygons.size(); i ++)
    {
      poly p = polygons.get(i);
      p.drawPolygon();
    }
  }
  
}
