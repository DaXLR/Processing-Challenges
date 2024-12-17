String[] objectFiles = {"1.csv", "2.csv", "3.csv", "4.csv","6.csv", "7.csv", "8.csv", "9.csv", "10.csv", "11.csv", "12.csv", "13.csv", "14.csv"};
ShapeObject[] shapeObjects = new ShapeObject[objectFiles.length];

class ShapeObject
{
  ArrayList<PVector> vertices = new ArrayList<PVector>();

  void addVertex(float x, float y, float z) {
    PVector vertex = new PVector(x, y, z);
    vertices.add(vertex);
  }
}

void traceObject(ShapeObject shape, float xoffset, float yoffset, float zoffset, float size) {
    for (int i = 0; i < shape.vertices.size() - 1; i++) {
        PVector startVertex = shape.vertices.get(i);
        PVector endVertex = shape.vertices.get(i + 1);
        float x1 = (startVertex.x * size) + xoffset;
        float y1 = (startVertex.y * size) + yoffset;
        float z1 = (startVertex.z * size/50) + zoffset;
        float x2 = (endVertex.x * size) + xoffset;
        float y2 = (endVertex.y * size) + yoffset;
        float z2 = (endVertex.z * size/50) + zoffset;
        int randomColor = int(random(0,255));
        if (y1 < floorLevel){
          y1 = floorLevel;
        }
        if (y2 < floorLevel){
          y2 = floorLevel;
        }
        spawnShapeParticles(x1, y1, z1, x2, y2, z2, 0.0005, randomColor, randomColor, randomColor);
    }
}


void loadObjectsFromCSV() {
    for (int i = 0; i < objectFiles.length; i++) {
        String[] lines = loadStrings(objectFiles[i]);
        ShapeObject shapeObject = new ShapeObject();
        for (int j = 0; j < lines.length; j++) {
            String[] parts = split(lines[j], ',');
            float x = float(parts[0]);
            float y = float(parts[1]);
            float z = float(parts[2]);
            shapeObject.addVertex(x, y, z);
        }
        shapeObjects[i] = shapeObject;
    }
}
