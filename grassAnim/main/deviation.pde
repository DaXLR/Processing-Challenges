float initialX = 0;
float currentX = 0;
float targetX = 0;
float neutralPull = 0.02;
float wind = 0;
float chaseRatio = 0.05;
float amplitude = 20;
int rollingAverageSamples = 60;
float[] rollingAverage = new float[rollingAverageSamples];

float calculateDeviation(){
  wind = randomGaussian()*amplitude;
  float total = 0;
  for (int i = 0; i < rollingAverageSamples - 1; i++)
  {
    rollingAverage[i] = rollingAverage[i+1];
    total += rollingAverage[i];
  }
  rollingAverage[rollingAverageSamples-1] = wind;
  total += rollingAverage[rollingAverageSamples-1];
  wind = (total/rollingAverageSamples);
  wind -= ((currentX - initialX) * neutralPull);
  targetX += wind;
  currentX += ((targetX - currentX) * chaseRatio);
  return currentX;
}
