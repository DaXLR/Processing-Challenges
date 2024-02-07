
void createCube(float size, float x, float y, float z) {

  float halfSize = size/2;

  coord a = new coord(-halfSize, -halfSize, halfSize);
  coord b = new coord(halfSize, -halfSize, halfSize);
  coord c = new coord(halfSize, -halfSize, -halfSize);
  coord d = new coord(-halfSize, -halfSize, -halfSize);
  coord e = new coord(-halfSize, halfSize, halfSize);
  coord f = new coord(halfSize, halfSize, halfSize);
  coord g = new coord(halfSize, halfSize, -halfSize);
  coord h = new coord(-halfSize, halfSize, -halfSize);

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

  addObject(cube);
}

void createDrop(float size, float x, float y, float z)
{
  coord a = new coord(0*size, 0*size, 0*size);
  coord b = new coord(-1*size, -1*size, 2*size);
  coord c = new coord(-1*size, 1*size, 2*size);
  coord d = new coord(1*size, 1*size, 2*size);
  coord e = new coord(1*size, -1*size, 2*size);
  coord f = new coord(0*size, 0*size, 7*size);

  poly fa = new poly(a, b, e);
  poly fb = new poly(a, b, c);
  poly fc = new poly(a, e, d);
  poly fd = new poly(a, c, d);
  poly fe = new poly(f, b, e);
  poly ff = new poly(f, e, d);
  poly fg = new poly(f, d, c);
  poly fh = new poly(f, c, b);

  fa.setStrokeColor(0, 0, 0, 0);
  fa.setSolidColor(100, 100, 255, 100);
  fb.setStrokeColor(0, 0, 0, 0);
  fb.setSolidColor(100, 100, 255, 100);
  fc.setStrokeColor(0, 0, 0, 0);
  fc.setSolidColor(100, 100, 255, 100);
  fd.setStrokeColor(0, 0, 0, 0);
  fd.setSolidColor(100, 100, 255, 100);
  fe.setStrokeColor(0, 0, 0, 0);
  fe.setSolidColor(100, 100, 255, 100);
  ff.setStrokeColor(0, 0, 0, 0);
  ff.setSolidColor(100, 100, 255, 100);
  fg.setStrokeColor(0, 0, 0, 0);
  fg.setSolidColor(100, 100, 255, 100);
  fh.setStrokeColor(0, 0, 0, 0);
  fh.setSolidColor(100, 100, 255, 100);

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

  addObject(drop);
}
