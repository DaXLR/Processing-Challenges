void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println("noteOn: " + pitch + " " + velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println("noteOff: " + pitch + " " + velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println("controllerChange: " + number + " " + value);
  switch (number) {
    case 0:
      input_ax1Amplitude = value;
      break;
    case 1:
      input_ay1Amplitude = value;
      break;
    case 2:
      input_ax2Amplitude = value;
      break;
    case 3:
      input_ay2Amplitude = value;
      break;
    case 4:
      input_ax1Frequency = value;
      break;
    case 5:
      input_ay1Frequency = value;
      break;
    case 6:
      input_ax2Frequency = value;
      break;
    case 7:
      input_ay2Frequency = value;
      break;
    case 8:
      input_ax1Phase = value;
      break;
    case 9:
      input_ay1Phase = value;
      break;
    case 10:
      input_ax2Phase = value;
      break;
    case 11:
      input_ay2Phase = value;
      break;
    case 12:
      input_maxLines = value;
      break;
    case 13:
      input_r = value;
      break;
    case 14:
      input_g = value;
      break;
    case 15:
      input_b = value;
      break;
    default:
      break;
  }
}
