class coord {

  public float x, y, z;

  coord(float a, float b, float c) {
    x = a;
    y = b;
    z = c;
  }
}

class poly {

  int sides = 3;
  //Les polygones peuvent avoir 3 ou 4 cotés dependament du nombre de coordonées passées dans le constructeur
  //Si utilisées par un solide, les coordonées passé dans un poly devraient être relatives à l'origine du solide et en worldspace
  ArrayList<coord> points = new ArrayList<coord>();
  
  
  public boolean hasCollision = false;
  public boolean isVisible = true;


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
}

class solid {
  
  ArrayList<poly> polygons = new ArrayList<poly>();
  coord position = new coord(0,0,0);
  
  
  void setPosition(float x, float y, float z){
  position.x = x;
  position.y = y;
  position.z = z;
  }
  
  void move(float x, float y, float z){
   position.x += x;
   position.y += y;
   position.z += z;
  }
  
  //Met à jour la position des polygones contenu dans la shape
  //Les poly qui forment la shape ont des coordonées 'locales' (par rapport à l'origine de la shape)
  //Cette fonction les place dans le worldspace selon la position de l'origine du solide 
  void updatePolygons(){
    
    for(int i = 0; i < polygons.size(); i ++)
    {
      poly p = polygons.get(i);
       for (int j = 0; j < p.sides; j++)
       {
         coord c = p.points.get(j);
         c.x += position.x;
         c.y += position.y;
         c.z += position.z;
       }
    }
  }
  
  void addPoly(poly p){
   polygons.add(p); 
  }
  
  void setVisible(boolean set)
  {
    for(int i = 0; i < polygons.size(); i ++)
    {
      poly p = polygons.get(i);
      p.isVisible = set;
    }
  }

}
