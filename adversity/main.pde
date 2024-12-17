//TODO: Create a library of objects, implement random object spawning
//TODO: Tune particle spawning frequency and behavior, upgrade particle array

DeltaTime frameTime = new DeltaTime();
float spawnChance = 10;

boolean firstTime = true;

void settings() {
  fullScreen(P2D);
}

void setup() {

  loadObjectsFromCSV();
  initScreen();
  frameRate(60);
  background(skyFog[0], skyFog[1], skyFog[2]);
}

void draw() {

if (millis() < 5000) {
  return;
}

background(skyFog[0], skyFog[1], skyFog[2]);

if (particleCount < maxParticles/2) {
  float chance = map(maxParticles/2, 0, 10000, 1, 0);
  if (random(spawnChance) < chance) {
    createRandomBolt();
  }
}

updateBolts();
updateParticles();
renderMirroredParticles();
renderParticles();

//println("Particle count = " + particleCount);
//println("Frame Time =" + frameTime.getDeltaTime());
}

void keyPressed() {
  if (key == 'n') {
  }

}

void createRandomBolt(){
    createBolt(random(-100000,100000),random(floorLevel,100000),random(0,5000), 4, 2 , 0.05, int(random(10,100)));
}

Particle createRandomParticle(){
    float randomLifetime = random(1000,10000);
    InitVector initVector = new InitVector();
    initVector.x = random(-1000000,1000000);
    initVector.y = random(300000,300000);
    initVector.z = random(0,8000);
    initVector.vx = random(-10,10);
    initVector.vy = random(-10,0);
    initVector.vz = random(-1,1);
  int index = createParticle(initVector, randomLifetime);
  if (index != -1) {
    return particles[index];
  }
  return null;
}
