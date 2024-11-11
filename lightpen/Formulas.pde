class SineWave {
  float baseAmplitude;
  float actualAmplitude;
  float baseFrequency;
  float actualFrequency;
  float basePhase;
  float actualPhase;
  float x;

  SineWave(float amplitude, float frequency, float phase) {
    this.baseAmplitude = amplitude;
    this.actualAmplitude = amplitude;
    this.baseFrequency = frequency / 1000;
    this.actualFrequency = frequency / 1000;
    this.basePhase = phase;
    this.actualPhase = phase;
  }

  float getValue(float x) {
    return sineWave(x, actualAmplitude, actualFrequency, actualPhase);
  }

  float sineWave(float x, float amplitude, float frequency, float phase) {
    return actualAmplitude * sin(TWO_PI * actualFrequency * x + actualPhase);
  }

  void setAmplitude(float amplitude) {
    this.actualAmplitude = amplitude;
  }
  void setFrequency(float frequency) {
    this.actualFrequency = frequency / 1000;
  }
  void setPhase(float phase) {
    this.actualPhase = phase;
  }
}
