float gravity = 1;
float drag = 0.02;
int IDcounter = 0;
float rollTarget = 1000;

class Bean {

  int ID;
  boolean isAlive = true;
  color body;
  float baseSize;
  float currentSize;
  float bounce;
  float x, y, z, xspeed, yspeed, zspeed;
  float lifeforce, maxLifeforce;
  float stamina, maxStamina;
  float regen;
  float maxPower, minPower;
  float eagerness, patience;
  float energy, baseEnergy;
  float red, green, blue;




  Bean(int id, float initialX, float initialY, float initialZ, float initialXspeed, float initialYspeed, float initialZspeed) {

    red = random(0, 255);
    green = random(0, 255);
    blue = random(0, 255);
    body = color(red, green, blue, 255);
    ID = id;
    x = initialX;
    y = initialY;
    z = initialZ;
    xspeed = initialXspeed;
    yspeed = initialYspeed;
    zspeed = initialZspeed;
    baseSize = random(20, 100);
    currentSize = baseSize * 1.00;
    bounce = random(0.5, 0.9);
    maxLifeforce = random(50, 200);
    lifeforce = maxLifeforce;
    maxStamina = random(1, 100);
    stamina = maxStamina;
    regen = random(0.5, 5);
    minPower = random(0, 5);
    maxPower = random(10, 100);
    eagerness = random(0, 0.1);
    patience = 0;
    baseEnergy = random(2, 10);
    energy = baseEnergy;
  }
  void update(boolean isJumping)
  {
    updateValues();
    if (stamina > 0 && isJumping == true) {
      calculateJump();
    }
    updatePosition();

    //printDebug();

    float lifetimeRatio = lifeforce/maxLifeforce;
    body = color(red, green, blue, 255 * lifetimeRatio);
    fill(body);
    noStroke();
    ellipse(x, y, currentSize, currentSize);
  }

  void updateValues() {
    float lifetimeRatio = lifeforce/maxLifeforce;
    float staminaRatio = stamina/maxStamina;
    float finalRatio = ((0.3*lifetimeRatio) + (0.7*staminaRatio));
    energy = finalRatio * baseEnergy;



    lifeforce -= 0.1;
    if (stamina < maxStamina)
    {
      lifeforce -= 0.1;
      stamina += 0.1 * regen;
    }
    if (lifeforce <= 0)
    {
      isAlive = false;
    }
  }

  void calculateJump() {

    float roll = random(0, rollTarget);
    float result = roll + energy + patience;

    if (result > rollTarget) { //We get a jump
      float xpower = random(minPower, maxPower);
      float ypower = 1.5*(random(minPower, maxPower));
      stamina -= ypower + ypower; //Deduct stamina

      if (round(random(1)) == 0) {
        xpower = -xpower;
      }
      if (round(random(1)) == 0) {
        ypower = -ypower;
      }
      xspeed += xpower;
      yspeed += ypower;
      patience = 0;
    } else {
      patience += eagerness;
    }
  }

  void updatePosition() {

    //Update de la vitesse verticale
    yspeed += gravity - drag;

    //Update de la vitesse en X
    if (xspeed > 0) {
      xspeed -= drag;
    } else if (xspeed < 0) {
      xspeed += drag;
    } else {
      xspeed = 0;
    }

    //Update de la vitesse en Z (profondeur)
    if (zspeed > 0) {
      zspeed -= drag;
    } else if (zspeed < 0) {
      zspeed += drag;
    } else {
      zspeed = 0;
    }

    //Update des positions selon la vitesse
    x += xspeed;
    y += yspeed;
    z += zspeed;

    //Bounce axe Z
    if (z > depth)
    {
      z = depth;
      zspeed = -(zspeed * bounce);
    }

    if (z < 0)
    {
      z = 0;
      zspeed = -(zspeed * bounce);
    }

    //Bounce axe X
    if (x > (screenSizeX - currentSize/2))
    {
      x = (screenSizeX - currentSize/2);
      xspeed = -(xspeed * bounce);
    }
    if (x < (0 + currentSize/2))
    {
      x = 0 + currentSize/2;
      xspeed = -(xspeed * bounce);
    }

    //Bounce axe Y
    if (y > (screenSizeY - currentSize/2))
    {
      y = (screenSizeY - currentSize/2);
      yspeed = -(yspeed * bounce);
    }
    if (y < (0 + currentSize/2))
    {
      y = 0+ currentSize/2;
      yspeed = -(yspeed * bounce);
    }

    //Ajustement de la taille selon la position en Z (effet de profondeur)
    currentSize = baseSize * (z * ((1.5/depth)) + 0.25);
  }

  void printDebug()
  {
    print("ID: ");
    println(ID);
    print("Lifeforce: ");
    println(lifeforce);
    print("Stamina: ");
    println(stamina);
    print("Patience: ");
    println(patience);
    print("Energy: ");
    println(energy);
    print("Z position");
    println(z);
  }
}
