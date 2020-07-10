import processing.core.*;
class Ball {
  int x, y, size = 10;
  PApplet p;
  Ball(PApplet p0) {
    p0 = p;
    y = 10;
    x = int(random(0, 500);
  }
  void display() {
    p.ellipse(x, y, size, size);
  }
}
  
