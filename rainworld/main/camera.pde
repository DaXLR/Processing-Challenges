static float toRadian = 0.0174533;
static float toDegrees = 57.2957795;

class camera {

  boolean debug = false;

  coord position = new coord(0, 0, 0); //Position du point focal et non du plan de projection
  coord result = new coord(0, 0, 0); //Objet qui store le résultat du calcul de screenspace
  coord projectorCenter = new coord(0, 0, 0); //Centre de l'écran virtuel de projection

  float yaw = 0;
  float pitch = 0;
  int camWidth = 600;
  int camHeight = 400;
  float focalLength = 50;
  float hHalfAngle = 0;
  float vHalfAngle = 0;


  camera(int w, int h, float l)
  {
    camWidth = w;
    camHeight = h;
    focalLength = l;
    projectorCenter.x = camWidth/2;
    projectorCenter.y = camHeight/2;
    calculateFOV();
  }

  void setPosition(float x, float y, float z)
  {
    position.x = x;
    position.y = y;
    position.z = z;
  }

  void calculateFOV()
  {
    hHalfAngle = atan((camWidth/2)/focalLength)*toDegrees;
    vHalfAngle = atan((camHeight/2)/focalLength)*toDegrees;
  }

  //Dans les calculs de projection focale, le point b devrait être la position du point focal de la camera
  //Le distance 'planar' est la distance de la ligne projetée sur le plan XY (ignore la hauteur). Elle sert entre autre à calculer la position angulaire par rapport à la camera

  float getDistance(coord pointa, coord pointb, boolean planar) {

    float xoffset = pointa.x - pointb.x;
    float yoffset = pointa.y - pointb.y;
    float zoffset = pointa.z - pointb.z;
    float planarDistance = sqrt(pow(abs(xoffset), 2) + pow(abs(yoffset), 2));
    float trueDistance = sqrt(pow(planarDistance, 2) + pow(abs(zoffset), 2));

    if (debug)
    {
      print("X offset = ");
      print(xoffset);
      print(" Y offset = ");
      print(yoffset);
      print(" Z offset = ");
      print(zoffset);
      print(" Planar Distance= ");
      print(planarDistance);
      print(" True Distance= ");
      println(trueDistance);
    }


    if (planar) {
      return planarDistance;
    } else {
      return trueDistance;
    }
  }

  float getRelativeYaw(coord target, coord source, float sourceYaw) {

    float xoffset = target.x - source.x;
    float yoffset = target.y - source.y;
    float yaw = 0;

    if (xoffset == 0 && yoffset > 0) {
      yaw = 0;
    } else if (xoffset == 0 && yoffset < 0) {
      yaw = PI;
    } else if (xoffset > 0 && yoffset == 0) {
      yaw = PI/2;
    } else if (xoffset < 0 && yoffset == 0) {
      yaw = PI*1.5;
    } else if (xoffset > 0 && yoffset > 0) {
      yaw = (atan(xoffset/yoffset));
    } else if (xoffset > 0 && yoffset < 0) {
      yaw = (atan(abs(yoffset)/xoffset)) + PI/2;
    } else if (xoffset < 0 && yoffset < 0) {
      yaw = (atan(abs(xoffset)/abs(yoffset))) + PI;
    } else if (xoffset < 0 && yoffset > 0) {
      yaw = (atan(yoffset/abs(xoffset))) + PI*1.5;
    }
    if (yaw != sourceYaw) {
      yaw -= sourceYaw;
    }
    if (yaw > PI) {
      yaw -= 2*PI;
    }

    if (debug) {
      print("Yaw= ");
      println(yaw);
    }

    return yaw;
  }

  float getRelativePitch(coord target, coord source, float sourcePitch) {

    float zoffset = target.z - source.z;

    float pitch = 0;
    if (zoffset == 0) {
      pitch = 0;
    } else {
      pitch = atan(zoffset/getDistance(target, source, true));
    }
    pitch = sourcePitch - pitch;


    if (debug) {
      print("Pitch= ");
      println(pitch);
    }

    return pitch;
  }


  boolean pointToScreenSpace(coord point)
  {

    float cartesianYaw = getRelativeYaw(point, position, yaw);
    if (cartesianYaw > PI/2 || cartesianYaw < -PI/2) {
      //Le point est derriere la camera
      return false;
    }
    float cartesianPitch = getRelativePitch(point, position, pitch);
    if (cartesianPitch > PI/2 || cartesianPitch < -PI/2) {
      //Le point est derriere la camera
      return false;
    }

    float screenSpaceX = tan(abs(cartesianYaw))*focalLength;
    float screenSpaceY = tan(abs(cartesianPitch))*focalLength;

    if (cartesianYaw < 0) {
      screenSpaceX = -screenSpaceX;
    }
    if (cartesianPitch < 0) {
      screenSpaceY = -screenSpaceY;
    }

    result.x = screenSpaceX;
    result.y = screenSpaceY;

    if (debug)
    {
      print("Screenspace X = ");
      print(screenSpaceX);
      print(" Screenspace Y = ");
      println(screenSpaceY);
    }

    return true;
  }
}