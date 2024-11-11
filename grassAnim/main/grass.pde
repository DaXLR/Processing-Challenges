class point {
float xi;
float yi;
  float x;
  float y;

  point(float xin, float yin) {
    xi = xin;
    yi = yin;
    x = xi;
    y = yi;
  }
}

class segment {

  point a;
  point b;
  float segmentLength;

  segment(point ain, point bin) {
    a = ain;
    b = bin;
    segmentLength = dist(a.x,a.y,b.x,b.y);
  }
}



class springLine {

  point position = new point(0, 0);
  ArrayList<point> points = new ArrayList<point>();
  ArrayList<segment> segments = new ArrayList<segment>();

  int segmentsQty = 10;
  float deflection = 0;
  float neutralPull = 0.01;
  float totalLength = 400;
  float curveRatio = 0.8;
  float lineWidth = 4;

  springLine(float xin, float yin, int segmentsin) {
    position.x = xin;
    position.y = yin;
    segmentsQty = segmentsin;

    for (int i=0; i <= segmentsQty; i++) {
      float segmentLength = totalLength / segmentsQty;
      points.add(new point(0, -segmentLength*i));
    }
    for (int i = 0; i < segmentsQty; i++) {
      segments.add(new segment(points.get(i), points.get(i+1)));
    }
  }
  
  void setDeflection(float d){
   deflection = d; 
  }

  void drawLine() {

    updateLine();
    
    stroke(255);
    for (int i = 0; i < segmentsQty; i ++) {
      segment s = segments.get(i);
      strokeWeight((segmentsQty+1-i)*lineWidth);
      line(s.a.x+position.x, s.a.y+position.y, s.b.x+position.x, s.b.y+position.y);
    }
  }
  
  
  void updateLine(){
    float yoffset = 0;
    for(int i = 0; i <= segmentsQty; i++){
     float offset = deflection*(pow(curveRatio,segmentsQty-i));
     float seglen = totalLength/segmentsQty;
     yoffset += (abs(offset)/seglen) * (0.1 * seglen);
     points.get(i).x = points.get(i).xi + offset;
     points.get(i).y = points.get(i).yi + yoffset;
    }
  }
  
}
