
solid createCube(float size, float x, float y, float z) {

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

  solid cube = new solid();

  cube.addPoly(fa);
  cube.addPoly(fb);
  cube.addPoly(fc);
  cube.addPoly(fd);
  cube.addPoly(fe);
  cube.addPoly(ff);

  cube.setPosition(x, y, z);

  return cube;
}

solid createRaindrop(float size) {
  solid raindrop = new solid();
  return raindrop;
}
