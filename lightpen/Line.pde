class Line {
  float x1, y1, x2, y2;
  float x1Offset, y1Offset, x2Offset, y2Offset;
  float r = 255;
  float g = 255;
  float b = 255;
  float fade = 1.0;
  float thickness;
  float endPointSize = 5;

  Line(float x1, float y1, float x2, float y2, float thickness) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.thickness = thickness;
  }

  void setColor(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  void setFade(float fade) {
    this.fade = fade;
  }

  void render() {
    stroke(r*fade, g*fade, b*fade);
    strokeWeight(thickness);
    line(x1 + x1Offset,
      y1 + y1Offset,
      x2 + x2Offset,
      y2 + y2Offset);
    fill(r*fade, g*fade, b*fade);
    ellipse(x1 + x1Offset, y1 + y1Offset, endPointSize, endPointSize);
    ellipse(x2 + x2Offset, y2 + y2Offset, endPointSize, endPointSize);
  }

  void offsetPoint(float x, float y, int id) {
    if (id == 1) {
      x1Offset = x;
      y1Offset = y;
    } else if (id == 2) {
      x2Offset = x;
      y2Offset = y;
    }
  }
}
