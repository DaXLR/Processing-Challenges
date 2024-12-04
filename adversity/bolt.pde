//Array for storing bolts
final int maxBolts = 100;
Bolt[] bolts = new Bolt[maxBolts];

class Bolt
{
float speed = 10000; //How far it will travel each jump
float chaos = 0.1; //How much it will deviate from it's current path each jump
float fracture = 0.1; //How likely it is to fracture each jump
int lifetime = 10; //How many jumps it will make
float density = 0.004; //How many particles it will leave behind 1 = every position, 0 = none

float x, y, z;
float initialVX, initialVY, initialVZ;
float vx, vy, vz; //Initial direction speeds, should be between -1 and 1
int red, green, blue;

int id;

    void destroy() {
        bolts[id] = null;
    }


    void update(){

        //Calculate jump
        float jumpDistance = randomGaussian() * speed;
        float newX = x + vx * jumpDistance;
        float newY = y + vy * jumpDistance;
        float newZ = z + vz * jumpDistance;

        if (newY < floorLevel) {
            newY = floorLevel;
            vy = 0;
        }

        //Calculate new direction TODO implement chaos
        vx = random(-initialVX, initialVX);
        vy = random(-initialVY, initialVY);
        vz = random(-initialVZ, initialVZ);

        //Spawn particles
        spawnParticlesAlongLine(x, y, z, newX, newY, newZ, density, red, green, blue);

        //Update position
        x = newX;
        y = newY;
        z = newZ;
        lifetime--;

        if (lifetime <= 0) {
            traceObject(x, y, z, random(5000,20000));
            destroy();
            return;
        }
    }


}

void updateBolts()
{
    for (int i = 0; i < maxBolts; i++)
    {
        if (bolts[i] != null)
        {
            bolts[i].update();
        }
    }
}

int createBolt(float x, float y, float z, float vx, float vy, float vz, int lifetime)
{
    for (int i = 0; i < maxBolts; i++)
    {
        if (bolts[i] == null)
        {
            Bolt b = new Bolt();
            b.x = x;
            b.y = y;
            b.z = z;
            b.initialVX = vx;
            b.initialVY = vy;
            b.initialVZ = vz;
            b.vx = vx;
            b.vy = vy;
            b.vz = vz;
            b.lifetime = lifetime;
            b.red = 255;
            b.green = 100;
            b.blue = 0;
            b.id = i;
            bolts[i] = b;
            return i;
        }
    }
    return -1;
}

void spawnParticlesAlongLine(float x1, float y1, float z1, float x2, float y2, float z2, float density, float red, float green, float blue)
{
    float distance = dist(x1, y1, z1, x2, y2, z2);
    int particleSpawns = int(distance * density);

    //Calculating points along line
    PVector[] points = new PVector[particleSpawns];
    for (int i = 0; i < particleSpawns; i++) {
        float t = float(i) / (particleSpawns - 1);
        float px = lerp(x1, x2, t);
        float py = lerp(y1, y2, t);
        float pz = lerp(z1, z2, t);
        points[i] = new PVector(px, py, pz);
    }

    for (int i = 0; i < particleSpawns - 1; i++) {
            
        //Creating the long term particle
        InitVector initVector = new InitVector();
        initVector.x = points[i].x;
        initVector.y = points[i].y;
        initVector.z = points[i].z;
        initVector.vx = randomGaussian() * 20;
        initVector.vy = randomGaussian() * 20;
        initVector.vz = randomGaussian() * 0.2;
        initVector.drag = random(10, 20);
        initVector.gravity = random(0, 100);
        int index = createParticle(initVector, random(500, 3000));
        if (index != -1) {
            Particle p = particles[index];
            p.size = random(100,1000);
            p.flicker = random(1, 10);
            p.red = red;
            p.green = green;
            p.blue = blue;
        }
        //Creating the short term particle
        initVector.x = points[i].x;
        initVector.y = points[i].y;
        initVector.z = points[i].z;
        initVector.vx = randomGaussian() * 5;
        initVector.vy = randomGaussian() * 5;
        initVector.vz = randomGaussian() * 0.02;
        initVector.drag = random(10, 20);
        initVector.gravity = random(0, 100);
        index = createParticle(initVector, random(10, 100));
        if (index != -1) {
            Particle p = particles[index];
            p.size = random(1000,3000);
            p.flicker = random(100, 500);
            p.red = 255 - skyFog[0];
            p.green = 255 - skyFog[1];
            p.blue = 255 - skyFog[2];
        }
    }
}

void spawnShapeParticles(float x1, float y1, float z1, float x2, float y2, float z2, float density, float red, float green, float blue)
{
    float distance = dist(x1, y1, z1, x2, y2, z2);
    int particleSpawns = int(distance * density);

    //Calculating points along line
    PVector[] points = new PVector[particleSpawns];
    for (int i = 0; i < particleSpawns; i++) {
        float t = float(i) / (particleSpawns - 1);
        float px = lerp(x1, x2, t);
        float py = lerp(y1, y2, t);
        float pz = lerp(z1, z2, t);
        points[i] = new PVector(px, py, pz);
    }

    for (int i = 0; i < particleSpawns - 1; i++) {
            
        //Creating the long term particle
        InitVector initVector = new InitVector();
        initVector.x = points[i].x;
        initVector.y = points[i].y;
        initVector.z = points[i].z;
        initVector.vx = randomGaussian() * 20;
        initVector.vy = randomGaussian() * 20;
        initVector.vz = randomGaussian() * 0.2;
        initVector.drag = random(0, 100);
        initVector.gravity = random(0, 20);
        int index = createParticle(initVector, random(1000, 5000));
        if (index != -1) {
            Particle p = particles[index];
            p.size = random(300,5000);
            p.flicker = random(0, 2);
            p.red = red;
            p.green = green;
            p.blue = blue;
        }
        /* //Creating the short term particle
        initVector.x = points[i].x;
        initVector.y = points[i].y;
        initVector.z = points[i].z;
        initVector.vx = randomGaussian() * 5;
        initVector.vy = randomGaussian() * 5;
        initVector.vz = randomGaussian() * 0.02;
        initVector.drag = random(10, 20);
        initVector.gravity = random(0, 100);
        index = createParticle(initVector, random(200, 1000));
        if (index != -1) {
            Particle p = particles[index];
            p.size = random(2000,5000);
            p.flicker = random(100, 500);
            p.red = skyFog[0];
            p.green = skyFog[1];
            p.blue = skyFog[2];
        } */
    }
}
