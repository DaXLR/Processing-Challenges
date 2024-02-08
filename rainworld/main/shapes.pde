//Fonctions pour la création de formes et d'objets pré-définis

int createPuddle(float size, float x, float y, float z) {
  coord a = new coord(-1*size, -1*size, 0*size);
  coord b = new coord(-1*size, 1*size, 0*size);
  coord c = new coord(1*size, 1*size, 0*size);
  coord d = new coord(1*size, -1*size, 0*size);
  coord e = new coord(0*size, 0*size, -1*size);

  poly fa = new poly(a, b, e);
  poly fb = new poly(b, c, e);
  poly fc = new poly(c, d, e);
  poly fd = new poly(d, a, e);

  object puddle = new object();

  puddle.addPoly(fa);
  puddle.addPoly(fb);
  puddle.addPoly(fc);
  puddle.addPoly(fd);
  
  puddle.setPosition(x,y,z);
  
  puddle.type = "PUDDLE";
  
  return addObject(puddle);
}


int createCube(float size, float tall, float x, float y, float z) {

  coord a = new coord(-1*size, -1*size, 1*tall);
  coord b = new coord(1*size, -1*size, 1*tall);
  coord c = new coord(1*size, -1*size, -1*tall);
  coord d = new coord(-1*size, -1*size, -1*tall);
  coord e = new coord(-1*size, 1*size, 1*tall);
  coord f = new coord(1*size, 1*size, 1*tall);
  coord g = new coord(1*size, 1*size, -1*tall);
  coord h = new coord(-1*size, 1*size, -1*tall);

  poly fa = new poly(a, b, c, d);
  poly fb = new poly(a, e, h, d);
  poly fc = new poly(b, f, g, c);
  poly fd = new poly(e, f, g, h);
  poly fe = new poly(e, f, b, a);
  poly ff = new poly(g, c, d, h);

  object cube = new object();

  cube.addPoly(fa);
  cube.addPoly(fb);
  cube.addPoly(fc);
  cube.addPoly(fd);
  cube.addPoly(fe);
  cube.addPoly(ff);

  cube.setPosition(x, y, z);

  cube.type = "CUBE";

  return addObject(cube);
}

int createDrop(float size, float x, float y, float z)
{
  coord a = new coord(0*size, 0*size, 0*size);
  coord b = new coord(-1*size, -1*size, 2*size);
  coord c = new coord(-1*size, 1*size, 2*size);
  coord d = new coord(1*size, 1*size, 2*size);
  coord e = new coord(1*size, -1*size, 2*size);
  coord f = new coord(0*size, 0*size, 12*size);

  poly fa = new poly(a, b, e);
  poly fb = new poly(a, b, c);
  poly fc = new poly(a, e, d);
  poly fd = new poly(a, c, d);
  poly fe = new poly(f, b, e);
  poly ff = new poly(f, e, d);
  poly fg = new poly(f, d, c);
  poly fh = new poly(f, c, b);

  fa.setStrokeColor(0, 0, 0, 0);
  fa.setSolidColor(0, 255, 255, 0);
  fb.setStrokeColor(0, 0, 0, 0);
  fb.setSolidColor(0, 255, 255, 0);
  fc.setStrokeColor(0, 0, 0, 0);
  fc.setSolidColor(0, 255, 255, 0);
  fd.setStrokeColor(0, 0, 0, 0);
  fd.setSolidColor(0, 255, 255, 0);
  fe.setStrokeColor(0, 0, 0, 0);
  fe.setSolidColor(0, 255, 255, 0);
  ff.setStrokeColor(0, 0, 0, 0);
  ff.setSolidColor(0, 255, 255, 0);
  fg.setStrokeColor(0, 0, 0, 0);
  fg.setSolidColor(0, 255, 255, 0);
  fh.setStrokeColor(0, 0, 0, 0);
  fh.setSolidColor(0, 255, 255, 0);

  object drop = new object();

  drop.addPoly(fa);
  drop.addPoly(fb);
  drop.addPoly(fc);
  drop.addPoly(fd);
  drop.addPoly(fe);
  drop.addPoly(ff);
  drop.addPoly(fg);
  drop.addPoly(fh);

  drop.setPosition(x, y, z);

  drop.type = "DROP";

  return addObject(drop);
}
