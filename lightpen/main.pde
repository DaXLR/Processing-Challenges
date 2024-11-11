//TODO: Change so that all lines are changes at once on every control change
import themidibus.*; 
MidiBus myBus;

int screenSizeX = 1200;
int screenSizeY = 1200;

//User-modifiable value clamps
float min_ax1Amplitude = 0.0;
float max_ax1Amplitude = 1.0;
float min_ay1Amplitude = 0.0;
float max_ay1Amplitude = 1.0;
float min_ax2Amplitude = 0.0;
float max_ax2Amplitude = 1.0;
float min_ay2Amplitude = 0.0;
float max_ay2Amplitude = 1.0;
float min_ax1Frequency = 1.0;
float max_ax1Frequency = 20.0;
float min_ay1Frequency = 1.0;
float max_ay1Frequency = 20.0;
float min_ax2Frequency = 1.0;
float max_ax2Frequency = 20.0;
float min_ay2Frequency = 1.0;
float max_ay2Frequency = 20.0;
float min_ax1Phase = 0.0;
float max_ax1Phase = TWO_PI;
float min_ay1Phase = 0.0;
float max_ay1Phase = TWO_PI;
float min_ax2Phase = 0.0;
float max_ax2Phase = TWO_PI;
float min_ay2Phase = 0.0;
float max_ay2Phase = TWO_PI;
float min_maxLines = 1;
float max_maxLines = 200;

//Input values mapped from midi
int input_ax1Amplitude = 0;
int input_ay1Amplitude = 0;
int input_ax2Amplitude = 0;
int input_ay2Amplitude = 0;
int input_ax1Frequency = 0;
int input_ay1Frequency = 0;
int input_ax2Frequency = 0;
int input_ay2Frequency = 0;
int input_ax1Phase = 0;
int input_ay1Phase = 0;
int input_ax2Phase = 0;
int input_ay2Phase = 0;
int input_maxLines = 0;
int input_r = 0;
int input_g = 0;
int input_b = 0;

//Mapped values
float mapped_r = 0;
float mapped_g = 0;
float mapped_b = 0;
int maxLines = 0;

ArrayList<Line> lines = new ArrayList<Line>();

SineWave ax1 = new SineWave((screenSizeX /2), 0, 0);
SineWave ay1 = new SineWave((screenSizeY /2 ), 0, 0);
SineWave ax2 = new SineWave((screenSizeX /2 ), 0, 0);
SineWave ay2 = new SineWave((screenSizeY /2 ), 0, 0);

void settings() {
  size(screenSizeX, screenSizeY);
}

void setup() {
  frameRate(60);
  background(0, 0, 0);

  MidiBus.list();
  myBus = new MidiBus(this, 1, -1);

  setUserValues();
}

void draw() {

background(0, 0, 0);
setUserValues();
updateLines();

}

void updateLines()
{
lines.clear();
while (lines.size() < maxLines) 
{
  lines.add(new Line(screenSizeX / 2, screenSizeY / 2, screenSizeX / 2, screenSizeY / 2, 1));
}
for (int i = 0; i < lines.size()-1; i++) {
    Line l = lines.get(i);
    l.setColor(mapped_r, mapped_g, mapped_b);
    l.offsetPoint(ax1.getValue(i), ay1.getValue(i), 1);
    l.offsetPoint(ax2.getValue(i), ay2.getValue(i), 2);
    l.render();
  }
}

/* void updateLines() {
  if (lines.size() < maxLines) {
    lines.add(new Line(screenSizeX / 2, screenSizeY / 2,
      screenSizeX / 2, screenSizeY / 2, 1));
  }
  for (int i = lines.size()-1; i > 0; i--) {
    Line l = lines.get(i);
    l.setColor(mapped_r, mapped_g, mapped_b);
    l.offsetPoint(ax1.getValue(frameCount - i), ay1.getValue(frameCount - i), 1);
    l.offsetPoint(ax2.getValue(frameCount - i), ay2.getValue(frameCount - i), 2);
    l.setFade(1.0 - (float)i / (float)maxLines);
    l.render();
  }
} */

//Maps input values to the clamped user values
void setUserValues() {
  ax1.setAmplitude((screenSizeX /2) * map(input_ax1Amplitude, 0, 127, min_ax1Amplitude, max_ax1Amplitude));
  ay1.setAmplitude((screenSizeY /2) * map(input_ay1Amplitude, 0, 127, min_ay1Amplitude, max_ay1Amplitude));
  ax2.setAmplitude((screenSizeX /2) * map(input_ax2Amplitude, 0, 127, min_ax2Amplitude, max_ax2Amplitude));
  ay2.setAmplitude((screenSizeY /2) * map(input_ay2Amplitude, 0, 127, min_ay2Amplitude, max_ay2Amplitude));
  ax1.setFrequency(map(input_ax1Frequency, 0, 127, min_ax1Frequency, max_ax1Frequency));
  ay1.setFrequency(map(input_ay1Frequency, 0, 127, min_ay1Frequency, max_ay1Frequency));
  ax2.setFrequency(map(input_ax2Frequency, 0, 127, min_ax2Frequency, max_ax2Frequency));
  ay2.setFrequency(map(input_ay2Frequency, 0, 127, min_ay2Frequency, max_ay2Frequency));
  ax1.setPhase(map(input_ax1Phase, 0, 127, min_ax1Phase, max_ax1Phase));
  ay1.setPhase(map(input_ay1Phase, 0, 127, min_ay1Phase, max_ay1Phase));
  ax2.setPhase(map(input_ax2Phase, 0, 127, min_ax2Phase, max_ax2Phase));
  ay2.setPhase(map(input_ay2Phase, 0, 127, min_ay2Phase, max_ay2Phase));
  maxLines = int(map(input_maxLines,0, 127, min_maxLines, max_maxLines));
  mapped_r = map(input_r, 0, 127, 0, 255);
  mapped_g = map(input_g, 0, 127, 0, 255);
  mapped_b = map(input_b, 0, 127, 0, 255);
}

void keyPressed() {
}
