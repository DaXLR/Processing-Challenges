float[][] vertices = {
  { 1.0, 0.0, -1.0 },
  { 0.0, 0.0, -1.0 },
  { 0.0, 1.0, -1.0 },
  { 1.0, 1.0, -1.0 },
  { 1.0, 0.0, 0.0 },
  { 1.0, 1.0, 0.0 },
  { 0.0, 0.0, 0.0 },
  { 0.0, 1.0, 0.0 },
};

void traceObject(float xoffset, float yoffset, float zoffset, float size) {
    for (int i = 0; i < vertices.length - 1; i++) {
        float[] startVertex = vertices[i];
        float[] endVertex = vertices[i + 1];
        float x1 = (startVertex[0] * size) + xoffset;
        float y1 = (startVertex[1] * size) + yoffset;
        float z1 = (startVertex[2] * size/20) + zoffset;
        float x2 = (endVertex[0] * size) + xoffset;
        float y2 = (endVertex[1] * size) + yoffset;
        float z2 = (endVertex[2] * size/20) + zoffset;
        spawnShapeParticles(x1, y1, z1, x2, y2, z2, 0.002, 0, 0, 0);
    }
}
