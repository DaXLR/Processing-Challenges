int screenW = 800;
int screenH = 600;
float halfScreenW, halfScreenH;
float projectionPlane = 20;
int floorLevel = -5000;
int fogDistance = 10000;

float[] skyFog = {255, 255, 255};
float[] groundFog = {255, 255, 255};

int zBufferDepth = 10;

int[][] zBuffer = new int[fogDistance][zBufferDepth];

class SSPoint {
    float x, y, scale;
    SSPoint(float x, float y, float scale) {
        this.x = x;
        this.y = y;
        this.scale = scale;
    }
}

void initScreen()
{

//Initializing the zBuffer with -1
for (int i = 0; i < fogDistance; i++) {
    for (int j = 0; j < zBufferDepth; j++) {
        zBuffer[i][j] = -1;
    }
}

screenW = width;
screenH = height;
halfScreenW = screenW / 2;
halfScreenH = screenH / 2;

}

void placeInZBuffer(int id, float z)
{
    int zIndex = int(z);

    for (int i = 0; i < zBufferDepth; i++) {
        if (zBuffer[zIndex][i] == -1) {
            zBuffer[zIndex][i] = id;
            return;
        }
    }
}

SSPoint getScaledPosition(float x, float y, float z)
{
    float scale = projectionPlane / z;
    float screenX = halfScreenW + (x * scale);
    float screenY = halfScreenH - (y * scale);
    return new SSPoint(screenX, screenY, scale);
}




