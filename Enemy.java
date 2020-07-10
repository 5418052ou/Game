import processing.core.*;
class Enemy {
  PApplet p;
  Ball[] balls;
  Enemy(Papplet p1, int n){
    p1 = p;
    balls = new Ball[n];
    for(int i = 0; i < n; i++){
      balls[i] = new Ball(p);
    }
  }
  
  void display{
    for(int i = 0; i < balls.length; i++){
      balls[i].display();
    }
  }
}
  
