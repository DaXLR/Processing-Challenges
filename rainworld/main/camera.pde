static float toRadian = 0.0174533;
static float toDegrees = 57.2957795;

class camera {

  boolean debug = true;

  coord position = new coord(0, 0, 0); //Position du point focal et non du plan de projection
  coord result = new coord(0, 0, 0); //Objet qui est retourné lors du calcul de screenspace
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

  boolean pointToScreenSpace(coord point)
  {
    float xoffset = point.x - position.x;
    float yoffset = point.y - position.y;
    float zoffset = point.z - position.z;
    float distanceOnXYPlane = sqrt(pow(abs(xoffset), 2) + pow(abs(yoffset), 2));
    float trueDistance = sqrt(pow(distanceOnXYPlane, 2) + pow(abs(zoffset), 2));


    //Calcul de l'angle horizontal (yaw) du point par rapport au focal point
    float cartYaw = 0;
    if (xoffset == 0 && yoffset > 0) {
      cartYaw = 0;
    } else if (xoffset == 0 && yoffset < 0) {
      cartYaw = 180;
    } else if (xoffset > 0 && yoffset == 0) {
      cartYaw = 90;
    } else if (xoffset < 0 && yoffset == 0) {
      cartYaw = 270;
    } else if (xoffset > 0 && yoffset > 0) {
      cartYaw = (atan(xoffset/yoffset));
    } else if (xoffset > 0 && yoffset < 0) {
      cartYaw = (atan(abs(yoffset)/xoffset)) + PI/2;
    } else if (xoffset < 0 && yoffset < 0) {
      cartYaw = (atan(abs(xoffset)/abs(yoffset))) + PI;
    } else if (xoffset < 0 && yoffset > 0) {
      cartYaw = (atan(yoffset/abs(xoffset))) + PI*1.5;
    }
    if (cartYaw != yaw){
    cartYaw -= yaw;
    }
    if (cartYaw > PI){
    cartYaw -= 2*PI;
    }
    
    //Calcul de l'angle vertical (pitch) du point par rapport au focal point
    float cartPitch = 0;
    if (zoffset == 0) {
      cartPitch = 0;
    } else {
      cartPitch = atan(zoffset/distanceOnXYPlane);
    }
    
    float screenSpaceX = tan(abs(cartYaw))*focalLength;
    float screenSpaceY = tan(abs(cartPitch))*focalLength;
    
    if (cartYaw < 0){
      screenSpaceX = -screenSpaceX;
    }
    if (cartPitch < 0){
     screenSpaceY = -screenSpaceY; 
    }



    if (debug)
    {
      print("X offset = ");
      print(xoffset);
      print(" Y offset = ");
      print(yoffset);
      print(" Z offset = ");
      println(zoffset);
      print("Distance= ");
      print(trueDistance);
      print(" Yaw= ");
      print(cartYaw);
      print(" Pitch= ");
      println(cartPitch);
      print("Screenspace X = ");
      print(screenSpaceX);
      print(" Screenspace Y = ");
      println(screenSpaceY);
    }



    return true;
  }
}
