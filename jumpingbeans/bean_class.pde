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
  float lifetimeRatio;




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

    body = color(red, green, blue, 255);
    fill(body);
    noStroke();


    //Ajustement pour convertir la position simulee en position "screenspace"
    float adjustedX = x/xlength * sideLength;
    float adjustedY = y/ylength * sideLength;
    float adjustedZ = z/zlength * sideLength;

    float XpositionAlongXaxis = A.X + (cos(rightSideAngle) * adjustedX);
    float YpositionAlongXaxis = A.Y - (sin(rightSideAngle) * adjustedX);
    float ZpositionXoffset = cos(leftSideAngle) * adjustedZ;
    float ZpositionYoffset = sin(leftSideAngle) * adjustedZ;


    float screenSpaceX = XpositionAlongXaxis - ZpositionXoffset;
    float screenSpaceY = YpositionAlongXaxis - ZpositionYoffset + adjustedY;


    ellipse(screenSpaceX, screenSpaceY, currentSize, currentSize);
  }

  void updateValues() {
    
    lifetimeRatio = lifeforce/maxLifeforce;
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
      float zpower = random(minPower, maxPower);
      float ypower = 1.5*(random(minPower, maxPower));
      stamina -= ypower + ypower; //Deduct stamina

      if (round(random(1)) == 0) {
        xpower = -xpower;
      }
      if (round(random(1)) == 0) {
        ypower = -ypower;
      }
      if (round(random(1)) == 0) {
        zpower = -zpower;
      }
      xspeed += xpower;
      yspeed += ypower;
      zspeed += zpower;
      
      patience = 0;
    } else {
      patience += eagerness;
    }
  }

  void updatePosition() {

    //Update de la vitesse verticale
    yspeed += gravity - drag;

    //Update de la vitesse en X
    if (xspeed > drag) {
      xspeed -= drag;
    } else if (xspeed < 0) {
      xspeed += drag;
    } else {
      xspeed = 0;
    }

    //Update de la vitesse en Z (profondeur)
    if (zspeed > drag) {
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
    if (z > (zlength - currentSize/2))
    {
      z = zlength - (currentSize/2);
      zspeed = -(zspeed * bounce);
      backAlpha = bounceReactValue;
    }

    if (z < (0 + (currentSize/2)))
    {
      z = 0 + (currentSize/2);
      zspeed = -(zspeed * bounce);
      frontAlpha = bounceReactValue;
    }

    //Bounce axe X
    if (x > (xlength - currentSize/2))
    {
      x = xlength - (currentSize/2);
      xspeed = -(xspeed * bounce);
      rightAlpha = bounceReactValue;
    }
    if (x < (0 + (currentSize/2)))
    {
      x = 0 + (currentSize/2);
      xspeed = -(xspeed * bounce);
      leftAlpha = bounceReactValue;
    }

    //Bounce axe Y
    if (y > (ylength - currentSize/2))
    {
      y = ylength - (currentSize/2);
      if (yspeed > gravity) {
        bottomAlpha = bounceReactValue;
      }
      yspeed = -(yspeed * bounce);
    }
    if (y < (0 + (currentSize/2)))
    {
      y = 0 + (currentSize/2);
      yspeed = -(yspeed * bounce);
      topAlpha = bounceReactValue;
    }

  //Ajustement de la taille actuelle dependamment de la position en Z
  //currentSize = baseSize * lifetimeRatio * (((0.5/zlength) * (zlength-z)) + 0.5);
  currentSize = baseSize * lifetimeRatio; 
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
    print("Position X: ");
    print(x);
    print(" Y: ");
    print(y);
    print(" Z: ");
    println(z);
  }
}
