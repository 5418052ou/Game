
void setup() {
  size(600, 600);
  background(0);
  /*for (int i = 0; i < 5; i++ )
  {  
    enemy[i] = new PVector(random(0, 600), 20);
    direction[i] = new PVector(0, 2);
  }
}
*/
void draw() {
  
}


void mousePressed() {

  if (start == 3) {
    if (mousePressed && mouseX >= 200 && mouseX <= 500 && mouseY >= 400 && mouseY <= 500)
      start = 1 ;
  }
  if (start == 0 ) {
    if (mousePressed && mouseX >= 200 && mouseX <= 400 && mouseY >= 200 && mouseY <= 400)
      start = 3 ;
  }
}
void keyPressed() {
  if (key == 's') {
    lasting = 1 - lasting;
    if (lasting == 0)
      start = 1;
  }

void draw(){
  ellipse(width/2,height/2,40,40);
}
