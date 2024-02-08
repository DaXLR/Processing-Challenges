//Variables de mouvement
boolean movingForward = false;
boolean movingBack = false;
boolean movingLeft = false;
boolean movingRight = false;
boolean tiltRight = false;
boolean tiltLeft = false;
boolean tiltUp = false;
boolean tiltDown = false;

float speed = 10;
float tiltSpeed = 0.05;

void move() {
  if (movingForward)
  {
    cam.move(0, speed, 0, 0, 0);
  }
  if (movingLeft)
  {
    cam.move(-speed, 0, 0, 0, 0);
  }
  if (movingBack)
  {
    cam.move(0, -speed, 0, 0, 0);
  }
  if (movingRight)
  {
    cam.move(speed, 0, 0, 0, 0);
  }
  if (tiltLeft)
  {
    cam.move(0, 0, 0, -tiltSpeed, 0);
  }
  if (tiltRight)
  {
    cam.move(0, 0, 0, tiltSpeed, 0);
  }
  if (tiltUp)
  {
    cam.move(0, 0, 0, 0, tiltSpeed);
  }
  if (tiltDown)
  {
    cam.move(0, 0, 0, 0, -tiltSpeed);
  }
}


void keyPressed()
{
  if (key == 'w')
  {
    movingForward = true;
  }
  if (key == 'a')
  {
    movingLeft = true;
  }
  if (key == 's')
  {
    movingBack= true;
  }
  if (key == 'd')
  {
    movingRight = true;
  }
  if (key == 'j')
  {
    tiltLeft = true;
  }
  if (key == 'l')
  {
    tiltRight = true;
  }
  if (key == 'i')
  {
    tiltUp = true;
  }
  if (key == 'k')
  {
    tiltDown = true;
  }
}

void keyReleased()
{
  if (key == 'w')
  {
    movingForward = false;
  }
  if (key == 'a')
  {
    movingLeft = false;
  }
  if (key == 's')
  {
    movingBack= false;
  }
  if (key == 'd')
  {
    movingRight = false;
  }
  if (key == 'j')
  {
    tiltLeft = false;
  }
  if (key == 'l')
  {
    tiltRight = false;
  }
  if (key == 'i')
  {
    tiltUp = false;
  }
  if (key == 'k')
  {
    tiltDown = false;
  }
}
