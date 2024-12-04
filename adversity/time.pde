class DeltaTime {
    float lastTime = 0;
    DeltaTime() {
        lastTime = millis();
    }
    //Returns time in milliseconds since last time this function was called
    float getDeltaTime() {
        float currentTime = millis();
        float deltaTime = currentTime - lastTime;
        lastTime = currentTime;
        return deltaTime;
    }
}