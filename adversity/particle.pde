//Array for storing particles
final int maxParticles = 10000;
Particle[] particles = new Particle[maxParticles];

int particlePointer = 0;
int particleCount = 0;

DeltaTime updateTime = new DeltaTime();

class RGBAColor {
    float r, g, b, a;

    RGBAColor(float r, float g, float b, float a) {
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }
}

//Object that encapsulates initial movement characteristics of a particle
class InitVector {
    float x, y, z;
    float vx, vy, vz;
    float drag = 10; //Higher value means more drag
    float gravity = 100;
}

class Particle {

    int id;
    float x, y, z;
    float vx, vy, vz;
    float drag = 10;
    float gravity = 10;
    float lifetime; //In ms
    float currentAge; //In ms

    float originalSize = 1000;
    float size = originalSize;
    float originalRed = 255;
    float red = 255;
    float originalGreen = 255;
    float green = 255;
    float originalBlue = 255;
    float blue = 255;
    float originalAlpha = 255;
    float alpha = 255;

    float flicker = 2; //Maximum distance the particle can flicker around it's origin
     float appX, appY, appZ; //Apparent positions used for flickering

    boolean shrinking = false; //If true, particle will shrink linearly over its lifetime
    boolean fading = true; //If true, particle will fade linearly over its lifetime

    void update(float deltaTime) {
        //Apply gravity
        vy -= (gravity/1000) * deltaTime;

        //Apply drag
        float dragActual = pow((1-(drag/10000)), deltaTime);
        vx *= dragActual;
        vy *= dragActual;
        vz *= dragActual;

        //Update position
        x += vx * deltaTime;
        y += vy * deltaTime;
        z += vz * deltaTime;

        //Update age
        currentAge += deltaTime;

        //Destroy conditions
        if (z <= 0){
            destroy();
            return;
        }
        if (y <= floorLevel) {
            vy = -vy * 0.5;
            //destroy();
            //return;
        }
        if (z >= fogDistance || z <= 100) {
            destroy();
            return;
        }
        if (currentAge > lifetime) {
            destroy();
           return; 
        }
    
        if (shrinking) {
            size = originalSize - (originalSize * (currentAge / lifetime));
        }
        if (fading) {
            alpha = originalAlpha - (originalAlpha * (currentAge / lifetime));
        }
        //Place in zBuffer for rendering if still alive
        placeInZBuffer(id, z);
    }

    void destroy() {
        particles[id] = null;
        particleCount--;
    }

    void render(boolean mirror) {

        if (flicker > 0){
            appX = x + random(-flicker, flicker);
            appY = y + random(-flicker, flicker);
            appZ = z + random(-flicker, flicker);
        }
        else {
            appX = x;
            appY = y;
            appZ = z;
        }
        if (mirror) {
            appY = floorLevel - abs(floorLevel - appY);
        }

        SSPoint screenPos = getScaledPosition(appX, appY, appZ);
        float screenX = screenPos.x;
        float screenY = screenPos.y;
        float scale = screenPos.scale;

        float fogFade = (appZ / fogDistance);
        float nr = lerp(red, skyFog[0], fogFade);
        float ng = lerp(green, skyFog[1], fogFade);
        float nb = lerp(blue, skyFog[2], fogFade);

      if (mirror){
            float heightFade = (abs(appY - floorLevel) / 20000);
            if (heightFade > 1) {
                return;
            }
            nr = lerp((255-nr), groundFog[0], heightFade);
            ng = lerp((255-ng), groundFog[1], heightFade);
            nb = lerp((255-nb), groundFog[2], heightFade);
        }
        noStroke();
        fill(nr, ng, nb, alpha);
        ellipse(screenX, screenY, size * scale, size * scale);
    }
}

void updateParticles() {
    float deltaTime = updateTime.getDeltaTime();
    for (int i = 0; i < particles.length; i++) {
        if (particles[i] != null) {
            particles[i].update(deltaTime);
        }
    }
}

void renderParticles() {
    for (int i = zBuffer.length - 1 ; i >= 0; i--) {
        for (int j = 0; j < zBufferDepth; j++) {
            if (zBuffer[i][j] != -1) {
                particles[zBuffer[i][j]].render(false);
                zBuffer[i][j] = -1;
            }
        }
    }
}

//RENDERING MIRRORED PARTICLES DOES NOT CLEAR THE ZBUFFER
void renderMirroredParticles() {
    for (int i = zBuffer.length - 1 ; i >= 0; i--) {
        for (int j = 0; j < zBufferDepth; j++) {
            if (zBuffer[i][j] != -1) {
                particles[zBuffer[i][j]].render(true);
            }
        }
    }
}

int createParticle(InitVector vector, float lifetime) {
    
    if (particleCount >= maxParticles) {
        //Too many particles
        return -1;
    }
    
    Particle p = new Particle();
    p.x = vector.x;
    p.y = vector.y;
    p.z = vector.z;
    p.vx = vector.vx;
    p.vy = vector.vy;
    p.vz = vector.vz;
    p.drag = vector.drag;
    p.gravity = vector.gravity;
    p.lifetime = lifetime;
    int slot = findEmptySlot();
    particles[slot] = p;
    p.id = slot;
    particleCount++;

    return slot;
}

int findEmptySlot() {
    for (int i = particlePointer + 1; i < particles.length; i++) {
        if (particles[i] == null) {
            particlePointer = i;
            return i;
        }
    }
    for (int i = 0; i < particlePointer; i++) {
        if (particles[i] == null) {
            particlePointer = i;
            return i;
        }
    }
    //If no empty slot found, overwrite slot 0
    return 0;
}